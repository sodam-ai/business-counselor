# frontmatter-linter.ps1
# data/ 폴더 내 모든 .md 파일의 frontmatter 필수 필드를 "파일 유형별"로 검증한다.
# (frontmatter-linter.sh 의 PowerShell 미러 — Git Bash 없이 Windows 네이티브로 검증)
#
# 검증 규칙 (02_DATA_MODEL.md 정합, 2026-08-04 수정 — evaluated/와 generated/ 필드셋 분리):
#   - 모든 .md (프로필·세션·리서치 등): disclaimer + schema_version
#   - ideas/evaluated/ (EvaluatedIdea, AI 판독 출력):
#       위 + success_criteria + consistency_score + model_id + temperature + debate_mode
#   - ideas/generated/ (GeneratedIdea, AI 추천 출력 — 적대 토론·verdict 단계 없음):
#       위 + model_id + temperature만 (success_criteria·consistency_score·debate_mode 의도적 제외,
#       02_DATA_MODEL.md 2026-08-03 정정 참조)
#
# 사용법: powershell -File tests\frontmatter-linter.ps1 [data_dir]
#   또는: pwsh tests/frontmatter-linter.ps1 [data_dir]

param(
  [string]$DataDir = "$env:USERPROFILE\Documents\business-counselor"
)

# 출력 메시지는 ASCII 전용 (Windows PowerShell 5.1 cp949 콘솔에서 한글 mojibake 방지).
# 스크립트 동작/exit code는 동일, 화면 글자만 영문으로.

$BaseFields = @('disclaimer', 'schema_version')
$EvalExtra  = @('success_criteria', 'consistency_score', 'model_id', 'temperature', 'debate_mode')
$GenExtra   = @('model_id', 'temperature')

if (-not (Test-Path -LiteralPath $DataDir)) {
  Write-Output "INFO: data directory not found - no evaluation files yet (OK)"
  exit 0
}

$files = Get-ChildItem -Path $DataDir -Recurse -Filter *.md -File -ErrorAction SilentlyContinue
$count = 0
$fail  = $false

foreach ($f in $files) {
  $count++
  $content = Get-Content -LiteralPath $f.FullName -Raw

  # 파일 유형 판별: evaluated/=6필드 전체, generated/=model_id+temperature만, 그 외=기본 2필드
  $path = $f.FullName -replace '\\', '/'
  if ($path -match '/ideas/evaluated/') {
    $required = $BaseFields + $EvalExtra
  } elseif ($path -match '/ideas/generated/') {
    $required = $BaseFields + $GenExtra
  } else {
    $required = $BaseFields
  }

  foreach ($field in $required) {
    # 줄 시작의 'field:' 패턴 (frontmatter 키). (?m) = 멀티라인, ^ = 각 줄 시작
    $pattern = "(?m)^" + [regex]::Escape($field) + ":"
    if ($content -notmatch $pattern) {
      Write-Output "FAIL: $($f.FullName) - missing field '$field'"
      $fail = $true
    }
  }
}

if ($count -eq 0) {
  Write-Output "INFO: no .md files to check (OK)"
  exit 0
}

if (-not $fail) {
  Write-Output "PASS: all $count file(s) have required fields by type"
  exit 0
} else {
  exit 1
}
