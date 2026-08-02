---
name: business-counselor:recommend
description: 누적 프로필 기반 사업 아이디어 N개 추천 — 각 Lean Canvas 포함 (단일 호출, Phase 2)
version: "1.0"
---

# /business-counselor:recommend

## 목적

누적된 `profile.md`를 기반으로 사용자에게 맞는 사업 아이디어 N개(기본 5개)를 `bc-idea-generator` 에이전트로 **1회 단일 호출**하여 생성하고 저장한다.

## 입력

```
/business-counselor:recommend [N]
```

- `N` 생략 시 기본값 5
- `N` 범위: 1~10. 10 초과 시 "한 번에 10개까지만 추천 가능합니다" 안내 후 N=10으로 진행
- `N`이 숫자가 아니거나 0 이하면: "추천 개수는 1 이상의 숫자로 입력해주세요. 예: /business-counselor:recommend 5" 출력 후 중단

---

## Step 1: 프로필 존재 확인

```
1. ~/Documents/business-counselor/profile.md 존재 여부 확인
   - 없으면: "프로필이 없습니다. /business-counselor:start 로 먼저 인터뷰를 진행하세요." 출력 후 중단
     (evaluate.md와 달리 recommend는 프로필 없이 진행 불가 — 추천 자체가 프로필 기반이라 의미 없음)
   - 있으면: profile.md 전체 내용 로드
```

## Step 2: bc-idea-generator 호출 (1회만)

`agents/bc-idea-generator.md`를 **정확히 1회** 호출한다.

```
호출 형식:
개수: {N}
프로필 컨텍스트: {profile.md 전체 내용}
```

### 단일 호출 강제
- 에이전트 분리 호출: **절대 금지**
- N개 아이디어 전부 **한 응답 안에서** 생성 (아이디어별로 나눠 여러 번 호출 금지)

---

## Step 3: 결과 저장

bc-idea-generator가 생성한 N개 아이디어 각각을 개별 파일로 저장한다.

### 파일명 규칙

```
~/Documents/business-counselor/ideas/generated/{YYYY-MM-DD}_idea-{NNN}.md
```

- `NNN`: **그날 `generated/`의 기존 파일 중 가장 큰 번호 + 1**(없으면 001). ⚠️ "파일 *수* + 1" 금지 — `evaluate`·`start`·`resume`과 동일 규칙(중간 삭제 시 덮어쓰기 방지, 2026-08-02 PRD 03_PHASES.md 사전 명시)
- N개를 저장할 때마다 NNN을 하나씩 증가시켜 순번 유지 (예: N=3이면 idea-001, idea-002, idea-003)

### ID 규칙

```yaml
id: idea-{YYYY-MM-DD}-{NNN}
```

---

## 완료 메시지

```
아이디어 {N}개 추천 완료.
저장 위치: ~/Documents/business-counselor/ideas/generated/

| ID | 제목 | 적합도 |
|----|------|--------|
| idea-{YYYY-MM-DD}-001 | ... | {fit_score}/100 |
...

특정 아이디어를 심층 판독하려면: /business-counselor:evaluate "<idea-{...}의 제목 또는 요약>"
결정을 기록하려면: /business-counselor:decide idea-{YYYY-MM-DD}-{NNN} <go|drop|iterate|defer>
```
