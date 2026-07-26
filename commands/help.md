---
name: business-counselor:help
description: business-counselor 사용법 한 장 — 명령 목록·추천 흐름·용어 풀이
version: "1.0"
---

# /business-counselor:help

## 목적

처음 쓰는 사람이 **명령 5개·진행 흐름·전문용어**를 한 화면에서 파악하도록 돕는다.
인자 없이 호출되며, 아래 내용을 그대로(또는 최신 상태에 맞춰) 출력한다.

---

## 출력 내용

```
AI 사업 카운슬러 — 사용법 한 장

[추천 흐름]
1) /business-counselor:start                 나에 대한 인터뷰 (처음 한 번) → profile.md 생성
2) /business-counselor:evaluate "아이디어"   아이디어 5단계 냉철 판독 → 결과 저장
3) /business-counselor:list                  지금까지 판독 목록 보기
4) /business-counselor:show <id>             특정 판독 다시 보기
   /business-counselor:resume                인터뷰 이어서(정보 보완)

[명령 5개]
- /business-counselor:start                  자기 인터뷰 시작 (Mom Test 6분야, 약 30~40분)
- /business-counselor:resume                 빠진 항목만 추가 질문해 프로필 보완
- /business-counselor:evaluate "<아이디어>"  13관점·Lean Canvas·Mom Test·Pre-mortem·적대토론 단일 판독
- /business-counselor:list                   판독 기록 목록 (id·판정·확신도)
- /business-counselor:show <id>              해당 판독 전체 다시 보기

[용어 풀이 — 어려운 말 한 줄 설명]
- 13명 다관점     개발·보안·법무·투자자 등 전문가 13명 시점으로 1~5점 평가
- 타겟 고객 한마디 실제 '돈 낼 고객' 1인칭 예상 반응(살까·거부이유·대안) — §3로 검증할 가설
- Lean Canvas     사업 모델을 9칸(문제·고객·수익 등)으로 한 장에 요약
- Mom Test        "정말 돈 낼까"를 과거 행동으로 검증하는 질문법(미래 가정 X)
- Pre-mortem      "1년 뒤 망했다면 왜?"를 미리 상상해 실패 원인·완화책 도출
- 적대 토론       Bull(긍정)·Bear(부정)·Judge(판정)가 한 번에 겨뤄 go/iterate/no-go 결론
- 한눈 요약       긴 결과 맨 위의 TL;DR 카드(판정·확신도·강점·막힌곳·다음행동)
- success_criteria 이 판정이 맞으려면 무엇이 충족돼야 하는지(검증 기준)
- 확신도          판정의 자신감 0~100

[중요]
- 모든 결과는 내 컴퓨터에만 저장(외부 전송 0). 위치: ~/.claude/plugins/business-counselor/data/
- 본 도구는 참고용 의견이며 투자자문·법률/세무 자문이 아닙니다. 중요한 결정은 전문가 상담 권고.
```

---

## 규칙

- 인자가 와도 무시하고 위 도움말을 출력한다.
- 외부 호출 0. 파일 생성 0(읽기/출력만).
