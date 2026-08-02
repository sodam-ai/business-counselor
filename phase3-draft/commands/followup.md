---
name: business-counselor:followup
description: 과거 평가 재방문 — 시장 변화를 반영해 재검색 후 비교 (Phase 3, 외부 API 호출)
version: "0.1.0-draft"
---

# /business-counselor:followup

> ⚠️ **DRAFT — 미활성 상태**. `phase3-draft/commands/`에 있어 `plugin.json`에 연결되지 않았습니다.
> **활성화 조건**: `commands/research.md`와 동일 — Phase 2 실사용 확인 + PII 마스킹 검증 후에만 이동·활성화.

## 목적

과거 `/business-counselor:evaluate`로 판독한 아이디어(`eval-*`)를 시간이 지난 뒤 재방문해, 최신 시장 리서치와
비교한다. 내부적으로 `/business-counselor:research`와 동일한 외부 호출 경로를 사용한다.

## 입력

```
/business-counselor:followup <eval-id>
```

- `<eval-id>` 없으면: "재방문할 평가 ID를 입력하세요. 예: /business-counselor:followup eval-2026-07-27-002" 출력 후 중단
- `eval-`로 시작하지 않으면: "followup은 평가(eval-*)만 지원합니다. 추천 아이디어는 재검색 없이 /business-counselor:decide로 직접 결정하세요." 출력 후 중단
- `ideas/evaluated/`에서 매칭 파일 없으면: "해당 ID를 찾을 수 없습니다: {id}" 출력 후 중단 (show.md와 동일 패턴)

---

## Step 1: 대상 평가 로드 + 검색어 자동 구성

```
1. 매칭된 eval-*.md의 title·domain 필드를 읽어 검색어 자동 구성 (예: title="부동산 매물 AI 매칭" → "{domain} 시장 2026")
2. 자동 구성된 검색어에도 `/business-counselor:research`의 Step 1 PII 필터를 동일하게 적용
```

## Step 2~4: 비용 확인 → 월 한도 확인 → bc-market-researcher 호출

`/business-counselor:research`의 Step 2~4와 **완전히 동일한 절차**를 그대로 따른다(중복 구현 금지, 로직 참조).

## Step 5: 비교 출력 (신규 파일 생성 없이 화면 요약만)

```
## {eval-id} 재방문 비교

| 항목 | 최초 판독 시점 | 지금 |
|---|---|---|
| 시장 상황 | (원래 §1~§5 요약) | {신규 research tldr} |

권고: {유지/재검토 필요} — {1문장 근거}
```

- 새 `research/*.md`는 Step 2~4에서 생성되지만, 원본 `eval-*.md` 파일 자체는 **수정하지 않는다**(불변성 유지 —
  Phase 1부터 이어진 "평가 결과는 사후 수정 안 함" 원칙과 일치)
- 사용자가 반영을 원하면 `/business-counselor:decide {eval-id} iterate "재방문 결과: ..."`로 별도 기록

## 완료 메시지

```
{eval-id} 재방문 완료. 위 비교표 참고.
결정을 갱신하려면: /business-counselor:decide {eval-id} <go|drop|iterate|defer> "재방문 참고"
```
