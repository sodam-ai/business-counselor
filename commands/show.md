---
name: business-counselor:show
description: 특정 평가 재조회 — 평가 ID로 전체 내용 출력
version: "1.0"
---

# /business-counselor:show

## 목적

평가 ID를 입력받아 `~/.claude/plugins/business-counselor/data/ideas/evaluated/` 에서 해당 파일을 찾아
전체 내용(frontmatter + §1~§5)을 출력한다.

## 입력

```
/business-counselor:show {ID}
예: /business-counselor:show eval-2026-05-08-001
```

## 실행 절차

```
1. 입력 ID 파싱
   - ID가 없으면: "ID를 입력하세요. 예: /business-counselor:show eval-2026-05-08-001" 출력 후 중단

2. ~/.claude/plugins/business-counselor/data/ideas/evaluated/ 폴더에서 ID 매칭 파일 검색
   - 파일 없으면: "해당 ID의 평가를 찾을 수 없습니다: {ID}" 출력 후 중단

3. 파일 전체 내용 출력
```

## ID 매칭 규칙

| 입력 ID | 파일명 패턴 |
|---------|-----------|
| eval-2026-05-08-001 | 2026-05-08_eval-001.md |
| eval-2026-05-08-002 | 2026-05-08_eval-002.md |

- ID 형식: `eval-{YYYY-MM-DD}-{NNN}`
- 파일명 형식: `{YYYY-MM-DD}_eval-{NNN}.md`

## 출력

해당 파일의 전체 내용을 그대로 출력:
- frontmatter (모든 16필드)
- § 1. 13명 다관점 평가
- § 2. Lean Canvas
- § 3. Mom Test 검증 질문 5개
- § 4. Pre-mortem 시나리오 3개
- § 5. 적대 토론

## 파일 없음 메시지

```
해당 ID의 평가를 찾을 수 없습니다: {입력 ID}

저장된 평가 목록을 확인하려면:
  /business-counselor:list
```
