---
name: business-counselor:list
description: 과거 평가 목록 조회 — id·verdict·confidence 테이블
version: "1.0"
---

# /business-counselor:list

## 목적

`~/Documents/business-counselor/ideas/evaluated/` 폴더의 모든 평가 파일을 스캔하여
ID·날짜·아이디어 요약·판정·신뢰도를 테이블로 출력한다.

## 실행 절차

```
1. 두 폴더를 각각 스캔한다 (2026-08-03 확장 — Phase 2 GeneratedIdea 대응, 기존엔 evaluated/만 스캔해
   /business-counselor:recommend로 만든 추천 아이디어가 list에 전혀 안 보이던 결함 수정)
   - ~/Documents/business-counselor/ideas/evaluated/  (판독 결과, eval-*)
   - ~/Documents/business-counselor/ideas/generated/  (추천 아이디어, idea-*)
   - 둘 다 없거나 비어있으면: 아래 "기록 없음" 메시지 출력

2. evaluated/ 파일: frontmatter에서 id, timestamp, raw_idea, verdict, confidence 추출
   generated/ 파일: frontmatter에서 id, timestamp, title, fit_score 추출

3. 각각 별도 테이블로 출력 (최신순 정렬), 판독 기록 테이블을 먼저 출력
```

## 출력 형식

```
## 판독 기록 목록

| ID | 날짜 | 아이디어 요약 | 판정 | 신뢰도 |
|----|------|-------------|------|--------|
| eval-2026-05-08-001 | 2026-05-08 | AI 부동산 SaaS... | iterate | 62 |
| eval-2026-05-08-002 | 2026-05-08 | 자영업자 세금 도우... | go | 74 |

## 추천 기록 목록

| ID | 날짜 | 아이디어 제목 | 적합도 |
|----|------|-------------|--------|
| idea-2026-08-03-001 | 2026-08-03 | 자영업자 AI 세금 도우미 | 78 |

총 판독 N건 · 추천 M건 | 마지막 활동: YYYY-MM-DD
```

- `아이디어 요약`(판독): raw_idea 앞 20자 + "..."
- `판정`: go / iterate / no-go
- `신뢰도`/`적합도`: 0~100 숫자
- 두 테이블 모두: timestamp 내림차순 (최신 먼저)
- 한쪽 폴더만 비어있으면 그 테이블만 "기록 없음"으로 표시(다른 쪽은 정상 출력)

## 기록 없음 메시지

```
평가·추천 기록이 없습니다.

아이디어 평가를 시작하려면:
  /business-counselor:evaluate "아이디어 내용"
프로필 기반 아이디어를 추천받으려면:
  /business-counselor:recommend
```

## 상세 조회 안내

특정 판독·추천의 전체 내용을 보려면:
```
/business-counselor:show {ID}
예: /business-counselor:show eval-2026-05-08-001
예: /business-counselor:show idea-2026-08-03-001
```
