#!/bin/bash
# frontmatter-linter.sh
# data/ 폴더 내 모든 .md 파일의 frontmatter 필수 필드를 "파일 유형별"로 검증한다.
#
# 검증 규칙 (02_DATA_MODEL.md 정합):
#   - 모든 .md (프로필·세션·리서치 등): disclaimer + schema_version
#   - ideas/evaluated/, ideas/generated/ (AI 판독·추천 출력):
#       위 + success_criteria + consistency_score + model_id + temperature + debate_mode
#
# 사용법: bash tests/frontmatter-linter.sh [data_dir]
# 예시:   bash tests/frontmatter-linter.sh data/

BASE_FIELDS="disclaimer schema_version"
EVAL_EXTRA="success_criteria consistency_score model_id temperature debate_mode"
DATA_DIR="${1:-$HOME/.claude/plugins/business-counselor/data}"
FAIL=0
COUNT=0

if [ ! -d "$DATA_DIR" ]; then
  echo "INFO: data 디렉토리 없음 — 평가 파일 미생성 상태 (정상)"
  exit 0
fi

# for 루프 사용(파이프 while 금지): 파이프 while은 서브셸에서 돌아 카운터가 사라짐
for f in $(find "$DATA_DIR" -name "*.md" 2>/dev/null); do
  COUNT=$((COUNT + 1))

  # 파일 유형 판별: AI 출력(평가·추천)이면 6필드 전체, 그 외 데이터 파일은 기본 2필드
  case "$f" in
    */ideas/evaluated/*|*/ideas/generated/*)
      REQUIRED="$BASE_FIELDS $EVAL_EXTRA" ;;
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
