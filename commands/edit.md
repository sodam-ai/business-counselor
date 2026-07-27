---
name: business-counselor:edit
description: 프로필 수정·삭제 — 이미 답한 항목 값 변경, 특정 항목 비우기, 프로필 전체 삭제
version: "1.0"
---

# /business-counselor:edit

## 목적

이미 저장된 `~/Documents/business-counselor/profile.md`의 **기존 답변을 직접 바꾸거나 지운다**.
`/business-counselor:resume`은 "빈 항목만 채우는" 용도이고, 이 명령은 "이미 채워진 항목을 고치거나
지우는" 용도로 역할이 다르다. 두 명령은 서로의 영역을 침범하지 않는다.

## 실행 전 확인

```
1. ~/Documents/business-counselor/profile.md 존재 여부 확인
   - 없으면: "프로필이 없습니다. /business-counselor:start 로 먼저 인터뷰를 진행하세요." 출력 후 중단
   - 있으면: profile.md 전체 내용 로드 후 아래 요청 유형 판별 진행
```

## 입력

```
/business-counselor:edit "자연어로 바꾸고 싶은 내용"
```

예:
- `/business-counselor:edit "자본을 3000만원으로 바꿔줘"`
- `/business-counselor:edit "관심도메인 지워줘"`
- `/business-counselor:edit "프로필 전체 삭제해줘"`

인자 없이 호출되면: 현재 profile.md의 필드별 요약(필드명 + 현재값)을 표로 보여주고
"어떤 항목을 어떻게 바꾸고 싶으신가요?" 질문 후 응답 대기.

## 요청 유형 판별

| 유형 | 예시 표현 | 처리 |
|------|----------|------|
| 필드 값 변경 | "~를 …로 바꿔줘", "~은 사실 …야", "~ 다시 알려줄게" | 아래 "필드 변경·비우기 절차" |
| 필드 비우기 | "~ 지워줘", "~ 모르겠으니 빼줘", "~ null로" | 해당 필드만 값 제거(null) |
| 전체 삭제 | "전체 삭제", "처음부터 다시", "프로필 리셋", "프로필 지워줘"(필드명 없이) | 아래 "전체 삭제 절차" (반드시 확인 필수) |
| 모호함 | 위 셋 중 판단 불가, 또는 필드명 특정 불가 | "어떤 항목을 바꾸고 싶으신지, 무엇으로 바꾸고 싶으신지" 되묻기. **자동 가정 절대 금지** |

## 수정 가능 필드 (사용자 응답 필드만)

`birth_year`·`residence`·`family_status`·`capital_krw`·`monthly_income_krw`·`time_available_hr`·
`skills`·`domain_interests`·`risk_appetite`·`past_business`

**시스템 관리 필드는 이 명령의 대상이 아님** (직접 수정 요청이 와도 거부):
`id`·`schema_version`·`last_updated`·`profile_updates`·`disclaimer` — 이 필드들은 명령이 내부적으로만 갱신.

존재하지 않는 필드명 요청 시: "그런 항목은 없습니다. 현재 항목: {필드 목록}" 안내 후 중단.

## 필드 변경·비우기 절차

```
1. profile.md frontmatter에서 해당 필드의 현재 값 확인
2. 사용자에게 확인: "{필드명} 현재: {현재값} → 변경: {새값}. 맞으신가요?"
   (비우기 요청이면 "{필드명}을(를) 빈 값으로 바꿉니다. 맞으신가요?")
3. 확인 후에만 반영: 해당 필드만 갱신, last_updated를 현재 시각으로 갱신,
   profile_updates 배열에 "{필드명}(수정)" 또는 "{필드명}(비움)" 추가
4. body 맨 끝에 변경 이력 한 줄 추가:
   "## 수정 이력" 섹션이 없으면 새로 만들고, 있으면 이어서:
   "- {YYYY-MM-DD}: {필드명} {이전값} → {새값}"
```

- 한 번에 여러 필드 동시 변경 요청 시 각각 위 절차 반복 (한 번에 최대 3개까지 — 그 이상은
  "한 번에 3개까지만 바꿀 수 있어요, 나눠서 요청해주세요" 안내)
- **확인 없이 즉시 반영 절대 금지** — Step 2 확인은 매번 필수

## 전체 삭제 절차 (비가역 — 반드시 확인)

```
1. 확인 질문 필수 (자동 진행 절대 금지):
   "프로필을 완전히 삭제하면 되돌릴 수 없습니다. 지금까지 답하신 항목이 전부 사라지고,
    다음에 /business-counselor:start를 실행하면 처음부터 다시 인터뷰합니다. 정말 삭제하시겠습니까?"
2. 확인되면 ~/Documents/business-counselor/profile.md **파일만** 삭제
   (sessions/·ideas/evaluated/는 과거 인터뷰·평가 기록이라 별도 자산 — 함께 삭제하지 않음)
3. 삭제 완료 후 안내:
   "프로필이 삭제됐습니다. /business-counselor:start로 새로 시작할 수 있습니다."
```

## 완료 메시지 (필드 변경·비우기)

```
프로필 갱신 완료: ~/Documents/business-counselor/profile.md
변경 내용: {필드명} {이전값} → {새값}

이후 /business-counselor:evaluate 실행 시 새 값이 자동 반영됩니다.
```

## 완료 메시지 (전체 삭제)

```
프로필 삭제 완료.
과거 평가 기록(ideas/evaluated/)은 그대로 남아있습니다 — 원하시면 /business-counselor:list로 확인 가능합니다.

새로 시작하려면: /business-counselor:start
```
