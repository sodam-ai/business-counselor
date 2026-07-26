# CHANGELOG — business-counselor

> 본 PRD·플러그인 변경 이력. schema_version은 frontmatter에 명시.

---

## [플러그인] v0.2.1 — 2026-07-26 (Phase 1 정합성 점검 — 종결 전 사전 수정)

### 배경
Phase 2 착수 전 게이트 점검(`03_PHASES.md` 전제 조건: 평가 5건+·profile.md 완성·시나리오 5건 PASS) 결과
실측 평가 3건·profile.md 부재·시나리오 1/5(1건만 PASS) 확인. Phase 1 종결 E2E를 진행하기 전,
결과 파일 규격에 영향을 주는 정합성 결함을 먼저 해소.

### 수정 (Fixed)
- **템플릿 필드 누락**: `templates/evaluation.template.md` frontmatter에 `mode` 필드 없음 →
  `bc-idea-evaluator.md`가 요구하는 `mode: summary|full` 미기재 상태로 실데이터 3건 모두 저장됨.
  템플릿에 `mode: null` 추가로 에이전트 규격과 일치.
- **README 죽은 링크 4건 (한/영 각 2건)**: "왕초보 가이드"/"Guide for Non-Developers" 링크가
  실존하지 않는 섹션을 가리킴 → 이미 비개발자 눈높이로 작성된 "사용 방법"/"Usage" 섹션으로 재연결.
  GitHub의 한글+이모지 앵커 자동변환에 의존하지 않도록 `<a id="beginner-guide">`·`<a id="mode-guide">`
  명시적 앵커 추가(§ 기본/전체 모드 링크도 동일 방식으로 고정).
- **PRD/04 구조 문서 드리프트**: `counsel-help.md`(v0.2.0 추가)·`frontmatter-linter.ps1`·
  `results-template.md`(v0.1.1 추가)가 프로젝트 구조 트리에 누락 → 실제 파일 목록과 동기화.

### 스키마/버전
- schema_version 1.2 유지(변경 없음). 플러그인 0.2.0 → 0.2.1 (patch — 신규 기능 없음, 정합성 수정만).
  `plugin.json`·`.claude-plugin/marketplace.json` 버전 lockstep 갱신(v0.1.1 선례 준수).
  `bc-idea-evaluator.md` 내부의 기존 "v0.2.1" 자기 참조(32행, 점진적 공개 규칙)와 이제 실제 버전 일치.

### 미완료 (Pending — 다음 작업)
- 시나리오 1(인터뷰)·2(resume)·5(환경 무결성) 실 E2E — **AI 대행 불가**(실사용자 인터뷰 답변·새 세션 필요).
- Phase 2 착수는 위 3개 시나리오 PASS + 평가 5건 누적 + profile.md 완성 후.

---

## [플러그인] v0.2.0 — 2026-06-15 (UX/사용성 고도화 — 핵심 경로 E2E 검증 후)

