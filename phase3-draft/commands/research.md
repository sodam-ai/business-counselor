---
name: business-counselor:research
description: 외부 시장 리서치(시장규모·경쟁사·트렌드) 수집 — deep-research 또는 WebSearch 폴백, 명시 호출 시만 (Phase 3)
version: "0.1.0-draft"
---

# /business-counselor:research

> ⚠️ **DRAFT — 미활성 상태**. `phase3-draft/commands/`에 있어 `plugin.json`에 연결되지 않았습니다.
> **활성화 조건**: Phase 2(`recommend`/`decide`)가 실제로 최소 1회 이상 사용된 뒤 + PII 마스킹 로직 실측 검증 후에만 `commands/research.md`로 이동·활성화할 것. (`CHECKPOINT.md` M4 참조)

## 목적

이 플러그인에서 **처음으로 외부 API를 호출**하는 명령이다. `<topic>`으로 시장규모·경쟁사·트렌드를 검색해 `research/*.md`로 캐시한다.

## 입력

```
/business-counselor:research <topic>
```

- `<topic>` 없으면: "검색할 주제를 입력하세요. 예: /business-counselor:research 한국 부동산 AI 시장 2026" 출력 후 중단

---

## Step 1: 개인정보 포함 여부 점검 (PII 사전 차단)

`<topic>`에 아래 패턴이 감지되면 **실행하지 않고** 재입력을 요청한다:

```
- 구체적 금액 표현 (예: "5천만원", "3억") — 사용자 자본금(capital_krw) 유출 가능성
- "내", "제", "나의" + 소유 표현 — 개인 특정 문맥
- 생년/나이 숫자 + "살"/"년생"
```

- 감지 시: "개인정보로 보이는 표현이 포함되어 있습니다. 일반적인 시장 용어로만 다시 입력해주세요.
  예: '내 5천만원으로 부동산 AI' (X) → '한국 부동산 AI 시장 2026' (O)" 출력 후 중단
- **이 필터는 보조 수단이다** — 완벽한 PII 차단을 보장하지 않으므로, 아래 Step 2 확인 질문이 최종 방어선이다

## Step 2: 비용 확인 (매 호출마다 — PRD의 "첫 호출 시"보다 강한 기본값)

```
"'{topic}'에 대해 외부 검색을 실행합니다. 비용이 발생할 수 있고, 검색어가 외부 서비스로 전송됩니다.
계속하시겠습니까? (네/아니요)"
```

- "아니요" 또는 불명확한 답변 → 중단, 아무 것도 저장·호출하지 않음
- "네"로 명확히 확인된 경우에만 다음 단계 진행
- **설계 근거**: PRD 원문은 "첫 외부 호출 시"만 강제하지만, 매 호출마다 실비용이 발생하는 구조라 1회성 확인으로는
  이후 호출의 비용 인지가 보장되지 않음 → 안전 측 강화(모든 호출에 확인)로 설계. 필요 시 조정 가능

## Step 3: 월 호출 한도 확인

```
1. data/external_calls.jsonl에서 이번 달(YYYY-MM) 타임스탬프 개수 집계
2. 100개 이상이면: "이번 달 외부 검색 한도(100회)를 모두 사용했습니다. 다음 달 1일 초기화됩니다." 출력 후 중단
   (2026-08-02 PRD/03_PHASES.md 확정 — 월 100회, 하드 차단, 수동 상향 미지원)
```

## Step 4: bc-market-researcher 호출 (1회만)

```
호출 형식:
검색어: {topic} (PII 필터 통과분)
```

- deep-research 플러그인 설치 여부 확인 → 있으면 사용, 없으면 WebSearch로 폴백
- 서브에이전트 분리 호출 절대 금지(1회만)

## Step 5: 저장

```
~/Documents/business-counselor/research/{YYYY-MM-DD}_market-{NNN}.md
```

- `NNN`: 그날 `research/`의 기존 파일 중 가장 큰 번호 + 1(없으면 001) — Phase 1·2와 동일 채번 규칙
- frontmatter: `id`·`timestamp`·`query`·`ttl_until`(수집 시각 +7일)·`sources`(URL+제목 배열)·`tldr`·`disclaimer`
- TTL 만료(7일) 시 **자동 삭제**(2026-08-02 `PRD/02_DATA_MODEL.md` 확정 — archived/ 이동 없음)

## Step 6: external_calls.jsonl 기록 (append-only)

```json
{"timestamp":"{ISO 8601}","command":"research","query_masked":"{PII 필터 통과분}","source":"deep-research|websearch-fallback","research_id":"{market-{YYYY-MM-DD}-{NNN}}"}
```

## 완료 메시지

```
리서치 완료: {topic}
저장 위치: ~/Documents/business-counselor/research/{YYYY-MM-DD}_market-{NNN}.md (7일 후 자동 삭제)
요약: {tldr}

이번 달 남은 호출: {100 - 이번달누적}회
관련 아이디어에 연결하려면: /business-counselor:decide <id> iterate "리서치 참고: market-{...}"
```
