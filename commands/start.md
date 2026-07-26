---
name: business-counselor:start
description: 자기 인터뷰 시작 — Mom Test 스타일 6카테고리 인터뷰 후 profile.md 생성
version: "1.0"
---

# /business-counselor:start

## 목적

사용자 맥락(자본·시간·역량·관심 도메인·리스크 성향)을 수집하여
`~/Documents/business-counselor/profile.md`를 생성한다. 이 프로필은 이후 모든 평가의 기준이 된다.

## 실행 전 확인

```
1. ~/Documents/business-counselor/profile.md 존재 여부 확인
   - 있으면: "이미 프로필이 있습니다. /business-counselor:resume 로 보완하거나 계속 진행하세요." 출력 후 중단
   - 없으면: 아래 인터뷰 시작
```

## 인터뷰 규칙 (Mom Test 원칙 적용)

- **가설 기반 질문 0건**: "만약 ~한다면?" 형식 절대 금지
- **과거 행동 기반 100%**: "지난 N년 동안 실제로 ~한 적 있나요?" 형식만 허용
- **6카테고리 순서**: 생애사 → 자본 → 시간 → 역량 → 관심도메인 → 리스크성향
- **카테고리당 약 2개 질문**, 총 12개 (30~40분 목표)
- **페이싱**: 질문은 **한 번에 1~2개씩** 제시하고 답변을 받은 뒤 다음으로. 12개를 한꺼번에 나열 금지(사용자 피로·대화 흐름 붕괴 방지)
- 답변이 모호하면 같은 카테고리에서 1회 추가 질문 허용 (카테고리당 최대 3개)

## 6카테고리 질문 가이드

| 카테고리 | 질문 목표 | 예시 질문 |
|----------|----------|----------|
| 생애사 | 과거 직업·경험·전환점 | "지금까지 가장 오래 한 일이 뭔가요?" / "직업 전환을 한 적 있다면 계기가 뭔가요?" |
| 자본 | 가용 투자 자금 | "사업에 투자할 수 있는 초기 자금이 어느 정도인가요?" / "지금까지 사업 또는 투자에 직접 돈을 써본 적 있나요?" |
| 시간 | 투입 가능 주당 시간 | "직장 외에 사업에 쓸 수 있는 주당 시간이 몇 시간인가요?" / "최근 6개월 중 가장 바빴던 주에 부업에 쓴 시간은 얼마나 됐나요?" |
| 역량 | 실제 보유 기술·경험 | "직접 만들거나 운영해본 프로젝트가 있나요?" / "지금 당장 혼자 해결할 수 있는 기술적 과제가 있다면 어떤 건가요?" |
| 관심도메인 | 열정 있는 분야 | "최근 1년간 자발적으로 가장 많은 시간을 쓴 분야가 어디인가요?" / "돈을 받지 않아도 계속 하고 싶은 일이 있나요?" |
| 리스크성향 | 실패 허용 범위 | "사업 실패 시 감당 가능한 최대 손실 규모가 어느 정도인가요?" / "과거에 실패했던 시도가 있다면, 그때 어떻게 대응했나요?" |

## profile.md 생성 규칙

인터뷰 완료 후 `templates/profile.template.md`를 참조하여 `~/Documents/business-counselor/profile.md`를 생성한다.

**필수 frontmatter 필드 (15개):**
```yaml
---
id: profile-main
schema_version: "1.2"
last_updated: {YYYY-MM-DDTHH:MM:SS}
birth_year: {값 또는 null}
residence: {값 또는 null}
family_status: {값 또는 null}
capital_krw: {숫자 또는 null}
monthly_income_krw: {숫자 또는 null}
time_available_hr: {숫자(주당) 또는 null}
skills: [{기술1}, {기술2}]
domain_interests: [{분야1}, {분야2}]
risk_appetite: {low|medium|high 또는 null}
past_business: {설명 또는 null}
profile_updates: []
disclaimer: |
  본 프로필은 본인이 직접 작성하며, Phase 1에서 외부로 전송되지 않습니다.
---
```

**body**: 카테고리별 Q/A 원문 기록

## 세션 파일 생성

`~/Documents/business-counselor/sessions/{YYYY-MM-DD}_001.md` 생성:
```yaml
---
session_id: session-{YYYY-MM-DD}-001
schema_version: "1.2"
profile_id: profile-main
timestamp: {YYYY-MM-DDTHH:MM:SS}
updated_fields: [birth_year, residence, capital_krw, ...]
disclaimer: |
  본 세션 기록은 본인이 직접 작성하며, Phase 1에서 외부로 전송되지 않습니다.
---
```
본문: 이번 세션 Q/A 페어 전체 기록

## 완료 메시지

```
프로필 저장 완료: ~/Documents/business-counselor/profile.md
세션 기록: ~/Documents/business-counselor/sessions/{YYYY-MM-DD}_001.md

다음 단계:
- 아이디어가 있으면: /business-counselor:evaluate "아이디어 내용"
- 프로필 보완이 필요하면: /business-counselor:resume
```
