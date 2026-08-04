#!/bin/bash
# frontmatter-linter.sh
# data/ 폴더 내 모든 .md 파일의 frontmatter 필수 필드를 "파일 유형별"로 검증한다.
#
# 검증 규칙 (02_DATA_MODEL.md 정합, 2026-08-04 수정 — evaluated/와 generated/ 필드셋 분리):
#   - 모든 .md (프로필·세션·리서치 등): disclaimer + schema_version
#   - ideas/evaluated/ (EvaluatedIdea, AI 판독 출력):
#       위 + success_criteria + consistency_score + model_id + temperature + debate_mode
#   - ideas/generated/ (GeneratedIdea, AI 추천 출력 — 적대 토론·verdict 단계 없음):
#       위 + model_id + temperature만 (success_criteria·consistency_score·debate_mode 의도적 제외,
#       02_DATA_MODEL.md 2026-08-03 정정 참조)
#
# 사용법: bash tests/frontmatter-linter.sh [data_dir]
# 예시:   bash tests/frontmatter-linter.sh data/

BASE_FIELDS="disclaimer schema_version"
EVAL_EXTRA="success_criteria consistency_score model_id temperature debate_mode"
GEN_EXTRA="model_id temperature"
DATA_DIR="${1:-$HOME/Documents/business-counselor}"
FAIL=0
COUNT=0

if [ ! -d "$DATA_DIR" ]; then
  echo "INFO: data 디렉토리 없음 — 평가 파일 미생성 상태 (정상)"
  exit 0
fi

# for 루프 사용(파이프 while 금지): 파이프 while은 서브셸에서 돌아 카운터가 사라짐
for f in $(find "$DATA_DIR" -name "*.md" 2>/dev/null); do
  COUNT=$((COUNT + 1))

  # 파일 유형 판별: evaluated/=6필드 전체, generated/=model_id+temperature만, 그 외=기본 2필드
  case "$f" in
    */ideas/evaluated/*)
      REQUIRED="$BASE_FIELDS $EVAL_EXTRA" ;;
    */ideas/generated/*)
      REQUIRED="$BASE_FIELDS $GEN_EXTRA" ;;
    *)
      REQUIRED="$BASE_FIELDS" ;;
  esac

  for field in $REQUIRED; do
    if ! grep -q "^${field}:" "$f"; then
      echo "FAIL: $f 에 '${field}' 필드 없음"
      FAIL=1
    fi
  done
done

if [ $COUNT -eq 0 ]; then
  echo "INFO: 검사할 .md 파일 없음 (정상)"
  exit 0
fi

[ $FAIL -eq 0 ] && echo "PASS: 모든 파일($COUNT개) 유형별 필수 필드 확인 완료" || exit 1
