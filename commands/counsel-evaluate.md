---
name: counsel:evaluate
description: 아이디어 5단계 냉철 판독 — 13명 다관점·Lean Canvas·Mom Test·Pre-mortem·적대 토론 단일 호출
version: "1.0"
---

# /counsel:evaluate

## 목적

입력받은 아이디어를 `bc-idea-evaluator` 에이전트로 **1회 단일 호출**하여
§1~§5 냉철 판독 결과를 생성하고 저장한다.

## 입력

```
/counsel:evaluate "아이디어 내용"
```

아이디어 텍스트는 따옴표 안에 자유 형식으로 입력.

---

## Step 1: 모호성 감지 및 명확화

아이디어를 받은 즉시 아래 기준으로 모호성을 판단한다:

### 모호 판단 기준

| 유형 | 예시 | 처리 |
|------|------|------|
| 타겟 고객 불명확 | "AI로 뭔가 해보고 싶어" | 보강 질문 필요 |
| 문제·해결책 없음 | "헬스케어 앱" | 보강 질문 필요 |
| 구체적인 아이디어 | "자영업자 대상 AI 세금 신고 도우미 SaaS" | 즉시 Step 2 진행 |

### 보강 질문 규칙

- **최대 2개** (3개+ 금지 — 사용자 피로)
- 질문 유형: "어떤 문제를 해결하나요?" / "주요 타겟 고객은 누구인가요?"
- **자동 가정 진행 절대 금지**: 모호한 상태에서 bc-idea-evaluator 호출 금지
- 보강 질문 완료 후에만 Step 2 진행

---

## Step 2: 프로필 컨텍스트 준비

```
1. ~/.claude/plugins/business-counselor/data/profile.md 존재 여부 확인
   - 없으면: "프로필이 없습니다. /counsel:start 로 인터뷰를 먼저 진행하세요.
             프로필 없이도 평가를 진행하시겠습니까?" 확인 후 진행
   - 있으면: ~/.claude/plugins/business-counselor/data/profile.md 전체 내용 로드
```

---

## Step 3: bc-idea-evaluator 호출 (1회만)

`agents/bc-idea-evaluator.md` 에이전트를 **정확히 1회** 호출한다.

```
호출 형식:
아이디어: {명확화된 아이디어 원문}
모드: {입력에 "전체"·"상세"·"full"·"detail"·--full 있으면 "전체", 없으면 "기본(카드)"}
프로필 컨텍스트: {~/.claude/plugins/business-counselor/data/profile.md 전체 내용 또는 "(프로필 없음)"}
```

### 단일 호출 강제

- 에이전트 분리 호출: **절대 금지**
- Bull·Bear·Judge 별도 호출: **절대 금지**
- 추가 에이전트 연속 호출: **절대 금지**
- bc-idea-evaluator 1회 응답으로 §1~§5 전부 완료

---

## Step 4: 결과 저장

bc-idea-evaluator 응답을 `~/.claude/plugins/business-counselor/data/ideas/evaluated/` 에 저장한다.

### 파일명 규칙

```
~/.claude/plugins/business-counselor/data/ideas/evaluated/{YYYY-MM-DD}_eval-{NNN}.md
```

- `YYYY-MM-DD`: 오늘 날짜
- `NNN`: 당일 순번 — **그날 `evaluated/`의 기존 `eval-NNN` 중 가장 큰 번호 + 1** (파일 없으면 001). ⚠️ "파일 *수* + 1" 금지(중간 삭제 시 충돌·덮어쓰기 발생)
- 예: `2026-05-08_eval-001.md`

### ID 규칙

frontmatter `id` 필드:
```yaml
id: eval-{YYYY-MM-DD}-{NNN}
```
예: `eval-2026-05-08-001`

### 저장 내용

bc-idea-evaluator가 출력한 전체 내용 (frontmatter + §1~§5 본문) 그대로 저장.
수정 없이 원본 출력을 파일에 기록.

---

## 출력 분량 (깊이 우선)

브레비티는 「한눈 요약」 카드가 담당한다. §1~§5 본문은 **분석 깊이·근거를 깎지 말 것.**
줄이는 대상은 불필요한 반복·중복뿐(특히 frontmatter bull/bear와 §5 본문 중복).
`< 6,000 토큰`은 강제가 아닌 가이드(과도한 장황함만 방지). 깊이와 충돌하면 깊이 우선.

---

## 완료 메시지

```
평가 완료.
저장 위치: ~/.claude/plugins/business-counselor/data/ideas/evaluated/{YYYY-MM-DD}_eval-{NNN}.md
ID: eval-{YYYY-MM-DD}-{NNN}
verdict: {go|iterate|no-go}  |  confidence: {N}

전체 상세(13명·Lean Canvas·Mom Test·Pre-mortem·적대 토론) 보기:
  - 기본(카드)으로 봤으면 → /counsel:evaluate "아이디어" 전체  (전체 생성)
  - 전체 모드로 봤으면   → /counsel:show eval-{...}  (저장된 전체 열람)
과거 평가 목록: /counsel:list
이 평가 다시 보기: /counsel:show eval-{YYYY-MM-DD}-{NNN}
```
