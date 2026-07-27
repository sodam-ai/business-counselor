# 검증 결과 기록 템플릿 — Phase 1 시나리오 6건

> 사용법: 이 파일을 `tests/results/2026-MM-DD_run-NNN.md`로 복사한 뒤 채운다.
> (`tests/results/`는 .gitignore 처리됨 — 로컬 기록용)
> 시나리오 정의 원본: `tests/manual-scenarios.md`

- 실행일:
- 실행자:
- 플러그인 버전: v0.5.0
- 설치 경로: `~/.claude/plugins/business-counselor/`

---

## 사전: 린터 사전 점검 (택1)

```bash
bash tests/frontmatter-linter.sh ~/Documents/business-counselor        # Git Bash
```
```powershell
powershell -File tests\frontmatter-linter.ps1 $env:USERPROFILE\Documents\business-counselor   # Windows
```
- [ ] 결과(PASS/FAIL/INFO):

---

## 시나리오별 결과

| # | 시나리오 | 명령 | PASS/FAIL | 메모 |
|---|---------|------|-----------|------|
| 1 | 첫 인터뷰 (Cold start) | `/business-counselor:start` | ☐ | profile.md·sessions/ 생성, frontmatter(disclaimer 포함) |
| 2 | 이어서 (Resume) | `/business-counselor:resume` | ☐ | 재질문 0건, last_updated 갱신 |
| 3 | 모호 아이디어 | `/business-counselor:evaluate "AI로 뭔가 해보고 싶어"` | ☐ | 보강질문 1~2개, 자동가정 0 |
| 4 | 명확 아이디어 5단계 (핵심) | `/business-counselor:evaluate "..."` | ☐ | 한눈 요약 카드·§1~§5 분리·§4 확률+완화책·verdict·면책·분량(깊이우선)·단일호출 |
| 5 | 환경 무결성 | (아래 스냅샷) | ☐ | CLAUDE.md·MEMORY.md·persona·hook diff 0 |
| 6 | 프로필 수정·삭제 (edit) | `/business-counselor:edit "..."` | ☐ | 확인 질문 필수·취소 정상동작·전체삭제 시 평가기록은 보존 |

---

## 시나리오 5 — 환경 무결성 스냅샷 (1차/2차 비교)

명령 실행 전(1차)·후(2차)로 아래를 비교해 변경 0을 확인:

```powershell
# 글로벌 환경 파일 해시 (1차/2차 동일해야 함)
# 주의: 아래 memory 경로는 실행 시점의 실제 프로젝트 폴더로 매번 확인할 것
#   (프로젝트 폴더명이 바뀌면 경로도 바뀜 — 예: C--Users-PC ≠ 예전 D--AI-Tool-CLI-LLM-Claude-Code.
#    Get-ChildItem $env:APPDATA\claude-code\projects\ 로 현재 폴더명 먼저 확인)
Get-FileHash $env:USERPROFILE\.claude\CLAUDE.md
Get-FileHash $env:USERPROFILE\.claude\settings.json
Get-FileHash $env:APPDATA\claude-code\settings.json -ErrorAction SilentlyContinue
Get-ChildItem $env:APPDATA\claude-code\projects\C--Users-PC\memory\*.md | Get-FileHash
# sodam-persona 플러그인 자체 데이터(user_persona*.md 원본)는 위 memory 폴더가 아니라
# 플러그인 캐시 폴더에 있을 수 있음 — `claude plugin list`로 정확한 위치 재확인 후 해시
```

- [ ] `~/.claude/CLAUDE.md` 변경 0
- [ ] `MEMORY.md`·`user_persona*.md` 변경 0
- [ ] `settings.json`(SessionStart·UserPromptSubmit hook) 변경 0
- [ ] AGENTS.md가 홈/프로젝트 루트에 생성되지 않음 (플러그인 폴더 내에만)
- [ ] `/business-counselor:*` 5개·`bc-idea-evaluator` 이름 충돌 0

---

## 통합 판정

- [ ] 시나리오 1~6 모두 PASS (6/6)
- [ ] 6건 누적 외부 API 호출 0
- [ ] 6건 누적 추가 서브에이전트 호출 0 (bc-idea-evaluator 1회/평가, edit는 서브에이전트 미사용)
- 최종:  ☐ PASS  /  ☐ FAIL
- 후속 조치:
