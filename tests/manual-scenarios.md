# 수동 테스트 시나리오 5건 — Phase 1 완료 기준

> Phase 1 종료 시 5건 모두 PASS 필수. 회귀 매트릭스 기준점.
> Phase 2 시작 전 5건 PASS 재확인 (회귀 0).
> schema_version: 1.2 (2026-05-07 self-review #2 — P0-5 토큰 추정 반영)

---

## 시나리오 1 — 첫 인터뷰 (Cold start)

### 전제
- 플러그인 신규 설치 직후
- `~/Documents/business-counselor/` 비어 있음
- 사용자가 처음 사용

### 절차
1. Claude Code에서 `/business-counselor:start` 입력
2. AI가 Mom Test 스타일 질문 6 카테고리(생애사·자본·시간·역량·관심도메인·리스크성향) 시작
3. 사용자가 12개 질문에 답변 (각 카테고리 2개 평균)
4. AI가 답변 누적 후 `profile.md` 생성

### 기대 결과 (PASS 조건)
- [ ] `data/profile.md` 파일 생성됨
- [ ] frontmatter에 `id`·`schema_version: 1.2`·`last_updated`·`disclaimer` 4필드 자동 삽입
- [ ] frontmatter에 `birth_year`·`residence`·`capital_krw`·`monthly_income_krw`·`time_available_hr`·`skills`·`domain_interests`·`risk_appetite` 8개 필수 필드 채워짐
- [ ] `data/sessions/2026-05-07_001.md` 세션 기록 생성 (Q/A 페어)
- [ ] 외부 API 호출 0 (Phase 1 정책 준수)
- [ ] 인터뷰 시간 30~40분 범위
- [ ] AI가 질문 시 가설 기반("향후 X하면?") 0건, 과거 행동 기반("지난 1년 X했나?") 100% (Mom Test 준수)

### FAIL 시 액션
- frontmatter 누락 → 린터 보강
- 가설 질문 1건 이상 → mom-test/SKILL.md 보강

---

## 시나리오 2 — 이어서 대화 (Resume)

### 전제
- 시나리오 1 통과 후 24시간 경과
- profile.md 존재, 일부 필드는 누락

### 절차
1. `/business-counselor:resume` 입력
2. AI가 profile.md 읽고 부족 영역(예: `past_business`·`risk_appetite` 모호) 자동 감지
3. 해당 영역만 우선 질문
4. 새 답변으로 profile.md 갱신

### 기대 결과 (PASS 조건)
- [ ] AI가 이미 답한 카테고리 재질문 0건
- [ ] 부족 영역 우선 질문 정확
- [ ] profile.md `last_updated` 갱신
- [ ] `profile_updates` 필드에 갱신된 필드명 기록
- [ ] 새 세션 파일 `2026-05-08_001.md` 생성 (날짜 자동)
- [ ] 외부 API 호출 0

### FAIL 시 액션
- 재질문 발생 → AI 시스템 프롬프트에 "이미 답한 카테고리 검사" 단계 강화

---

## 시나리오 3 — 모호 아이디어 (Vague input)

### 전제
- profile.md 1차 완성 (시나리오 1·2 통과)

### 절차
1. `/business-counselor:evaluate "AI로 뭔가 사업 해보고 싶어"` 입력 (모호 입력)
2. AI가 모호 감지 → 보강 질문 1~2개 ("어느 도메인의 AI?", "B2C/B2B?")
3. 사용자 답변 받고 명확화 후 5단계 평가 진행

### 기대 결과 (PASS 조건)
- [ ] AI가 자동 가정으로 평가 진행 0건 (반드시 보강 질문 후 진행)
- [ ] 보강 질문 1~2개로 제한 (3개 이상 안 됨 — 사용자 피로)
- [ ] 명확화 후에만 5단계 평가 시작
- [ ] 외부 API 호출 0

### FAIL 시 액션
- 자동 가정 발생 → ALWAYS DO "모호 입력 시 보강 질문 1~2개 (자동 가정 금지)" 강화
- 보강 질문 3개+ → AI 프롬프트에 "최대 2개" 제약

---

## 시나리오 4 — 명확 아이디어 5단계 검증 (Core path)

### 전제
- profile.md 1차 완성

### 절차
1. `/business-counselor:evaluate "AI로 한국 부동산 매물 자동 분석 + 투자 가치 점수화 SaaS"` 입력
2. AI가 단일 호출에서 5단계 적대 토론 수행
3. 결과 출력 + `data/ideas/evaluated/2026-05-07_eval-001.md` 저장

### 기대 결과 (PASS 조건)
- [ ] 출력에 5단계 명시적 섹션 분리:
  - § 1. **13명 다관점 점수표 (페르소나 v5 1:1 매칭, 1~5점, 13행)** — 시니어 개발자·시니어 보안·비개발자·QA·DevOps·AI·디자이너·UX·PM·경영진·**변호사**·비용·**전문 투자자**
  - § 2. Lean Canvas (9블록)
  - § 3. Mom Test 검증 질문 5개 (과거 행동 기반)
  - § 4. Pre-mortem 시나리오 3~5개 (Phase 1은 3개도 OK, Phase 2부터 5개 강제)
  - § 5. 적대 토론 — Bull(긍정 가능성)·Bear(실패 시나리오)·Judge(최종 verdict)
- [ ] frontmatter에 `success_criteria` 필드 (verdict 정당화 측정값)
- [ ] frontmatter에 `consistency_score` 필드 (Phase 1은 placeholder, Phase 2부터 N=3회 측정)
- [ ] frontmatter에 `model_id`·`temperature`·`debate_mode: single-call`·`disclaimer` 명시
- [ ] verdict 한 줄 (go / iterate / no-go) + confidence(0~100)
- [ ] 자본시장법 회색지대 키워드 감지 시 면책 조항 강조 표시
- [ ] 외부 API 호출 0
- [ ] 단일 호출에서 완료 (별도 서브에이전트 호출 0건)
- [ ] 출력 분량: 깊이 우선 (브레비티는 「한눈 요약」 카드, `<6,000`은 가이드 — 과도한 장황함만 점검, v0.2.0)

### FAIL 시 액션
- 단계 누락 → bc-idea-evaluator 시스템 프롬프트에 "반드시 5단계 모두 출력" 강화
- 추가 API 호출 발견 → 단일 호출 정책 위반, 즉시 재구성
- 토큰 초과 → 13명 다관점 코멘트 단축·Lean Canvas 압축

### P0-5 토큰 추정 (v1.2 사전 측정)

| 섹션 | 추정 토큰 (한국어 1.5배 보정 후) |
|------|----------------------------------|
| 13명 다관점 (13행 × 한 줄 코멘트) | ~600 |
| Lean Canvas 9블록 | ~800 |
| Mom Test 검증 질문 5개 | ~300 |
| Pre-mortem 3개 (Phase 1) / 5개 (Phase 2+) | ~360 / 600 |
| Bull (3~5 시나리오) | ~375 |
| Bear (3~5 시나리오) | ~375 |
| Judge (verdict + 양측 비교) | ~150 |
| frontmatter (6필드 + 면책 한국어) | ~250 |
| 헤더·구분자 | ~300 |
| **Phase 1 합계 (5단계)** | **~3,470 (한계 6,000의 58%)** |
| **Phase 2 합계 (5단계)** | **~3,710 (한계 6,000의 62%)** |
| **PASS/FAIL** | **PASS 추정** — Phase 1 첫 평가 시 실측 확정 |

---

## 시나리오 5 — 네임스페이스·hook 충돌 검증 (Environment safety)

### 전제
- 사용자의 기존 환경: bkit·everything-claude-code·ccpp·oh-my-claudecode 등 다수 플러그인 활성
- 페르소나 hook(SessionStart·UserPromptSubmit) 정상 동작
- MEMORY.md·user_persona*.md 파일 존재

### 절차
1. 플러그인 설치 후 사용자 환경 스냅샷 1차: `git status`·`ls ~/.claude/`·`cat ~/.claude/CLAUDE.md`·`cat ~/.claude/projects/<project>/memory/MEMORY.md`
2. `/business-counselor:start` 1회 + `/business-counselor:evaluate` 1회 + `/business-counselor:list` 1회 실행
3. 환경 스냅샷 2차 (동일 명령들)
4. 1차 vs 2차 비교

### 기대 결과 (PASS 조건)
- [ ] `~/.claude/CLAUDE.md` 변경 0 (diff 없음)
- [ ] `~/.claude/projects/*/memory/MEMORY.md` 변경 0
- [ ] `~/.claude/projects/*/memory/user_persona*.md` 변경 0
- [ ] hook 파일(`~/.claude/settings.json` SessionStart·UserPromptSubmit) 변경 0
- [ ] bkit·everything-claude-code 등 기존 플러그인 디렉토리 변경 0
- [ ] AGENTS.md가 사용자 홈 루트(`C:\Users\PC\AGENTS.md`)에 생성되지 않음
- [ ] AGENTS.md가 임의 프로젝트 루트(`D:\AI_Dev_Work\...\AGENTS.md`)에 생성되지 않음
- [ ] AGENTS.md가 플러그인 폴더 안에만 존재 (`~/.claude/plugins/business-counselor/AGENTS.md`)
- [ ] 슬래시 명령 충돌 0 — `/business-counselor:*` 5개가 다른 플러그인 명령과 겹치지 않음
- [ ] 서브에이전트 이름 충돌 0 — `bc-idea-evaluator` 등이 기존 에이전트와 겹치지 않음
- [ ] 페르소나 hook 정상 동작 (다음 세션에서 user_persona_min.md 자동 주입 정상)

### FAIL 시 액션
- CLAUDE.md/MEMORY.md/persona 변경 발견 → 즉시 롤백, 원인 분석, DO NOT 강화
- AGENTS.md 글로벌 생성 → 플러그인 install 스크립트 점검
- 명령·에이전트 충돌 → `bc-` prefix(에이전트)·`/business-counselor:*`(명령) 접두사 유지 확인

---

## 시나리오 6 — 프로필 수정·삭제 (edit, v0.5.0 추가)

### 전제
- profile.md 1차 완성 (시나리오 1 통과, 6개 카테고리 전부 답변됨)

### 절차
1. `/business-counselor:edit "자본을 3000만원으로 바꿔줘"` 입력 (필드 값 변경)
2. AI가 "현재값 → 새값, 맞으신가요?" 확인 질문 → "네" 답변
3. `/business-counselor:edit "관심도메인 지워줘"` 입력 (필드 비우기)
4. AI 확인 질문 → "네" 답변
5. `/business-counselor:edit "프로필 전체 삭제해줘"` 입력 (전체 삭제)
6. AI가 비가역 경고 + 확인 질문 → 일부러 **"아니요"로 취소** → profile.md 그대로 남아있는지 확인
7. 다시 `/business-counselor:edit "프로필 전체 삭제해줘"` → 이번엔 "네" → 삭제 실행

### 기대 결과 (PASS 조건)
- [ ] 2번 확인 질문 없이 즉시 값이 바뀌지 않음 (매번 확인 필수)
- [ ] `capital_krw` 값이 실제로 갱신되고 `last_updated`도 갱신됨
- [ ] `domain_interests`가 비워짐(null 또는 빈 배열)
- [ ] `profile_updates`에 수정·비움 이력이 기록됨
- [ ] 6번에서 "아니요" 응답 시 profile.md가 삭제되지 않고 그대로 남아있음 (취소 정상 동작)
- [ ] 7번에서 "네" 응답 후에만 profile.md 실제 삭제
- [ ] 삭제 후 `ideas/evaluated/*.md`(과거 평가 기록)는 그대로 남아있음 (함께 삭제되지 않음)
- [ ] 삭제 후 `/business-counselor:start` 재실행 시 새 인터뷰가 정상 시작됨

### FAIL 시 액션
- 확인 없이 즉시 반영/삭제 → `commands/edit.md`의 "확인 후에만 반영" 규칙 위반, 최우선 수정
- 삭제 시 평가 기록까지 같이 사라짐 → 삭제 대상 범위(`profile.md` 파일 단독) 재점검

---

## 통합 PASS 조건

- [ ] 시나리오 1~6 모두 PASS (6/6)
- [ ] 6건 누적 시 외부 API 호출 0 (Phase 1 정책)
- [ ] 6건 누적 시 별도 서브에이전트 호출 0 (단일 호출 정책, `edit`는 서브에이전트 자체를 쓰지 않음)
- [ ] 6건 누적 후 사용자 환경 무결성 확인 (시나리오 5와 동일 검사 재실행)

---

## Phase 2 진입 전 회귀 매트릭스

위 5건 그대로 재실행 + 다음 추가:
- [ ] `/business-counselor:recommend 5` 정상 동작
- [ ] `/business-counselor:decide <id> go` decisions.jsonl 1줄 추가
- [ ] Pre-mortem 5개 강제 (Phase 1의 3개 → 5개)
- [ ] generated/*.md 파일 생성

---

## Phase 3 진입 전 회귀 매트릭스

위 + Phase 2 추가 + 다음:
- [ ] `/business-counselor:research <topic>` 명시 호출 시만 외부 API 활성
- [ ] WebSearch 폴백 동작 (deep-research 미설치 환경)
- [ ] PII 마스킹 unit test PASS (capital_krw·birth_year·residence 키워드 자동 제거)
- [ ] external_calls.jsonl 로그 기록
- [ ] research/*.md TTL 7일 만료 처리

---

## 운영 메모

- 시나리오 추가 발생 시 본 파일에 append (절대 삭제 X — 회귀 추적 용도)
- 각 시나리오 PASS/FAIL 결과는 `tests/results/2026-05-07_run-001.md` 같은 별도 파일에 기록
- 5회 PASS 누적 시 시나리오 신뢰도 ★ 표시
