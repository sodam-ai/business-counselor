# business-counselor — Phase 분리 계획

> 한 번에 다 만들면 복잡도 폭증으로 품질이 떨어집니다.
> Phase별로 "각각 진짜 동작하는 제품"을 만듭니다.
> **버전: v1.2 (2026-05-07 self-review #2 반영 — 페르소나 v5 13명 다관점 매칭 + P0 5개 해소)**
> 변경 이력: ../CHANGELOG.md

---

## Phase 1: MVP (목표 1~2주)

### 목표
사용자 본인 프로필을 인터뷰로 누적하고, 사용자가 가져온 아이디어를 **4단계(13명 다관점·Lean Canvas·Mom Test·적대 토론)**로 냉철하게 판독할 수 있다. **단일 호출 내부에서 모든 단계 수행 (API 분리 호출 0)**. 13명 = 페르소나 v5 1:1 매칭 (시니어 개발자·보안·비개발자·QA·DevOps·AI·디자이너·UX·PM·경영진·**변호사**·비용·**전문 투자자**). Pre-mortem은 Phase 2에서 5단계로 확장.

### 기능
- [ ] 플러그인 골격 (`plugin.json`, `commands/`, `skills/`, `agents/`, `templates/`)
- [ ] AGENTS.md 미러 (플러그인 폴더 내, 사용자 홈/프로젝트 루트 설치 금지)
- [ ] 명령 `/counsel:start` — 첫 인터뷰 시작 + profile.md 생성
- [ ] 명령 `/counsel:resume` — 다음 세션 이어서 + 부족 영역 자동 우선 질문
- [ ] 명령 `/counsel:evaluate "<idea>"` — 가져온 아이디어 판독 (**4단계: 13명 다관점·Lean Canvas·Mom Test·적대 토론**, 단일 호출)
- [ ] 명령 `/counsel:list` — 과거 평가 목록
- [ ] 명령 `/counsel:show <id>` — 특정 평가 재조회
- [ ] 스킬 `13-personas/SKILL.md` — 13명 다관점 점수 체계 (페르소나 v5 1:1 매칭, v1.2 신규명. 기존 `13-perspectives/SKILL.md`는 폐기)
- [ ] 스킬 `lean-canvas/SKILL.md` — 9블록 채우기 가이드
- [ ] 스킬 `mom-test/SKILL.md` — 검증 질문 생성 (과거 행동 기반)
- [ ] **스킬 `adversarial-debate/SKILL.md` — Bull/Bear/Judge 단일 호출 내부 토론 가이드 (v1.1 신규)**
- [ ] **스킬 `goal-driven/SKILL.md` — success_criteria 작성·consistency_score placeholder 가이드 (v1.1 신규)**
- [ ] 서브에이전트 `bc-idea-evaluator` — **단일** 컨텍스트 격리 판독 워커. 시스템 프롬프트에 4단계 출력 강제. **bull/bear/judge 별도 서브에이전트 분리 금지**
- [ ] 모든 출력 frontmatter에 자동 삽입: `disclaimer`·`success_criteria`·`consistency_score`(Phase 1 placeholder)·`model_id`·`temperature`·`debate_mode: single-call` (린터 검증)

### 데이터
- Profile (profile.md)
- InterviewSession (sessions/*.md)
- EvaluatedIdea (ideas/evaluated/*.md)

### 인증
- **불필요** — Claude Code 자체 인증 사용. 플러그인 자체 로그인 없음

### 가드레일 (필수 준수)
- 모든 슬래시 명령은 `/counsel:` 네임스페이스 강제
- 모든 서브에이전트는 `bc-` prefix 강제
- AGENTS.md는 플러그인 폴더 안에만 (글로벌 인식 차단)
- 기존 hook(SessionStart·UserPromptSubmit·PreToolUse) 절대 수정·간섭 금지
- CLAUDE.md·MEMORY.md·user_persona*.md 절대 수정 금지
- **API 호출 최소화 — 한 명령 = 한 응답 원칙 (v1.1)**
- **단일 호출 내 4단계(Phase 1)·5단계(Phase 2+) 강제. Bull/Bear/Judge 별도 서브에이전트 분리 호출 금지 (v1.1)**
- **외부 API 호출 0 (Phase 1·2 정책). Phase 3부터 사용자 명시 호출 시만 활성**

### "진짜 제품" 체크리스트
- [ ] 실제 파일 생성 (목업 데이터 X) — profile.md·sessions/·evaluated/ 모두 디스크 기록
- [ ] 실제 **4단계** 분석 (하드코딩된 응답 X) — Claude API로 생성. 13명 다관점(페르소나 v5)·Lean Canvas·Mom Test·적대 토론 모두 단일 응답 안에서.
- [ ] **Bull/Bear/Judge 3섹션 명시 분리 출력** (v1.1)
- [ ] **success_criteria + consistency_score frontmatter 자동 삽입** (Phase 1 consistency는 placeholder OK)
- [ ] **별도 서브에이전트 호출 0 (단일 호출 정책 검증 — `bc-idea-evaluator` 1회만 호출)**
- [ ] 실제 사용자가 다른 환경에서도 설치 가능 (README 가이드 따라)
- [ ] 면책 조항 자동 삽입 동작 확인 (린터 또는 templates에서 강제)
- [ ] 출력 토큰 < 6,000 (긴 결과 방지)

### Phase 1 시작 프롬프트 (복사해서 바로 사용 — v1.1)
```
이 PRD를 읽고 Phase 1을 구현해주세요.
@PRD/01_PRD.md
@PRD/02_DATA_MODEL.md
@PRD/04_PROJECT_SPEC.md
@CHANGELOG.md
@tests/manual-scenarios.md

Phase 1 범위 (v1.1):
- 플러그인 골격 (plugin.json + AGENTS.md 미러 + commands/ + skills/ + agents/)
- 명령: /counsel:start, /counsel:resume, /counsel:evaluate, /counsel:list, /counsel:show
- 스킬: 13-personas, lean-canvas, mom-test, adversarial-debate, goal-driven
- 서브에이전트: bc-idea-evaluator (단 1개 — bull/bear/judge 별도 분리 X)
- 데이터: Profile, InterviewSession, EvaluatedIdea (4단계 = 13명 다관점·Lean Canvas·Mom Test·적대 토론)

반드시 지켜야 할 것 (v1.1 강화):
- 04_PROJECT_SPEC.md의 "절대 하지 마" 목록 준수
- 모든 명령 /counsel: 네임스페이스
- 모든 서브에이전트 bc- prefix
- AGENTS.md는 플러그인 폴더 안에만
- 기존 hook·CLAUDE.md·MEMORY.md·user_persona*.md 절대 수정 금지
- 모든 출력 frontmatter에 자동 삽입: disclaimer + success_criteria + consistency_score(placeholder) + model_id + temperature + debate_mode: single-call
- 외부 API 호출 0 (Phase 1)
- API 호출 최소화 — 한 명령 = 한 응답 원칙
- 단일 호출 내부에서 4단계(13명 다관점→Lean Canvas→Mom Test→적대 토론) 모두 출력
- 적대 토론은 Bull/Bear/Judge 3섹션 명시 분리 (단일 응답 안에서)
- 별도 서브에이전트 호출 0 (bc-idea-evaluator만 1회)
- 출력 토큰 < 6,000 (긴 결과 방지)

완료 검증:
- tests/manual-scenarios.md의 5건 시나리오 모두 PASS
- 시나리오 5(네임스페이스·hook 충돌)는 사용자 환경 무결성 검증 필수
```

### 완료 기준 (v1.1 정량화)
- 사용자가 `/counsel:start`로 인터뷰 → profile.md 작성 완료 (인터뷰 30~40분 범위)
- 사용자가 임의 아이디어로 `/counsel:evaluate` 실행 → **4단계 결과(Bull/Bear/Judge 3섹션 포함)** + 면책 + success_criteria + consistency_score(placeholder) frontmatter 출력
- `tests/manual-scenarios.md`의 **5건 시나리오 모두 PASS** (시나리오 1~5)
- 기존 환경(bkit, everything-claude-code 등)에 영향 0 확인 (시나리오 5)
- **API 호출 최소화 정책 준수 검증** — 한 `/counsel:evaluate` 호출 시 추가 서브에이전트 호출 0건
- 출력 토큰 < 6,000

---

## Phase 2: 추천 기능 추가 (목표 +1~2주)

### 전제 조건
- Phase 1이 안정적으로 동작 (5건 이상 평가 누적, profile.md 1차 완성)

### 목표
AI가 누적된 프로필을 기반으로 사용자에게 맞는 사업 아이디어 N개를 먼저 제안하고, Pre-mortem 프레임을 추가해 **5단계로 완성**한다. consistency_score 실측 시작.

### 기능
- [ ] 명령 `/counsel:recommend [N=5]` — 누적 프로필 기반 N개 아이디어 + 각 Lean Canvas (단일 호출)
- [ ] 명령 `/counsel:decide <id> <go|drop|iterate|defer>` — 결정 기록 → decisions.jsonl
- [ ] 스킬 `pre-mortem/SKILL.md` — "1년 후 망했다면 이유 5가지" 시나리오 생성 (단일 호출 내 통합)
- [ ] 서브에이전트 `bc-idea-generator` — 추천 격리 워커 (단일 — generator 내부에서도 분리 호출 X)
- [ ] 13명 다관점 점수 체계 정교화 (1~5점 가이드라인, 페르소나 v5 #11 변호사·#13 투자자 도메인 자동 강조 규칙 포함)
- [ ] 과거 추천·판독 교차 참조 (`/counsel:show`에 관련 항목 표시)
- [ ] **consistency_score 실측 — N=3회 자동 재평가 후 표준편차 기록 (v1.1 후속)**
- [ ] **success_criteria 도메인별 카탈로그 작성 (v1.1 후속)**

### 추가 데이터
- GeneratedIdea (ideas/generated/*.md)
- DecisionLog (decisions.jsonl)
- profile_snapshot_hash (재현성)

### 통합 테스트
- Phase 1 모든 기능 정상 동작 (회귀 0)
- generated → evaluate → decide 한 사이클 완전 동작

### 완료 기준
- 5개 아이디어 추천 후 그 중 1개를 evaluate→decide까지 완전 진행
- Pre-mortem 시나리오 5개 자동 출력
- decisions.jsonl 5줄 이상 누적

---

## Phase 3: 증거 + 외부 리서치 (목표 +2~3주)

### 전제 조건
- Phase 1 + 2가 안정 운영 (10건 이상 평가, 추천 누적)

### 목표
deep-research 플러그인을 서브에이전트로 호출해 시장규모·경쟁사·트렌드를 자동 수집하고, 과거 평가를 시간이 지난 후 재방문하여 시장 변화를 반영한다.

### 기능
- [ ] 명령 `/counsel:research <topic>` — deep-research 서브에이전트 호출
- [ ] 명령 `/counsel:followup <eval-id>` — 과거 평가 재방문 + 시장 변화 비교
- [ ] 명령 `/counsel:stats` — go/drop 비율·명중률·도메인 패턴 요약
- [ ] 서브에이전트 `bc-market-researcher` — deep-research 래퍼
- [ ] research/*.md TTL(7일) 만료 처리
- [ ] 추천·판독에 자동 증거 첨부 (관련 research/*.md 링크)
- [ ] WebSearch 폴백 (deep-research 미설치 환경)
- [ ] PII 마스킹 (외부 검색 시 자본·이름·주소 등 키워드 자동 제거)

### 추가 데이터
- MarketResearch (research/*.md, TTL 7일)

### 주의사항 — 외부 송신 발생 (Phase 3 전용 / v1.1 강화)
- **default 비활성** — 사용자가 `/counsel:research` 명시 입력 시만 활성. 자동 백그라운드 호출 0.
- 첫 외부 호출 시 사용자 confirmation 단계 강제 (예: "정말 외부 검색하시겠습니까? 비용 발생").
- deep-research / WebSearch 호출 = 외부 API 사용 (비용·로그 발생 가능)
- PII 마스킹 필수 (capital_krw·birth_year·residence·skills 등 직접 송신 금지)
- 송신 키워드는 일반 시장 용어만 ("부동산 AI 시장 2026" OK / "내 5천만원으로 부동산 AI" NG)
- 모든 외부 호출 로그 `data/external_calls.jsonl`에 기록
- 월 호출 한도 제안: 100회 (사용자 결정 미완)

### 완료 기준
- 3~5 아이디어에 대해 research 첨부 + followup 완료
- WebSearch 폴백 동작 확인
- stats 출력에 의미 있는 패턴 표시

---

## Phase 로드맵 요약

| Phase | 핵심 기능 | 기능 코드 | 예상 기간 | 외부 의존성 | 상태 |
|-------|----------|----------|---------|-----------|------|
| Phase 1 (MVP) | 인터뷰 + 판독 (**4단계**: 13명 다관점·Lean Canvas·Mom Test·**적대 토론**) | A + C + 적대토론 + Goal-Driven | 1~2주 | 없음 (단일 호출) | 시작 전 |
| Phase 2 | 추천 + **5단계 완성**(Pre-mortem 추가) + 결정로그 + consistency_score 실측 | B + Pre-mortem + DecisionLog | +1~2주 | 없음 | Phase 1 완료 후 |
| Phase 3 | 외부 리서치 + 재방문 + 통계 (**default 비활성, 사용자 명시 호출 시만**) | D + Followup + Stats | +2~3주 | deep-research 또는 WebSearch (선택) | Phase 2 완료 후 |

### 권장 일정
```
Week 1-2 : Phase 1  — 매일 쓸 수 있는 수준 (인터뷰 + 판독)
Week 3-4 : Phase 2  — "추천" 도입 후 1주 사용 피드백
Week 5-7 : Phase 3  — 안정화 후 외부 리서치 통합
Week 8+ : 운영·튜닝 (+ 페르소나 v5 변경 반영)
```

### Phase 통합 회귀 테스트 매트릭스
- Phase 2 시작 시: Phase 1 시나리오 5건 모두 PASS 확인
- Phase 3 시작 시: Phase 1+2 시나리오 10건 모두 PASS 확인
- 회귀 발견 시 → Phase 진행 중단 → 회귀 해결 후 재개