### 검증 (Verified)
- **E2E 시나리오 4(핵심 경로) 실측 통과**: `/counsel:evaluate` 실제 실행 → §1~§5 + frontmatter 정상, 린터 PASS. v0.1.1 수정(§4 확률+완화책·#11/#13 ⚠️·단일호출·verdict 강제하향·NNN·환각태깅) 전부 실동작 확인.
- **실측 발견**: 출력 ~11,900자(≈6~8k 토큰)로 PRD `<6,000` 목표 초과 → 본 버전에서 압축 규칙으로 대응.

### 추가 (Added)
- **「한눈 요약」 카드**: 평가 출력 맨 위 TL;DR(판정 ✅/⚠️/⛔·확신도·강점·막힌곳·다음행동). 색·기호 단독 의존 금지(텍스트 라벨 병기=접근성). `agents/bc-idea-evaluator.md`·`templates/evaluation.template.md` 반영.
- **`/counsel:help` 명령**: 명령 5개·추천 흐름·전문용어 풀이를 한 장에(비개발자 온보딩·접근성). 용어집을 매 평가 인라인 대신 help에 모아 토큰 절약. AGENTS.md·README 2종 등록.
- **「타겟 고객의 한마디」(§1 부록)**: 13명 전문가 패널과 별개로, 실제 '돈 낼 고객' 1인칭 예상 반응(첫반응·거부이유·현재대안·지갑여는조건)을 §1 표 아래 추가. 13행 표·5단계·페르소나 1:1 정합 무수정(부록 형태). §3 Mom Test와 "가설↔검증"으로 연결해 중복 회피. agents·template·help 반영.

### 고도화 (Improved)
- **출력 분량 원칙(깊이 우선)**: 브레비티는 「한눈 요약」 카드가 담당 → §1~§5 본문은 분석 깊이 보존. 줄이는 건 불필요한 반복·중복(특히 frontmatter bull/bear ↔ §5 본문)뿐. `<6,000` 토큰은 강제 → **가이드로 강등**(깊이와 충돌 시 깊이 우선). ※ 초기 "줄 수 하드캡" 방침은 분석 정확도 저하 우려로 철회(사용자 피드백 반영).

### 고도화 (Improved, 추가)
- **화면/저장 분리(점진적 공개)**: 깊은 §1~§5는 파일에 그대로 저장하되, **화면 응답은 「한눈 요약」 카드 + show 안내까지만** 출력. 실사용자가 5쪽을 강제로 읽지 않게 함 — 압축이 아니라 *안 보여줄 뿐*이라 깊이 손실 0. 사용자 피드백("출력이 너무 길다") 반영.
- **2단계 기본/전체 모드**: 기본 `/counsel:evaluate`=「한눈 요약」 카드만 생성(빠름·짧음), `"...전체"`/`--full`=§1~§5 전체 생성. 두 모드 모두 13관점·적대토론 **내부 추론 필수**(verdict 품질 유지). 속도·길이 동시 해결. 사용자 피드백('전체는 선택에 따라 작성') 반영. frontmatter `mode: summary|full` 기록.

### 미검증 (Pending)
- 한눈 요약·압축의 실제 토큰 절감 효과는 다음 `/counsel:evaluate` 실행에서 재확인 필요(빌드≠작동).
- 시나리오 1(인터뷰→profile)·2(resume)·5(환경 무결성) 실 E2E 미완.

### 스키마/버전
- schema_version 1.2 유지. 플러그인 0.1.1 → 0.2.0 (신규 명령 추가 = minor).

---

## [플러그인] v0.1.1 — 2026-06-15 (Phase 1 안정화 + 기존 기능 고도화)

### 수정 (Fixed) — 정합성 결함 6건
- **린터 과잉 검증 버그**: `frontmatter-linter.sh`가 모든 .md에 6필드를 요구해 `/counsel:start` 직후 profile.md·세션 파일이 FAIL하던 문제 → 파일 유형별 검증(모든 파일=disclaimer+schema_version, evaluated/generated=6필드)으로 수정. 02_DATA_MODEL.md 정합.
- **세션 파일 면책 누락**: counsel-start·counsel-resume 세션 frontmatter에 `disclaimer`+`schema_version` 추가 ("면책 없는 파일 생성 금지" 규칙 위반 해소).
- **marketplace.json 라이선스 불일치**: `private` → `Apache-2.0` / `SoDam AI Studio` (plugin.json·LICENSE·README와 일치).
- **도구 부산물 추적 위험**: .gitignore에 .complexity-log.md·.pair-programming-session.md·.plugin-config/·.todos-report.md/·tests/results/ 추가.
- **NNN 순번 충돌 버그**: `counsel-evaluate`·에이전트 저장 규칙이 순번을 "파일 *수* + 1"로 계산 → 중간 파일 삭제 시 기존 파일 덮어쓰기 충돌 → **"기존 최대 순번 + 1"**로 수정.

### 고도화 (Improved) — 기존 기능 강화
- **에이전트 frontmatter 표준화 + 기술적 강제**: `bc-idea-evaluator`에 `tools: Read, Write, Glob`·`model: sonnet` 지정. Task·WebFetch/WebSearch 도구 부재로 "단일 호출·외부 API 0"이 프롬프트 약속 → 런타임 불변식으로 격상. 비표준 `skills:`·`policy:` 필드는 본문으로 이동(자기완결화).
- **§4 Pre-mortem 정보량 강화**: 각 실패 시나리오에 확률(상/중/하)+완화책 추가 (02_DATA_MODEL.md `{cause, prob, mitigation}` 정합). `evaluation.template.md` 동반 갱신. 토큰 예산표 §4 ~200→~360, 합계 ~3,160(<6,000).
- **환각 억제 규칙 명시**: 출처 없는 수치 `(추정·미검증)` 태깅 강제, §1 점수-프로필 사실 근거 연결.
- **재현성 정직화**: `model_id`는 `model: sonnet` 고정으로 기록값=실제 일치, `temperature`는 "선언적 메타(런타임 미강제)"임을 명시.
- **인터뷰 페이싱**: counsel-start·counsel-resume에 "질문 한 번에 1~2개씩, 답변 후 다음" 규칙 추가 (12문항 일괄 나열 방지 → 시나리오 1 UX 리스크 해소).
- **도메인 경고 가시화**: 13-personas·에이전트 §1 — 자본시장법/투자 키워드 감지 시 #11/#13 행에 ⚠️ + 표 아래 경고 1줄을 *출력에 노출* (기존엔 "강조"가 출력에 안 보임 → 법무·투자 안전 실효화).

### 추가 (Added)
- **tests/frontmatter-linter.ps1**: PowerShell 린터(Windows 네이티브, Git Bash 불필요). bash 린터와 동일 규칙.
- **tests/results-template.md**: 시나리오 5건 검증 결과 기록 템플릿.
- **.gitattributes**: `*.sh text eol=lf` (Windows CRLF 셰뱅 깨짐 방지).

### 검증
- 린터 2종(bash·PowerShell) 실측 PASS — 정상 PASS(exit 0)·필드 누락 FAIL(exit 1)·빈/없는 디렉토리 INFO(exit 0). 파일 유형별 분기 동작 확인(profile·세션은 base 필드만으로 PASS).
- 정적 정합성: §4 포맷 = 에이전트 ⟷ 템플릿 ⟷ 데이터모델 일치.
- git diff: 전역 환경 파일(CLAUDE.md·MEMORY.md·user_persona*.md·hook) 무손상.

### 미완료 (Pending)
- 수동 시나리오 5건 실 E2E (사용자가 플러그인 설치 후 `/counsel:*` 실행 — `tests/results-template.md`로 기록).

### 스키마
- schema_version 1.2 유지(변경 없음). 플러그인 버전 0.1.0 → 0.1.1.

---

## [플러그인] v0.1.0 — 2026-05-08 (Phase 1 구현 완료)

### 구현 (Added)
- **18개 파일 생성** — plugin.json·AGENTS.md·CLAUDE.md·commands(5)·skills(5)·agents(1)·templates(3)·tests(1)
- **commands**: counsel-start·counsel-resume·counsel-evaluate·counsel-list·counsel-show
- **skills**: 13-personas·lean-canvas·mom-test·adversarial-debate·goal-driven
- **agents**: bc-idea-evaluator (단일 호출로 §1~§5 완료, < 6,000 토큰)
- **templates**: profile·evaluation·idea (Phase 2 준비)
- **tests**: frontmatter-linter.sh (6필드 검증)

### 수정 (Fixed)
- **data/ 상대 경로 → 절대 경로** (6파일 26곳)
  - 수정 전: `data/profile.md`, `data/ideas/evaluated/`
  - 수정 후: `~/.claude/plugins/business-counselor/data/profile.md`, `~/.claude/plugins/business-counselor/data/ideas/evaluated/`
  - 이유: 상대 경로는 사용자 working directory 기준으로 해석되어 세션마다 데이터 위치가 달라지는 버그
  - linter 기본값(`$HOME/.claude/plugins/business-counselor/data`)과 정합

### 검증
- Validator: Critical 0건 ✅ | Linter: exit 0 ✅ | 상대 경로 잔존: 0건 ✅

### 미완료 (Pending)
- 수동 시나리오 테스트 5개 (tests/manual-scenarios.md 기준)

---

## v1.2 — 2026-05-07 (self-review #2, P0 5개 해소)

### 결정적 결함 발견·수정 (P0-1)
- **v1.0/v1.1의 13관점은 페르소나 v5와 매칭되지 않은 *허위 표시* 상태였음**. v1.2에서 영문 코드(O/B/I/F/M/L/A/E/T/S/D/C/P) 폐기하고 페르소나 v5 13명 다관점 1:1 매칭 채택.
- 13명 = 시니어 개발자·시니어 보안·비개발자/왕초보·QA/테스트·DevOps/SRE·데이터/AI·시니어 디자이너·UX 리서처·시니어 PM/PO·C-레벨 경영진(25년+)·**법무/컴플라이언스(15년+ 변호사)**·비용 최적화·**전문 투자자(15년+)**.
- 출처: `~/.claude/projects/D--AI-Tool-CLI-LLM-Claude-Code/memory/user_persona_triggers.md` Section B.

### P0 해소 (5건)
- ✓ **P0-1**: 13관점 → 페르소나 v5 13명 다관점 1:1 매칭. 04_PROJECT_SPEC.md 표 교체. #11 변호사·#13 투자자 도메인 자동 강조 트리거 명시.
- ✓ **P0-2**: success_criteria 표준 카탈로그 5개 + 자동 매칭 규칙. ① 고객 인터뷰 ≥10명/+30일 ② MVP POC 100% 핵심 1기능/+60일 ③ LOI ≥3건/+45일 ④ 유료 사용자 ≥1명 또는 매출 10만원/+90일 ⑤ 시장 리서치 ≥3출처+통계 1개/+14일.
- ✓ **P0-3**: 적대 토론 system prompt 최종 문구 (Bull/Bear/Judge 각 1단락 + 단일 호출 강제). 04_PROJECT_SPEC.md §5 본문 박힘.
- ✓ **P0-4**: 면책 한국어 1차 초안 본문 — 자본시장법 제6조 제5항·제17조 명시. 02_DATA_MODEL.md 공통 frontmatter 갱신 + 01_PRD.md §1 법적 경계 본문 박힘. 후속 변호사 검토 권고.
- ✓ **P0-5**: 출력 토큰 추정 ~3,110 (Phase 1) / ~3,710 (Phase 2) (한계 6,000의 52~62%) — PASS 추정. 13명 평가 ~600 + Lean Canvas ~800 + Mom Test ~300 + Pre-mortem ~360(Ph1)/~600(Ph2+) + Bull ~375 + Bear ~375 + Judge ~150 + frontmatter ~250 + 헤더 ~300. 한국어 1.5배 보정. Phase 1 첫 평가 시 실측 확정.

### 변경 (Changed)
- 13관점 → 13명 다관점으로 명칭 통일 (모든 PRD 5개 파일)
- `13-perspectives/SKILL.md` → `13-personas/SKILL.md` 명칭 변경
- 02_DATA_MODEL.md `persona_13_scores` 예시: 영문 코드 → 한국어 명칭 (시니어개발자·시니어보안·비개발자·QA 등)

### 스키마
- schema_version: 1.1 → 1.2 (모든 PRD 파일 + frontmatter 통일)

### 정책 추가 (DO NOT / ALWAYS DO 보강)
- ALWAYS DO: success_criteria 자동 매칭 규칙 1줄 (카탈로그 5개 중 도메인·자본·시간 따라 1~2개 선택)

### 완성도 갱신
- README.md 완성도: 9.0 → **9.5** (v1.0=8.5, v1.1=9.0, v1.2=9.5)

---

## v1.1 — 2026-05-07 (PRD self-review reflected, A 권고 반영)

### 정책
- **API 호출 최소화 정책 채택** — 사용자 요청. 멀티 에이전트 분리 호출 금지. 단일 호출 내부에서 다관점 강제.
- Phase 3 외부 호출(deep-research/WebSearch)은 default 비활성 + 사용자 명시 호출 시만 활성으로 격상.

### 추가 (Added)
- **5단계 적대 토론 (Bull/Bear/Judge)** — 13관점 → Lean Canvas → Mom Test → Pre-mortem 4프레임 다음에 단일 호출 내부에서 적대 토론 강제. Phase 1 P1.
- **Karpathy Goal-Driven Execution 패턴** — `success_criteria`(verdict가 맞으려면 X 측정값 Y 이상) + `consistency_score`(N=3회 평가 분포 표준편차) frontmatter 강제. Phase 1 P1.
- **수동 테스트 시나리오 5건 사전 정의** — `tests/manual-scenarios.md` 본문. Phase 1 완료 기준 명확화. P1.
- frontmatter 확장 필드: `model_id`·`temperature`·`debate_mode`·`consistency_score` (재현성·검증 가능성 강화).

### 변경 (Changed)
- 4프레임 → **5단계** (적대 토론을 5단계로 추가)
- `bc-idea-evaluator` 단일 서브에이전트가 내부 3관점(Bull/Bear/Judge)을 한 응답에 강제 — `bc-bull-advocate`·`bc-bear-critic`·`bc-devil-judge` 별도 분리하지 않음 (API 절약).
- Phase 3 외부 호출 정책: 사용자 명시 호출 시만 활성, default 비활성.

### 보강 (DO NOT 추가)
- "별도 호출로 멀티 에이전트 분리하지 마 (API 비용)" 규칙 추가.
- "사용자 명시 동의 없이 외부 API 호출하지 마" 규칙 강화 (Phase 3 default 비활성).

### 보강 (ALWAYS DO 추가)
- "단일 호출 내 5단계(13관점·Lean Canvas·Mom Test·Pre-mortem·적대 토론) 강제"
- "verdict 출력 시 success_criteria + consistency_score 동반"
- "API 호출 최소화 — 한 명령 = 한 응답이 원칙"

### 스키마
- schema_version: 1.0 → 1.1

---

## v1.0 — 2026-05-07 (initial)
- Initial PRD generated via Show Me The PRD (Claude Code/Codex 플러그인 형태)
- 5개 문서 작성: 01_PRD·02_DATA_MODEL·03_PHASES·04_PROJECT_SPEC·README
- 4프레임(13관점·Lean Canvas·Mom Test·Pre-mortem) 명시
- 기존 환경(bkit·페르소나 hook·MEMORY.md) 영향 차단 가드레일 명시
