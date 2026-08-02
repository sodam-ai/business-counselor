---
name: business-counselor:decide
description: 아이디어 결정 기록 — go/drop/iterate/defer → decisions.jsonl (Phase 2)
version: "1.0"
---

# /business-counselor:decide

## 목적

특정 아이디어(추천 또는 판독)에 대한 사용자의 결정을 `decisions.jsonl`에 append-only로 1줄 추가한다.

## 입력

```
/business-counselor:decide <id> <go|drop|iterate|defer> ["메모"]
```

예:
- `/business-counselor:decide idea-2026-08-02-001 go "고객 인터뷰 10명 완료, 진행 결정"`
- `/business-counselor:decide eval-2026-07-27-002 iterate`

---

## Step 1: 입력 검증

```
1. <id> 없으면: "ID를 입력하세요. 예: /business-counselor:decide idea-2026-08-02-001 go" 출력 후 중단
2. <action>이 없거나 go/drop/iterate/defer 중 하나가 아니면:
   "결정은 go/drop/iterate/defer 중 하나여야 합니다" 출력 후 중단
```

## Step 2: ID 분기 및 존재 확인

**ID 분기 규칙** (2026-08-02 `PRD/03_PHASES.md`에 사전 명시된 규칙 적용):

```
- id가 "eval-"로 시작하면 -> ~/Documents/business-counselor/ideas/evaluated/ 에서 검색
- id가 "idea-"로 시작하면 -> ~/Documents/business-counselor/ideas/generated/ 에서 검색
- 둘 다 아니면: "알 수 없는 ID 형식입니다: {id} (eval-* 또는 idea-* 형식이어야 합니다)" 출력 후 중단
- 매칭 파일 없으면: "해당 ID를 찾을 수 없습니다: {id}" 출력 후 중단 (show.md와 동일 패턴)
```

## Step 3: decisions.jsonl에 1줄 추가 (append-only)

```json
{"timestamp":"{ISO 8601}","idea_id":"{id}","action":"{go|drop|iterate|defer}","note":"{메모 또는 빈 문자열}","next_review":"{iterate/defer일 때만 +14일 후 날짜, 그 외 null}"}
```

- **기존 줄은 절대 수정·삭제하지 않는다** (append-only, `decide` 실행 이력이 감사 기록 역할)
- `timestamp`: 현재 시각 ISO 8601
- 파일이 없으면 새로 생성
- `note` 생략 시 빈 문자열로 기록(필수 아님)

## 완료 메시지

```
결정 기록 완료: {id} -> {action}
decisions.jsonl에 추가됨: ~/Documents/business-counselor/decisions.jsonl

과거 결정 이력 확인: /business-counselor:show {id}
```
