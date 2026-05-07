---
name: adversarial-debate
description: Bull/Bear/Judge 단일 호출 적대 토론 스킬 — 사업 아이디어 냉철 판정
version: "1.2"
policy: single-call — Bull·Bear·Judge 분리 호출 금지
---

# 적대 토론 스킬 (Bull / Bear / Judge)

## 목적

사업 아이디어의 **긍정·부정 시나리오를 동시에 발굴**하고, Judge가 양측 논거를 가중치 비교하여
**최종 verdict(go/iterate/no-go) + confidence(0~100)**를 도출한다.

## 핵심 정책

**단일 호출 강제**: Bull·Bear·Judge는 **하나의 응답 안**에서 순서대로 출력.
`bc-bull-advocate`·`bc-bear-critic`·`bc-devil-judge` 같은 별도 에이전트 호출 **절대 금지**.

## System Prompt (bc-idea-evaluator에 주입)

```
[Bull 단락]
당신은 Bull(긍정 옹호자)입니다. 본 아이디어가 성공할 시나리오 3~5개를 발굴하세요.
사용자 프로필(자본·시간·역량·관심사) 활용 가능성·도메인 트렌드·차별점·시장 타이밍
위주로. 각 시나리오 1~2문장. 출처 미상 시 "추정" 표시. Bear와 Judge가 같은 응답
안에 있으니 같은 톤·균형 유지.

[Bear 단락]
당신은 Bear(부정 비판자)입니다. 본 아이디어가 실패할 시나리오 3~5개를 발굴하세요.
경쟁 포화·자본시장법 회색지대·자본 부족·역량 갭·시장 미성숙·도덕 위험 위주로.
각 시나리오 1~2문장. Bull의 강점 시나리오를 직접 반박해도 됨. 같은 톤.

[Judge 단락]
당신은 Judge(중재자)입니다. Bull/Bear 양측 논거를 가중치 비교하세요. 각 측 핵심
1~2개 인용 → 양측 비교 → 최종 verdict(go/iterate/no-go) + confidence(0~100)
+ success_criteria 자동 매칭(goal-driven 스킬 참조). 편향 없이 사용자 의도="냉철한
판독" 정렬. 13명 평가 평균과 적대 토론 결과 차이 크면 명시.

[강제 출력 규칙]
Bull → Bear → Judge 순서로 같은 응답 안에 §섹션 분리 출력. 별도 API 호출 금지.
```

## Verdict 정의

| Verdict | 의미 | 기준 |
|---------|------|------|
| `go` | 진행 권장 | Judge 판정 + #11·#13 경고 없음 + confidence ≥ 70 |
| `iterate` | 보완 후 재평가 | 1~2개 핵심 약점 존재, 수정 가능 |
| `no-go` | 진행 비권장 | #11 또는 #13이 1~2점이거나 치명적 결함 |

## 출력 형식 (§5 섹션)

```
## § 5. 적대 토론

### Bull (긍정 옹호)
1. ...
2. ...
3. ...

### Bear (부정 비판)
1. ...
2. ...
3. ...

### Judge (최종 판정)
- Bull 핵심: ...
- Bear 핵심: ...
- **verdict: go/iterate/no-go**
- **confidence: N**
- **success_criteria**: ...
```

## 토큰 목표

Bull ~375 + Bear ~375 + Judge ~150 = ~900 토큰
