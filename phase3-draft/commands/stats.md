---
name: business-counselor:stats
description: go/drop 비율·명중률·도메인 패턴 요약 — 순수 로컬 집계, 외부 호출 없음 (Phase 3)
version: "0.1.0-draft"
---

# /business-counselor:stats

> ⚠️ **DRAFT — 미활성 상태**. `phase3-draft/commands/`에 있어 `plugin.json`에 연결되지 않았습니다.
> **참고**: 이 명령은 `research`·`followup`과 달리 **외부 API를 호출하지 않는다**(순수 로컬 파일 집계).
> 그래서 PII·비용 리스크가 없어, 원한다면 `research`·`followup`보다 먼저 단독으로 활성화해도 안전하다.
> 다만 이번 라운드에서는 Phase 3 4개 파일을 세트로 묶어 초안만 작성 — 활성화 여부는 별도 결정.

## 목적

`decisions.jsonl` + `ideas/evaluated/` + `ideas/generated/`를 집계해 go/drop 비율, 판독 결과와 실제 결정의
일치도("명중률"), 도메인별 패턴을 보여준다. 외부 API·서브에이전트 호출 없음.

## 입력

```
/business-counselor:stats
```

인자 없음. `decisions.jsonl`이 없으면: "아직 기록된 결정이 없습니다. /business-counselor:decide로 먼저
결정을 기록해보세요." 출력 후 중단(에러 아님 — 정상적인 빈 상태).

---

## Step 1: 데이터 로드 (외부 호출 없음, 순수 파일 읽기)

```
1. ~/Documents/business-counselor/decisions.jsonl 전체 로드
2. ~/Documents/business-counselor/ideas/evaluated/*.md의 frontmatter(verdict·fit_score·domain) 로드
3. ~/Documents/business-counselor/ideas/generated/*.md의 frontmatter(fit_score·domain) 로드
```

## Step 2: 집계

- **go/drop 비율**: `decisions.jsonl`의 `action` 필드 카운트 (go/drop/iterate/defer 각각 %)
- **명중률**: `bc-idea-evaluator`의 verdict(예: "추천"/"비추천")와 사용자의 최종 `decide` action이
  방향상 일치하는 비율. 정의: verdict="추천"류 + action="go" **또는** verdict="비추천"류 + action="drop" →
  일치로 카운트. 그 외(iterate·defer 포함)는 "판단 유보"로 별도 집계(불일치로 강제 분류하지 않음 —
  iterate/defer는 verdict에 대한 반박이 아니라 보류 의사이므로)
- **도메인 패턴**: `domain` 필드 기준 상위 3개 도메인 + 각 도메인의 go 비율

## Step 3: 출력 (파일 저장 없음 — 화면 출력만)

```
## 통계 요약 ({집계 시점})

- 총 결정: {N}건 (go {a}% · drop {b}% · iterate {c}% · defer {d}%)
- 명중률: {e}% (판단 유보 {f}건 제외)
- 상위 도메인: 1. {도메인1} ({go비율}%) 2. {도메인2} 3. {도메인3}

※ 표본이 10건 미만이면 "표본이 적어 참고용 수치입니다" 안내 추가
```

- 이 명령은 어떤 파일도 새로 생성하지 않는다(순수 조회) — `list`·`show`와 동일한 읽기 전용 성격
