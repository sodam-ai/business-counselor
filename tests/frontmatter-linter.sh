#!/bin/bash
# frontmatter-linter.sh
# data/ 폴더 내 모든 .md 파일에 필수 6필드 존재 여부 확인
# 사용법: bash tests/frontmatter-linter.sh [data_dir]
# 예시:   bash tests/frontmatter-linter.sh data/

REQUIRED_FIELDS="disclaimer success_criteria consistency_score model_id temperature debate_mode"
DATA_DIR="${1:-$HOME/.claude/plugins/business-counselor/data}"
FAIL=0
COUNT=0

if [ ! -d "$DATA_DIR" ]; then
  echo "INFO: data 디렉토리 없음 — 평가 파일 미생성 상태 (정상)"
  exit 0
fi

for f in $(find "$DATA_DIR" -name "*.md" 2>/dev/null); do
  COUNT=$((COUNT + 1))
  for field in $REQUIRED_FIELDS; do
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

[ $FAIL -eq 0 ] && echo "PASS: 모든 파일($COUNT개) 6필드 확인 완료" || exit 1
