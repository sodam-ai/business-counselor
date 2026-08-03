---
name: business-counselor:show
description: 특정 평가 재조회 — 평가 ID로 전체 내용 출력
version: "1.0"
---

# /business-counselor:show

## 목적

평가 ID를 입력받아 `~/Documents/business-counselor/ideas/evaluated/` 에서 해당 파일을 찾아
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

2. ID 분기 (2026-08-03 추가 — Phase 2 GeneratedIdea 대응, decide.md와 동일 규칙)
   - id가 "eval-"로 시작하면 -> ~/Documents/business-counselor/ideas/evaluated/ 에서 검색
   - id가 "idea-"로 시작하면 -> ~/Documents/business-counselor/ideas/generated/ 에서 검색
   - 둘 다 아니면: "알 수 없는 ID 형식입니다: {ID} (eval-* 또는 idea-* 형식이어야 합니다)" 출력 후 중단
   - 매칭 파일 없으면: "해당 ID를 찾을 수 없습니다: {ID}" 출력 후 중단

3. 파일 전체 내용 출력
```

## ID 매칭 규칙

| 입력 ID | 검색 폴더 | 파일명 패턴 |
|---------|----------|-----------|
| eval-2026-05-08-001 | ideas/evaluated/ | 2026-05-08_eval-001.md |
| idea-2026-08-03-001 | ideas/generated/ | 2026-08-03_idea-001.md |

- ID 형식: `eval-{YYYY-MM-DD}-{NNN}` (판독 결과) 또는 `idea-{YYYY-MM-DD}-{NNN}` (추천 아이디어)
- 파일명 형식: `{YYYY-MM-DD}_eval-{NNN}.md` 또는 `{YYYY-MM-DD}_idea-{NNN}.md`

## 출력

해당 파일의 전체 내용을 그대로 출력한다. ID 유형에 따라 구조가 다르다:

- **eval-\* (판독 결과)**: frontmatter(EvaluatedIdea 전체 필드) + § 1. 13명 다관점 평가 + § 2. Lean Canvas
  + § 3. Mom Test 검증 질문 5개 + § 4. Pre-mortem 시나리오 + § 5. 적대 토론
- **idea-\* (추천 아이디어)**: frontmatter(GeneratedIdea 전체 필드) + Lean Canvas 9블록

## 파일 없음 메시지

```
해당 ID를 찾을 수 없습니다: {입력 ID}

저장된 기록 목록을 확인하려면:
  /business-counselor:list
```
