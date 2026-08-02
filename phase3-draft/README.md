# Phase 3 초안 (DRAFT — 비활성)

> 이 폴더는 `plugin.json`이 전혀 참조하지 않습니다. 안에 있는 파일은 **실제로 호출되지 않습니다.**
> (2026-08-02 확인: `git diff plugin.json` 변경 0건 — Phase 2를 준비할 때와 동일한 격리 패턴)

## 포함된 파일

| 파일 | 활성화 시 목적지 | 외부 API 호출 | PRD 근거 |
|---|---|---|---|
| `commands/research.md` | `commands/research.md` | **있음** (deep-research/WebSearch) | `PRD/03_PHASES.md` Phase 3 §기능 |
| `commands/followup.md` | `commands/followup.md` | **있음** (research.md 경로 재사용) | 〃 |
| `commands/stats.md` | `commands/stats.md` | **없음** (순수 로컬 집계) | 〃 |
| `agents/bc-market-researcher.md` | `agents/bc-market-researcher.md` | **있음** (`WebSearch` 도구 보유) | 〃 |

## 왜 Phase 2와 다르게 다뤄야 하는가

Phase 1·2는 전부 로컬 파일만 다뤘다(`bc-idea-evaluator`·`bc-idea-generator` 모두 `tools: Read, Write, Glob`뿐 —
외부 호출이 도구 수준에서 원천 차단). **Phase 3는 이 플러그인 역사상 처음으로 외부로 데이터가 나간다**
(`bc-market-researcher`에 `WebSearch` 추가). 그래서 활성화 기준이 Phase 2보다 한 단계 더 엄격하다:

## 활성화 조건 (반드시 순서대로 — Phase 2보다 1단계 추가)

1. Phase 2(`recommend`/`decide`)가 **실제로 최소 1회 이상 사용된 증거** 존재
   (2026-08-02 기준: `ideas/generated/` 0건·`decisions.jsonl` 없음 — 아직 미충족)
2. `PRD/03_PHASES.md`의 자체 착수 조건 충족: "Phase 1+2 10건 이상 평가·추천 누적" + "시나리오 10건 PASS"
3. `agents/bc-market-researcher.md`의 "활성화 전 필수 검증" 체크리스트(PII 필터·WebSearch 폴백·월 한도 차단·
   비용 확인 거부 시 미호출) 사람이 직접 확인
4. 위 4개 파일을 각자의 목적지 경로로 이동
5. `plugin.json`의 `agents` 배열에 `"./agents/bc-market-researcher.md"` 추가
6. `tests/manual-scenarios.md`의 "Phase 3 진입 전 회귀 매트릭스" 실행

## 예외: `stats.md`는 먼저 활성화해도 안전할 수 있음

`stats`는 외부 호출이 전혀 없는 순수 로컬 집계 명령이라 PII·비용 리스크가 없다. 원한다면 `research`·
`followup`·`bc-market-researcher`보다 먼저 단독 활성화하는 선택지도 있다(이번 라운드에서는 Phase 3
세트로 묶어 초안만 작성 — 활성화 순서는 사용자 결정 사항).

## 이번 라운드에 함께 확정한 PRD 미결 항목 2건

- 월 외부 호출 한도: **100회로 확정** (`PRD/03_PHASES.md`, 하드 차단·수동 상향 미지원)
- `research/*.md` TTL 만료 처리: **자동 삭제로 확정** (`PRD/02_DATA_MODEL.md`, archived/ 이동 없음)
