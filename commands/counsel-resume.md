---
name: counsel:resume
description: 인터뷰 이어서 — 부족 영역만 우선 질문, 이미 답한 카테고리 재질문 0건
version: "1.0"
---

# /counsel:resume

## 목적

기존 `~/.claude/plugins/business-counselor/data/profile.md`를 읽고 **누락·모호한 필드만 추가 질문**하여 프로필을 보완한다.
이미 답변된 카테고리는 재질문하지 않는다.

## 실행 전 확인

```
1. ~/.claude/plugins/business-counselor/data/profile.md 존재 여부 확인
   - 없으면: "프로필이 없습니다. /counsel:start 로 먼저 인터뷰를 진행하세요." 출력 후 중단
   - 있으면: 아래 누락 필드 감지 진행
```

## 누락·모호 필드 감지 규칙

`~/.claude/plugins/business-counselor/data/profile.md` frontmatter를 읽고 아래 기준으로 필드를 분류한다:

| 상태 | 기준 | 처리 |
|------|------|------|
| 완료 | 값이 null이 아니고 구체적 | 재질문 금지 |
| 누락 | 값이 null | 해당 카테고리 질문 1~2개 |
| 모호 | 답변 범위가 지나치게 넓거나 추정 불가 | 구체화 질문 1개 |

**카테고리-필드 매핑:**
- 생애사 → profile body 텍스트에서 직업·전환점 확인
- 자본 → capital_krw, monthly_income_krw
- 시간 → time_available_hr
- 역량 → skills
- 관심도메인 → domain_interests
- 리스크성향 → risk_appetite

## 인터뷰 규칙 (Mom Test 원칙 동일)

- 이미 완료된 카테고리: **재질문 0건 강제**
- 누락 카테고리만 우선순위 순으로 질문
- 가설 기반 질문 절대 금지 ("만약 ~" 형식)
- 총 추가 질문 최대 6개 (누락 카테고리 수 × 2)

## profile.md 갱신 규칙

답변 수집 후 `~/.claude/plugins/business-counselor/data/profile.md`를 갱신한다:

```yaml
last_updated: {YYYY-MM-DDTHH:MM:SS}  # 현재 시각으로 업데이트
profile_updates:
  - {기존 항목 유지}
  - {이번 갱신 필드명}  # 새로 추가
```

갱신된 필드만 덮어쓰기. 기존 완료 필드는 변경 없음.

## 세션 파일 생성

`~/.claude/plugins/business-counselor/data/sessions/{YYYY-MM-DD}_{NNN}.md` 생성 (NNN: 당일 순번):
```yaml
---
session_id: session-{YYYY-MM-DD}-{NNN}
profile_id: profile-main
timestamp: {YYYY-MM-DDTHH:MM:SS}
updated_fields: [{갱신된 필드명 목록}]
---
```
본문: 이번 세션 추가 Q/A 페어 기록

## 완료 메시지

```
프로필 갱신 완료: ~/.claude/plugins/business-counselor/data/profile.md
갱신 필드: {갱신된 필드 목록}
세션 기록: ~/.claude/plugins/business-counselor/data/sessions/{YYYY-MM-DD}_{NNN}.md

모든 핵심 필드가 채워졌으면:
- /counsel:evaluate "아이디어 내용" 으로 평가 시작
```
