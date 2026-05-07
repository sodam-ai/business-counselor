---
name: goal-driven
description: Karpathy Goal-Driven Execution 패턴 — success_criteria + consistency_score 작성 스킬
version: "1.2"
reference: "Andrej Karpathy 4 principles / forrestchang/andrej-karpathy-skills"
---

# Goal-Driven Execution 스킬

## 목적

verdict의 **검증 가능성**을 담보한다.
"이 판정이 맞으려면 X 측정값이 Y 이상이어야 한다"는 형식으로
`success_criteria`를 frontmatter에 자동 삽입.

## success_criteria 표준 카탈로그 5개

| # | 카탈로그 항목 | 기준 | 기한 |
|---|-------------|------|------|
| ① | 고객 인터뷰 | ≥10명 (정성 피드백 포함) | +30일 |
| ② | MVP POC | 핵심 기능 1개 100% + 실사용자 1명 피드백 | +60일 |
| ③ | LOI (Letter of Intent) | ≥3건 (B2B) | +45일 |
| ④ | 유료 사용자 또는 매출 | ≥1명 또는 ≥10만원 | +90일 |
| ⑤ | 시장 리서치 신뢰도 | ≥3출처 + 통계 1개 | +14일 |

## 자동 선택 규칙

| 조건 | 선택 카탈로그 |
|------|-------------|
| B2C + 자본 < 1,000만원 + 시간 < 20h/주 | ① + ② |
| B2B + 자본 충분 | ① + ③ |
| 수익 모델 불명확 | ⑤ 우선 |
| 투자자 대상 | ③ + ④ |
| 기본값 (조건 미충족) | ① |

## consistency_score 정의

- **Phase 1**: `placeholder` (실측 미수행)
- **Phase 2부터**: 동일 아이디어 N=3회 독립 평가 시 verdict 분포의 표준편차
  - 0.0~0.1 = 매우 안정 (고신뢰)
  - 0.1~0.3 = 보통
  - 0.3+ = 불안정 (추가 맥락 필요)

## frontmatter 출력 형식

```yaml
success_criteria:
  catalog: "① 고객 인터뷰"
  metric: "정성 인터뷰 완료 건수"
  threshold: "≥10명"
  deadline: "+30일 이내"
  rationale: "verdict 검증: 10명 중 7명+ 재방문 의향 확인 시 go 전환"
consistency_score: placeholder
```

## 토큰 목표

~100 토큰 (5필드 + rationale 1줄)
