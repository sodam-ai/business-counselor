# business-counselor — 프로젝트 스펙

> AI가 코드를 짤 때 지켜야 할 규칙과 절대 하면 안 되는 것.
> **이 문서를 AI에게 항상 함께 공유하세요.**
> **버전: v1.2 (2026-05-07 self-review #2 반영 — 페르소나 v5 13명 다관점 매칭 + P0 5개 해소)**
> 변경 이력: ../CHANGELOG.md

---

## 기술 스택

| 영역 | 선택 | 이유 |
|------|------|------|
| 플러그인 형식 | Claude Code 네이티브 + AGENTS.md 미러 (S1) | Claude Code/Codex 동시 호환, 별도 어댑터 0 |
| 진입점 | `plugin.json`(Claude Code) + `AGENTS.md`(Codex) | 2026 표준 (Open Agent Skills + Linux Foundation) |
| 명령 형식 | Markdown slash commands (`commands/*.md`) | Claude Code 표준, Codex 호환 |
| 스킬 형식 | `SKILL.md`(Open Agent Skills 표준) | Claude+Codex 공식 지원 |
| 서브에이전트 | `agents/*.md` (Claude Code 표준) | 컨텍스트 격리·도구 제한 |
| 데이터 저장 | Markdown + YAML frontmatter + JSONL | DB 0, 사람이 직접 읽고 수정 가능, Git 친화적 |
| 데이터 위치 | `~/.claude/plugins/business-counselor/data/` | 플러그인 격리, 다른 프로젝트 침범 0 |
| 인증 | 없음 | Claude Code 자체 인증 사용. 본인용 |
| 외부 호출 | **Phase 3만 + 사용자 명시 호출 시만 활성** (default 비활성) | Phase 1·2는 외부 송신 0. API 절약 정책 |
| **API 호출 정책 (v1.1)** | **한 명령 = 한 응답. 단일 호출 내부 5단계 강제** | API 비용 절약 + 양측 증거 동시 평가로 판정 품질 ↑ |
| **디베이트 모드 (v1.1)** | **single-call (Bull/Bear/Judge 분리 호출 금지)** | 별도 서브에이전트 호출 0 |
| **재현성 (v1.1)** | model_id·temperature·debate_mode 모두 frontmatter 강제 | Karpathy Goal-Driven Execution 패턴 |
| 언어 | 한국어 (UI·출력) | 사용자 언어 |
| 라이선스 | (사용자 결정 — MIT 또는 비공개) | 본인용 가능성 높아 비공개 추천 |

---

## 프로젝트 구조

```
business-counselor/
├── plugin.json                       # Claude Code 매니페스트
├── AGENTS.md                         # Codex 진입점 (플러그인 폴더 내, 글로벌 X)
├── CLAUDE.md                         # Claude Code 세션 규칙 (플러그인 내부용)
├── README.md                         # 사용자 설치·사용 가이드
├── LICENSE                           # (선택)
│
├── commands/
│   ├── start.md              # /business-counselor:start
│   ├── resume.md             # /business-counselor:resume
│   ├── evaluate.md           # /business-counselor:evaluate
│   ├── list.md               # /business-counselor:list
│   ├── show.md               # /business-counselor:show
│   ├── help.md               # /business-counselor:help (v0.2.0 추가)
│   ├── recommend.md          # Phase 2
│   ├── decide.md             # Phase 2
│   ├── research.md           # Phase 3
│   ├── followup.md           # Phase 3
│   └── stats.md              # Phase 3
│
├── skills/
│   ├── 13-personas/SKILL.md          # 13관점 점수 체계 (페르소나 v5)
│   ├── lean-canvas/SKILL.md          # 9블록 가이드
│   ├── mom-test/SKILL.md             # 검증 질문 생성
│   ├── adversarial-debate/SKILL.md   # Bull/Bear/Judge 단일 호출 토론 (v1.1 — Phase 1)
│   ├── goal-driven/SKILL.md          # success_criteria·consistency_score (v1.1 — Phase 1)
│   └── pre-mortem/SKILL.md           # Phase 2
│
├── agents/
│   ├── bc-idea-evaluator.md          # 판독 워커 (단일 — bull/bear/judge 분리 X)
│   ├── bc-idea-generator.md          # 추천 워커 (Phase 2, 단일)
│   └── bc-market-researcher.md       # 리서치 래퍼 (Phase 3, default 비활성)
│
├── templates/
│   ├── profile.template.md           # 신규 프로필 시드
│   ├── evaluation.template.md        # 평가 출력 양식
│   └── idea.template.md              # 추천 출력 양식
│
└── tests/
    ├── manual-scenarios.md           # 수동 테스트 5건+
    ├── frontmatter-linter.sh         # disclaimer 누락 검증 스크립트 (Git Bash)
    ├── frontmatter-linter.ps1        # 동일 검증, Windows 네이티브 (v0.1.1 추가)
    └── results-template.md           # 시나리오 결과 기록 템플릿 (v0.1.1 추가, .gitignore 처리)
```

---

## 절대 하지 마 (DO NOT) — AI에게 코드 시킬 때 반드시 공유

- [ ] 사용자 자산·소득·이름·주소 등 PII를 외부 API에 직접 전송하지 마 (Phase 3 외부 호출 시 마스킹 필수)
- [ ] 슬래시 명령에 `/business-counselor:*` 네임스페이스 빠뜨리지 마 (다른 플러그인과 충돌)
- [ ] 서브에이전트에 `bc-` prefix 빠뜨리지 마
- [ ] AGENTS.md를 사용자 홈 루트(`C:\Users\PC\AGENTS.md`) 또는 임의 프로젝트 루트에 생성하지 마 (의도치 않은 글로벌 인식 발생)
- [ ] 기존 hook(SessionStart·UserPromptSubmit·PreToolUse 등) 수정·삭제·간섭하지 마
- [ ] 사용자 `~/.claude/CLAUDE.md`, `MEMORY.md`, `user_persona*.md` 절대 자동 수정하지 마
- [ ] 면책 frontmatter 없이 신규 파일 생성하지 마 (린터로 검증)
- [ ] 마크다운/JSONL 외 데이터 형식 도입하지 마 (SQLite·Postgres 도입 금지)
- [ ] 사용자 명시 동의 없이 외부 API 호출하지 마 (Phase 1·2는 외부 송신 0, **Phase 3는 사용자가 `/business-counselor:research` 명시 입력 시만 활성**)
- [ ] **별도 호출로 멀티 에이전트(Bull/Bear/Judge) 분리하지 마 — API 비용. 단일 호출 내부에서 3관점 강제 (v1.1)**
- [ ] **단일 `/business-counselor:evaluate` 호출 시 추가 서브에이전트 호출 0건 유지 — `bc-idea-evaluator` 1회만 (v1.1)**
- [ ] **`bc-bull-advocate`·`bc-bear-critic`·`bc-devil-judge` 같은 별도 서브에이전트 만들지 마 (v1.1 — API 절약)**
- [ ] 특정 종목·금융상품·세무 자문 직접 답변하지 마 (자본시장법 회색지대)
- [ ] 자기 확신·긍정 편향 응답 작성하지 마 (사용자 의도: "냉철한 판독")
- [ ] 환각(hallucination) 방치하지 마 — 출처 없는 통계·시장 수치는 명시적으로 "추정·미검증"으로 표시
- [ ] 테스트 없이 Phase 다음 단계로 넘어가지 마 (회귀 매트릭스 PASS 확인 필수)
- [ ] `--no-verify`, `--force`, `// @ts-ignore` 같은 은폐성 우회 사용하지 마
- [ ] **자동 백그라운드 외부 호출 만들지 마 — 사용자 명시 호출 시만 (v1.1)**

---

## 항상 해 (ALWAYS DO)

- [ ] 모든 출력 파일에 `disclaimer` + `success_criteria` + `consistency_score` + `model_id` + `temperature` + `debate_mode: single-call` frontmatter 자동 삽입 (v1.1)
- [ ] **success_criteria 자동 매칭 규칙 (v1.2)**: 13명 평가 점수 분포(특히 #4 QA·#9 PM·#10 경영진)·사용자 자본·시간·도메인에 따라 카탈로그 5개 중 1~2개 자동 선택. 카탈로그: ① 고객 인터뷰 ≥10명/+30일 ② MVP POC 100% 핵심 1기능/+60일 ③ LOI ≥3건/+45일 ④ 유료 사용자 ≥1명 또는 매출 10만원/+90일 ⑤ 시장 리서치 ≥3출처+통계 1개/+14일
- [ ] 슬래시 명령 모두 `/business-counselor:*` 네임스페이스 (예: `/business-counselor:start`)
- [ ] 서브에이전트 모두 `bc-` prefix
- [ ] **5단계(13관점·Lean Canvas·Mom Test·Pre-mortem·적대 토론) 각 단계 명시적 섹션 분리** (v1.1, Phase 1 포함 5단계. Pre-mortem: Phase 1=3개, Phase 2+=5개)
- [ ] **적대 토론은 Bull/Bear/Judge 3섹션 명시 분리 — 단일 호출 안에서** (v1.1)
- [ ] verdict 출력 시 `confidence` 점수(0~100) + `success_criteria` (Karpathy verify 조건) 함께 표시
- [ ] 외부 호출 시 PII 마스킹 (Phase 3) 후 송신
- [ ] 외부 호출 로그 `data/external_calls.jsonl`에 기록
- [ ] Phase 진행 시 회귀 테스트 매트릭스(`tests/manual-scenarios.md`) 통과 후 다음 Phase
- [ ] 환각 방지를 위해 출처 미상 시 "추정"·"미검증" 명시
- [ ] 사용자가 모호한 입력 시 보강 질문 1~2개 (자동 가정 금지)
- [ ] decisions.jsonl 새 줄 추가 시 timestamp ISO 8601 형식
- [ ] frontmatter `schema_version` 명시 (변경 시 마이그레이션 작성. 현재 1.2)
- [ ] **API 호출 최소화 — 한 명령 = 한 응답 원칙. `/business-counselor:evaluate`는 `bc-idea-evaluator` 1회 호출만으로 5단계 완성 (Phase 1·2 공통. Pre-mortem: Phase 1=3개, Phase 2+=5개)** (v1.1)
- [ ] **출력 분량: 깊이 우선 — 브레비티는 「한눈 요약」 카드, `<6,000`은 강제 아닌 가이드 (v0.2.0)**
- [ ] **Phase 3 외부 호출 전 사용자 confirmation 단계 (예: "정말 외부 검색하시겠습니까? 비용 발생")** (v1.1)

---

## 13명 다관점 (페르소나 v5 1:1 매칭) — v1.2

> 출처(2026-05-07 시점 스냅샷): 당시 `user_persona_triggers.md` Section B에서 13명 다관점 채택.
> 해당 파일은 이후 sodam-persona 플러그인(persona_core.md + persona-triggers 스킬)으로 재구성되며 폐기됨
> (2026-07-26 확인 — 구경로·현재 라이브 경로 모두에 파일 부재). 현재 라이브 페르소나 체계는 15명
> (#14 회계·세무·#15 마케팅 추가)이지만, 본 스킬은 P0-1 채택 시점의 13명 구성을 **의도적으로 고정**
> 유지한다(범위 확장 아님 — 13→15 동기화는 별도 결정 필요).
> 사업 아이디어를 **13명 전문가 시점에서 1~5점 평가** + 한 줄 코멘트.
> v1.0/v1.1의 영문 코드(O/B/I/...)는 페르소나 v5와 매칭되지 않아 v1.2에서 폐기·교체.

| # | 전문가 (15년+ 경력 기본) | 평가 축 (사업 아이디어 적용) |
|---|------------------------|------------------------------|
| 1 | 시니어 개발자 | 기술 구현 가능성·유지보수 부담·확장성 |
| 2 | 시니어 보안 전문가 | 데이터·자본·인증 보안 위험·OWASP·암호화 |
| 3 | 비개발자/왕초보/무경험자 | 진입 장벽·이해 가능성·실수 가능성 |
| 4 | QA/테스트 엔지니어 | 검증·MVP 테스트 비용·엣지 케이스 |
| 5 | DevOps/배포·운영/SRE | 인프라·배포·장애·환경변수 관리 |
| 6 | 데이터/AI 엔지니어 | AI 활용·환각 위험·데이터 윤리·LLM 비용 |
| 7 | 시니어 디자이너 | UI·시각적 매력·색상·레이아웃 |
| 8 | UX 리서처 | 사용성·여정·접근성·첫 5분 경험 |
| 9 | 시니어 기획자/PM/PO | MVP·우선순위·로드맵·요구사항 명료성 |
| 10 | C-레벨 경영진/비즈니스 (25년+) | 매출·시장 규모·경쟁사·BM 견고성 |
| 11 | **법무/컴플라이언스 (15년+ 변호사)** | **자본시장법·창업컨설팅업·면책·GDPR·약관 (자동 강조 활성: AI AutoTrade 도메인)** |
| 12 | 비용 최적화/사업 운영 (15년+) | ROI·운영 비용·토큰 비용·가성비 |
| 13 | **전문 투자자 (15년+)** | **사업 성공 가능성·리스크·포지셔닝·백테스트 사고 (자동 강조 활성: 투자·거래·돈 도메인)** |

### 평가 규칙
- 각 전문가 1~5점 + 한 줄 코멘트 (1줄당 약 30 토큰)
- 5점은 명확한 강점 증거 있을 때만 (보수적·under-promise)
- 도메인 자동 강조 활성: 자본시장법 키워드 → #11 풀 활성. 투자·거래·돈 키워드 → #13 풀 활성. 양쪽 동시 → #11 + #13 동시 풀.
- 합산 점수가 아닌 분포(특히 #11, #13의 강한 부정 신호)에 가중치 — 회색지대 영역에서는 평균 4.0이라도 #11이 1점이면 verdict는 "iterate" 또는 "no-go" 강제

### 페르소나 #11/#13 자동 강조 트리거 키워드

- **#11 변호사 자동 활성**: 자본시장법·창업컨설팅·투자자문업·약관·면책·규제·GDPR·개인정보·라이선스·audit·금감원·AML
- **#13 전문 투자자 자동 활성**: 투자·거래·매매·주식·코인·자동매매·수익·손실·포트폴리오·체결·슬리피지·백테스트·리스크·포지션·손절·익절

---

## 5단계 적용 순서 (v1.2) — **단일 호출 내부에서 모두 수행**

> Phase 1은 5단계(Pre-mortem 3개 포함). Phase 2부터 Pre-mortem 5개로 확장. 모든 단계가 **단일 `bc-idea-evaluator` 호출 안에서** 한 응답으로 출력. 별도 서브에이전트 호출 0.

1. **§ 1. 13명 다관점 평가 (페르소나 v5 1:1 매칭)**: 13명 전문가 시점 1~5점 + 한 줄 코멘트. #11 변호사 + #13 투자자 도메인 키워드 자동 강조.
2. **§ 2. Lean Canvas**: 9블록 채우기 (Problem→Customer→UVP→Solution→Channels→Revenue→Cost→Metrics→Unfair Advantage)
3. **§ 3. Mom Test**: "사용자가 실제로 돈 낼 증거" 검증 질문 5개 + 과거 행동 기반 (Phase 1)
4. **§ 4. Pre-mortem**: "1년 후 망했다면 이유" + 각 확률·완화책 (Phase 1=3개 OK, Phase 2부터 5개 강제)
5. **§ 5. 적대 토론 (Bull/Bear/Judge) — single-call**:

### 적대 토론 system prompt (v1.2 최종 문구)

```
[Bull 단락]
당신은 Bull(긍정 옹호자)입니다. 본 아이디어가 성공할 시나리오 3~5개를 발굴하세요.
사용자 프로필(자본·시간·역량·관심사) 활용 가능성·도메인 트렌드·차별점·시장 타이밍
위주로. 각 시나리오 1~2문장. 출처 미상 시 "추정" 표시. Bear와 Judge가 같은 응답
안에 있으니 같은 톤·균형 유지.

[Bear 단락]
당신은 Bear(부정 비판자)입니다. 본 아이디어가 실패할 시나리오 3~5개를 발굴하세요.
경쟁 포화·자본시장법 회색지대·자본 부족·역량 갭·시장 미성숙·도덕 위험 위주로.
각 시나리오 1~2문장. Bull의 강점 시나리오를 직접 반박해도 됨. 같은 톤.

[Judge 단락]
당신은 Judge(중재자)입니다. Bull/Bear 양측 논거를 가중치 비교하세요. 각 측 핵심
1~2개 인용 → 양측 비교 → 최종 verdict(go/iterate/no-go) + confidence(0~100)
+ success_criteria 자동 매칭(P0-2 카탈로그 1~2개). 편향 없이 사용자 의도="냉철한
판독" 정렬. 13명 평가 평균과 적대 토론 결과 차이 크면 명시.

[강제 출력 규칙]
Bull → Bear → Judge 순서로 같은 응답 안에 §섹션 분리 출력. 별도 API 호출 금지.
```

**반드시 같은 응답 안에서 3섹션 명시 분리** (별도 호출 X).

---

## 테스트 방법

```bash
# 1. 플러그인 설치 (수동)
# Claude Code: ~/.claude/plugins/business-counselor/ 에 클론/심링크
# Codex: AGENTS.md가 자동 인식

# 2. 수동 테스트 시나리오 실행
# tests/manual-scenarios.md의 5건 시나리오를 순서대로 진행
# 각 시나리오 결과 PASS/FAIL 기록

# 3. 면책 frontmatter 린터 (파일 유형별 검증)
bash tests/frontmatter-linter.sh data/                       # Git Bash
powershell -File tests\frontmatter-linter.ps1 data\          # Windows 네이티브 (둘 중 택1)

# 4. 회귀 매트릭스
# Phase 2 진입 전 Phase 1 시나리오 5건 PASS 확인
# Phase 3 진입 전 Phase 1+2 시나리오 10건 PASS 확인
```

---

## 배포 방법

### 본인 사용 (Phase 1~2)
1. `git clone <repo>` → `~/.claude/plugins/business-counselor/`
2. Claude Code 재시작 → 자동 인식
3. `/business-counselor:start` 입력 시작

### Codex 사용 (Phase 1~)
1. 같은 폴더에서 Codex 실행 → AGENTS.md 자동 인식
2. 명령은 자연어로 호출: "사업 아이디어 시작해줘" 등

### Phase 3 deep-research 통합
- deep-research 플러그인이 이미 설치되어 있으면 자동 사용
- 없으면 WebSearch 폴백 (수동 활성화 필요)

---

## 환경변수 (없음)

- 본 플러그인은 환경변수를 요구하지 않습니다.
- Phase 3 deep-research는 외부 플러그인이 자체적으로 관리.
- 사용자 PII는 environment 변수로 절대 노출하지 않습니다.

---

## 가드레일 자가 검증 (PR 전 — v1.1)

- [ ] 모든 슬래시 명령이 `/business-counselor:*` 네임스페이스인지
- [ ] 모든 서브에이전트가 `bc-` prefix인지
- [ ] AGENTS.md가 플러그인 폴더 외에 생성되지 않았는지
- [ ] 기존 hook 파일 변경 0인지 (`git diff`로 확인)
- [ ] CLAUDE.md, MEMORY.md, user_persona*.md 변경 0인지
- [ ] 모든 새 파일 frontmatter에 disclaimer + success_criteria + consistency_score + model_id + temperature + debate_mode 있는지 (린터 PASS)
- [ ] Phase 1·2에서 외부 API 호출 0인지 (코드 grep)
- [ ] PII 마스킹 함수 unit test PASS인지 (Phase 3)
- [ ] **단일 호출 정책 위반 0인지 — `bc-idea-evaluator`·`bc-idea-generator` 코드 안에서 추가 서브에이전트 호출 grep 0** (v1.1)
- [ ] **`bc-bull-advocate`·`bc-bear-critic`·`bc-devil-judge` 같은 별도 서브에이전트 파일 부재** (v1.1 — agents/ 디렉토리 ls)
- [ ] **출력 분량 깊이 우선 — `<6,000`은 가이드(강제 아님), 과도한 장황함만 점검 (v0.2.0)**
- [ ] **Phase 3 외부 호출 사용자 confirmation 단계 존재 (v1.1 — 코드 grep)**

---

## [NEEDS CLARIFICATION]

- ✓ ~~라이선스 (MIT vs 비공개)~~ → **Apache-2.0 채택·구현 완료** (LICENSE·plugin.json·README 3곳 일치. 2026-07-27 문서 간 불일치 발견·동기화)
- [ ] Codex AGENTS.md 활성 시점: Claude Code와 동시 또는 Phase 2 이후?
- ✓ ~~면책 조항 한국어 문구 최종안~~ → **v1.2 본문 박힘** (02_DATA_MODEL.md 공통 frontmatter 참조). 후속 변호사 검토 권고.
- ✓ ~~13관점 한국어 라벨 user_persona.md와 100% 일치 검증~~ → **v1.2 페르소나 v5 13명 다관점 1:1 매칭 완료**. 영문 코드 폐기·전문가 시점 표 채택.
- [ ] Phase 3 외부 호출 한도 (월 100회? 비용 대비)
- [ ] 백업 정책: Git private repo 자동? 수동? OS 백업 위임?
- ✓ ~~적대 토론 system prompt 최종 문구~~ → **v1.2 본문 박힘** (§5단계 §5 적대 토론).
- ✓ ~~success_criteria 측정 지표 표준 카탈로그~~ → **v1.2 카탈로그 5개 + 자동 매칭 규칙 본문 박힘**.
- [ ] **v1.1 잔존**: consistency_score 임계값 (Phase 2 측정 후 결정)
- ✓ ~~출력 토큰 < 6,000 한계 검증~~ → **v1.2 추정 ~3,110 (Phase 1) / ~3,710 (Phase 2) (한계 52~62%) PASS**. Phase 1 첫 평가 시 실측 확정 (tests/manual-scenarios.md 시나리오 4 참조).
- [ ] **v1.2 잔존**: bull_arguments·bear_arguments 최소·최대 항목 수 (Phase 2 사용 데이터로 결정)
- [ ] **v1.2 잔존**: profile_snapshot_hash 알고리즘 (SHA-256 전체 vs 핵심 필드)
- [ ] **v1.2 잔존**: decisions.jsonl 회전 정책 (무한 누적 vs N개 후 archive)
- [ ] **v1.2 잔존**: 외부 호출 confirmation UX (취소 시 롤백·비용 추정 표시 방법)
