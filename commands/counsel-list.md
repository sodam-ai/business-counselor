---
name: counsel:list
description: 과거 평가 목록 조회 — id·verdict·confidence 테이블
version: "1.0"
---

# /counsel:list

## 목적

`~/.claude/plugins/business-counselor/data/ideas/evaluated/` 폴더의 모든 평가 파일을 스캔하여
ID·날짜·아이디어 요약·판정·신뢰도를 테이블로 출력한다.

## 실행 절차

```
1. ~/.claude/plugins/business-counselor/data/ideas/evaluated/ 폴더 존재 여부 확인
   - 없거나 비어있으면: 아래 "기록 없음" 메시지 출력

2. 폴더 내 *.md 파일 전체 스캔
   - 각 파일 frontmatter에서 id, timestamp, raw_idea, verdict, confidence 추출

3. 테이블 출력 (최신순 정렬)
```

## 출력 형식

```
## 평가 기록 목록

| ID | 날짜 | 아이디어 요약 | 판정 | 신뢰도 |
|----|------|-------------|------|--------|
| eval-2026-05-08-001 | 2026-05-08 | AI 부동산 SaaS... | iterate | 62 |
| eval-2026-05-08-002 | 2026-05-08 | 자영업자 세금 도우... | go | 74 |

총 N건 | 마지막 평가: YYYY-MM-DD
```

- `아이디어 요약`: raw_idea 앞 20자 + "..."
- `판정`: go / iterate / no-go
- `신뢰도`: confidence 숫자 (0~100)
- 정렬: timestamp 내림차순 (최신 먼저)

## 기록 없음 메시지

```
평가 기록이 없습니다.

아이디어 평가를 시작하려면:
  /counsel:evaluate "아이디어 내용"
```

## 상세 조회 안내

특정 평가의 전체 내용을 보려면:
```
/counsel:show {ID}
예: /counsel:show eval-2026-05-08-001
```
