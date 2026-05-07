# CHANGELOG — business-counselor

> 본 PRD·플러그인 변경 이력. schema_version은 frontmatter에 명시.

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
