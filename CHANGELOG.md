# CHANGELOG — business-counselor

> 본 PRD·플러그인 변경 이력. schema_version은 frontmatter에 명시.

---

## [플러그인] v0.6.7 — 2026-08-04 (법률/저작권/라이선스/상업적 용도 전수 점검, 문서 전용 릴리스)

### 배경
공개·배포·납품·상업적 사용 시 문제가 없도록 법률/저작권/라이선스 관련 파일·문서를 전수 점검. LICENSE는
Apache-2.0 공식 원문 그대로(저작권 고지 블록 정상 기재)라 수정 불필요로 확인. 의존성 파일(package.json 등)
자체가 없어 라이선스 충돌 점검은 해당 없음. 이미지·폰트·미디어 자산도 0건 확인. 실사용자 데이터·PII·실존
브랜드명이 저장소에 포함된 적이 없음을 git 이력 전체 대상으로 확인.

### 확인됨 (사실)
- LICENSE = Apache License 2.0 공식 원문, 저작권 고지("Copyright 2026 SoDam AI Studio") 정상 기재
- NOTICE 파일 없음 — 원본 저작물이라 Apache-2.0 §4(d) 요건 미해당으로 판단(단, 최종 결론은 법무 검토 권장)
- 의존성 파일(package.json·requirements.txt 등) 자체가 없어 서드파티 라이선스 충돌 리스크 없음
- assets/public/이미지·폰트·미디어 파일 0건 — 별도 자산 라이선스 확인 불필요
- templates/·PRD/·commands/·agents/·skills/ 전체 대상 실존 브랜드명·전화번호·주민번호 형식·실개인이메일
  패턴 스캔 0건, 실사용자 데이터(profile.md 등)가 저장소에 커밋된 적 git 이력 전체에서 0건

### 보완 (Added) — README.md·README_EN.md §17 동일 반영
- **17.0(신규)**: "이 프로젝트를 어디까지 쓸 수 있는지"를 비개발자용 쉬운 말 3줄(가능/직접확인/금지)로 요약
- **17.1 보완**: NOTICE 파일 부재 사유 명시 + [법무/전문가 검토 필요] 표시
- **17.2 보완**: "AI 생성 콘텐츠 확인 의무" 신설 — 상업적 활용 전 상표·유사저작물·출처 직접 확인 요구,
  저작권 비침해를 보장하지 않는다는 문구 + [법무/전문가 검토 필요] 표시
- **17.5 확장**: 포크·서비스 운영·교육 자료 활용·고객사 납품 4개 항목을 표에 명시적으로 추가
- **17.6(신규)**: Anthropic 자체 요금제·Usage Policy·데이터 정책은 이 플러그인이 보장하지 않으며 사용자가
  직접 확인해야 함을 명시 + 미디어 자산 0건 재확인 문구
- README.html·README_EN.html은 기존과 동일하게 pandoc으로 정본 md에서 재생성(내용 100% 일치 유지)

### 결정 필요 / 법무 검토 필요 (임의로 결론 내리지 않음)
- NOTICE 파일 필요 여부의 최종 법적 판단
- AI 생성 콘텐츠(§1~§5 분석·추천 아이디어)의 저작권 귀속·제3자 저작물 유사성 침해 여부의 최종 판단
- 실제 상업적 재배포·해외 배포 시 관할 법령 차이(현재 문서는 국내 자본시장법 조문만 인용)

---

## [플러그인] v0.6.6 — 2026-08-04 (README 4종 종합 갱신, 문서 전용 릴리스)

### 배경
README(한/영, md+html 4개 파일)가 v0.5.2 시점에 정지돼 있어 Phase 2(v0.6.0~v0.6.5) 변경 사항이 전혀
반영되지 않은 상태였음. HTML 2개는 원본 md보다도 오래돼 있었음(Jul 27 vs Aug 3~4).

### 변경 (Changed)
- 버전 헤더 v0.5.2 → v0.6.5, "Phase 1 MVP" → "Phase 1+2 실사용 확인됨"으로 갱신
- 업데이트 내용 요약(토글) 섹션에 v0.6.0~v0.6.5 6개 버전 항목 신규 추가(한/영 동일)
- "작동 방법"·"워크플로우" 섹션에 두 번째 엔진(`bc-idea-generator`)·`recommend`→`decide` 흐름·
  `profile_snapshot_hash` 실계산 방식 반영
- 설치 문제 대처 표에 "완전 재시작 + 새 대화창" 강조 및 실사용 중 확인된 캐시 동기화 이슈 안내 추가

### 방법 (How)
- README.md·README_EN.md를 정본으로 직접 갱신
- README.html·README_EN.html은 **pandoc으로 정본 md에서 직접 생성**(수작업 이중 작성 대신 기계적 변환으로
  내용 100% 일치를 구조적으로 보장) — 변환 중 앵커 태그(`<a id="...">`)와 바로 다음 줄 제목(`##`)이 붙어
  있으면 pandoc이 제목을 일반 텍스트로 잘못 처리하는 실제 버그 발견 → md 원본에 빈 줄 삽입으로 수정
  (19곳 × 2언어, GitHub 렌더링에는 영향 없음)

### 확인됨
- 변환 후 h2 태그 21개(섹션 19개 + 목차 + 라이선스 요약) 정상 생성, `##`가 본문에 문자 그대로 남은 곳
  1건(의도된 코드 예시 블록)뿐임을 확인
- `<details>` 토글 13개(신규 6 + 기존 7) 정상 렌더링 확인
- 기능 코드 변경 없음(문서 전용)

---

## [플러그인] v0.6.5 — 2026-08-04 (`profile_snapshot_hash` 가짜값 수정 + 린터 오탐 수정)

### 배경
`recommend 5` 실사용 성공(v0.6.4) 직후 `/business-counselor:show idea-...`로 실제 생성된 파일을 열어보니,
5개 파일 전부 `profile_snapshot_hash`가 동일한 값이었고 AI 스스로 "실제 SHA-256이 아니라 코드 실행 불가로
생성된 플레이스홀더"라고 밝힘. 실제 파일(`~/Documents/business-counselor/ideas/generated/*.md`)을 직접
열어 확인 — 진짜 문제였음.

### 근본 원인
`bc-idea-generator`·`bc-idea-evaluator` 두 에이전트 모두 `tools: Read, Write, Glob`만 가지고 있어 코드
실행이 불가능한데, frontmatter 스펙은 "SHA-256을 계산해서 기록하라"고만 지시하고 있었음 — LLM은 암호화
해시 함수를 암산으로 정확히 계산할 수 없으므로, 애초에 요구사항 자체가 에이전트 혼자서는 이행 불가능한
구조였음(구현 실수가 아니라 설계 단계의 구조적 공백).

### 수정 (Fixed)
- **`commands/recommend.md`·`commands/evaluate.md`**: 에이전트 호출 전 메인 세션이 Bash(`node -e` +
  `crypto` 모듈)로 실제 SHA-256을 계산해서 값으로 전달하는 Step 추가. 정규화 알고리즘(필드 10개 알파벳순
  정렬 → `필드명=값` 줄바꿈 결합 → SHA-256)은 실제 profile.md로 직접 검증 완료
- **`agents/bc-idea-generator.md`·`agents/bc-idea-evaluator.md`**: frontmatter 템플릿을 "전달받은 값을
  그대로 기록, 직접 계산 금지"로 수정. `bc-idea-evaluator.md`는 기존 `"(미구현, Phase 2)"` 리터럴 문자열도
  함께 정리(Phase 2가 활성화됐으므로)
- **`tests/frontmatter-linter.ps1`·`tests/frontmatter-linter.sh`**: 위 검증 과정에서 린터 자체의 오탐도
  함께 발견 — `ideas/generated/`(GeneratedIdea)에 `ideas/evaluated/`(EvaluatedIdea)와 동일한 6필드 전체를
  요구하고 있었음. `02_DATA_MODEL.md`가 이미 확정한 대로 GeneratedIdea는 `success_criteria`·
  `consistency_score`·`debate_mode`를 의도적으로 제외(적대 토론·verdict 단계 없음)하므로, generated/는
  `model_id`+`temperature`만 요구하도록 필드셋 분리

### 확인됨 (실측 + 정적 검증)
- 정규화 알고리즘을 실제 `profile.md`(10개 필드, null 포함)로 직접 실행해 유효한 SHA-256 산출 확인
- 린터 수정 후 실제 사용자 데이터(12개 파일, evaluated 5 + generated 5 + profile + session) 전부 PASS —
  수정 전에는 generated/ 5개 파일이 (린터 오탐으로) FAIL 표시됐었음
- 변경분 시크릿 노출 스캔 0건

### 참고 (범위 밖으로 남겨둔 항목)
- 기존에 이미 생성된 5개 추천 파일의 가짜 해시값은 이번 수정으로 소급 정정되지 않음(향후 새로 생성되는
  파일부터 적용) — 사용자 데이터 파일이라 별도 요청 없이는 임의로 덮어쓰지 않음
- `profile.md`의 `skills`/`domain_interests` 필드가 콤마 포함 항목을 따옴표 없이 배열에 넣고 있어 엄격한
  YAML 파서 기준 잠재적 파싱 모호성 발견(실제 파일에서 확인) — `raw_idea`/`title`/`note`와 같은 유형이나
  `start.md`/`resume.md` 범위라 이번 수정에는 포함하지 않음, 별도 확인 필요

---

## [플러그인] v0.6.4 — 2026-08-03 (`list`·`show`가 Phase 2 추천 아이디어를 못 찾던 결함 수정)

### 배경
"지금까지 구현된 기능이 제대로 작동하는지" 재검증 중 `commands/list.md`·`commands/show.md`를 다시 읽어보니
둘 다 `ideas/evaluated/`(판독 결과)만 스캔/검색하고 있었음 — Phase 2에서 추가된 `ideas/generated/`(추천
아이디어)는 전혀 다루지 않음. `PRD/03_PHASES.md` 122행에 "과거 추천·판독 교차 참조(`/business-counselor:
show`에 관련 항목 표시)"가 Phase 2 기능 목록에 **미체크 항목**으로 이미 명시돼 있었고, `commands/help.md`는
이미 "list/show가 판독·추천 둘 다 보여준다"고 안내하고 있었음(실제 구현과 안내 문구가 어긋난 상태) —
`commands/decide.md`의 ID 분기 규칙 주석에도 "show.md와 동일 패턴"이라는 문구가 있어, 애초에 show.md도
같이 분기 처리될 것으로 가정하고 작성됐으나 실제로는 반영되지 않았던 것으로 확인됨.

### 재현
1. `/business-counselor:recommend 5` → `idea-2026-08-03-001` 등 생성
2. `/business-counselor:show idea-2026-08-03-001` 실행 → `evaluated/`에서만 검색해 "해당 ID의 평가를
   찾을 수 없습니다" 오안내(파일은 `generated/`에 실제로 존재)
3. `/business-counselor:list` 실행 → 추천 아이디어는 목록에 아예 나타나지 않음(판독만 있으면 정상, 추천만
   있으면 "평가 기록이 없습니다"로 오안내)

### 수정 (Fixed)
- **`commands/show.md`**: `decide.md`와 동일한 ID 분기 규칙(`eval-*`→`evaluated/`, `idea-*`→`generated/`)
  적용. "파일 없음" 메시지도 "평가"→"기록"으로 일반화(추천 아이디어에도 맞게)
- **`commands/list.md`**: `evaluated/`·`generated/` 두 폴더를 모두 스캔해 "판독 기록"·"추천 기록" 두
  테이블로 분리 출력. 기록 없음 메시지에 `recommend` 안내 추가

### 확인됨 (정적 검증 결과)
- frontmatter 린터 재실행 PASS
- 변경분 시크릿 노출 스캔 0건
- `commands/help.md`의 기존 안내 문구("판독·추천 목록 보기" 등)와 이번 수정이 일치함을 확인(문서는 이미
  Phase 2를 반영해뒀는데 구현만 안 따라간 상태였음 — 문서 추가 수정 불필요)

---

## [플러그인] v0.6.3 — 2026-08-03 (설치본 동기화 근본 원인 재정정 + YAML 이스케이프 결함 2건)

### 배경
v0.6.2에서 "설치본 git 클론 미갱신"으로 진단·수정했으나, 이후 새 세션에서도 동일 증상(`recommend`
Unknown command·`help` 구버전 문구) 재현. 재조사 결과 실제 원인은 더 깊은 곳에 있었음 — Claude Code의
플러그인 로딩은 ①marketplace git clone → ②버전별 캐시 폴더 → ③`installed_plugins.json` 포인터 3단계를
거치며, 새 세션은 오직 ③만 읽는다. ②에는 이미 최신 버전 캐시가 만들어져 있었는데 ③ 포인터가 옛 버전
(`0.5.1`)을 계속 가리키고 있었던 것이 근본 원인. `installed_plugins.json`을 백업 후 직접 최신 버전으로
갱신해 해결(상세 절차는 메모리 `claude-code-plugin-update-silent-failure` 참조).

이어서 `evaluate`·`recommend` 결과 파일 생성 로직을 경계값 관점에서 추가 검토, 같은 유형의 결함 2건 발견.

### 수정 (Fixed)
- **`agents/bc-idea-evaluator.md`**: frontmatter `raw_idea` 필드(사용자 아이디어 원문을 그대로 삽입)에
  큰따옴표·역슬래시·줄바꿈 이스케이프 규칙이 없어, 아이디어 설명에 큰따옴표가 포함되면(예: 브랜드명 인용)
  평가 결과 파일의 YAML frontmatter 전체가 파싱 불가능해질 수 있는 결함 발견 → 이스케이프 규칙 명시 추가
  (`commands/decide.md`의 `note` 필드 JSON 이스케이프 누락과 동일 유형)
- **`agents/bc-idea-generator.md`**: frontmatter `title` 필드에도 동일 유형 방어 규칙 추가(AI가 직접 짓는
  문구라 발생 확률은 낮으나, 브랜드명 인용 등으로 발생 가능성 있어 동일 규칙 적용)

### 확인됨 (정적 검증 결과)
- frontmatter 린터 재실행 PASS, 변경분 diff는 순수 추가(10줄, 삭제 0) — 기존 템플릿 구조 무변경 확인
- 변경분 시크릿 노출 스캔 0건

---

## [플러그인] v0.6.2 — 2026-08-03 (경계값/예외 입력 검토 + 설치본 동기화 함정 발견)

### 배경
사용자 실사용 시도에서 `recommend`가 "Unknown command"로 실패 → 설치본이 v0.5.1에 멈춰 있던 게 원인
(GitHub main 대비 7커밋 뒤처짐). 설치 경로에서 직접 `git pull`로 수정(v0.6.1 반영). 이어서 Phase 2
명령의 경계값·잘못된 입력 케이스를 재검토.

### 수정 (Fixed)
- **`commands/decide.md`**: `note` 필드에 큰따옴표·역슬래시·줄바꿈이 포함되면 JSON 이스케이프 없이
  그대로 삽입되어 `decisions.jsonl`이 손상될 수 있는 경계값 결함 발견 → 이스케이프 규칙 명시 추가
- **`commands/recommend.md`**: `N` 검증이 "숫자가 아니면"으로만 되어 있어 `3.5` 같은 소수 입력을
  걸러내지 못하는 모호함 발견 → "정수가 아니면"으로 명확화

### 문서화 (Docs)
- **`CHECKPOINT.md`**: `/plugin` 업데이트가 UI상 문제없어 보여도 실제 설치본(git 클론)이 갱신 안 될 수
  있음을 실측 기록. 재발 시 설치 경로에서 직접 `git pull origin main`으로 수정 가능함을 절차화

### 확인됨 (정적 검증 결과)
- JSON 유효성(plugin.json·marketplace.json) PASS, frontmatter 린터 PASS, 시크릿 노출 0건
- 설치본(marketplace 클론)이 저장소 main과 커밋 해시 완전 일치 확인(`e2aa2a4`)
- `commands/`·`agents/`·`skills/` 실제 파일 목록이 PRD 스펙과 1:1 일치(누락·잉여 0건)

---

## [플러그인] v0.6.1 — 2026-08-03 (PRD-vs-구현 전수 감사 + 문서 드리프트 수정)

### 배경
Phase 2 활성화(v0.6.0) 이후 "PRD대로 전부 구현됐는지" 감사 요청. 코드 자체(plugin.json·commands·agents)는
전부 PRD와 일치했으나, **사용자 대면 문서 3종이 Phase 2를 전혀 반영하지 못한 상태**로 발견됨 — 실제로는
이미 있는 기능을 "없다"고 안내하는 상태였음.

### 수정 (Fixed) — 문서가 실제와 어긋남
- **`commands/help.md`**: "명령 6개"만 안내, `recommend`·`decide` 누락 → 8개로 갱신, 추천 흐름·명령 목록에 추가
- **`README.md`/`README_EN.md`** (5개 지점 동일):
  - §7 사용법 가이드에 "AI가 먼저 아이디어 추천" 단계 자체가 없었음 → 추가
  - §8 명령어 표에 `recommend`·`decide` 행 누락 → 추가
  - §11 파일 트리 "명령어 7개"·에이전트 1개·데이터폴더 목록(evaluated만) → 9개·에이전트 2개·`ideas/generated/`+`decisions.jsonl` 추가로 정정
  - §12 아키텍처 다이어그램 "서브에이전트 1개·스킬 5종" → 2개·6종 + recommend 라우팅 추가
  - **§16 FAQ가 사실과 반대로 안내** — "AI가 알아서 추천 안 해줌 (아직 없음)"이라고 답하고 있었으나 v0.6.0부터 `recommend`가 이미 존재 → 정정
- **`agents/bc-idea-generator.md`**: 출력 frontmatter에 `model_id`·`temperature`(재현성 필드) 누락 → 추가
  (`bc-idea-evaluator.md`에는 있었으나 generator 작성 시 누락됨)
- **`PRD/02_DATA_MODEL.md`**: GeneratedIdea 필드 표에도 위와 동일하게 `model_id`·`temperature` 추가.
  단, `bull_arguments`·`debate_mode`·`success_criteria`·`consistency_score`는 추천(recommend)에 적대 토론·
  verdict 단계가 없어 **의도적으로 계속 제외** — 197행의 "EvaluatedIdea·GeneratedIdea 한정"이라는 부정확한
  요약 문구도 함께 정정

### 확인됨 (변경 없음)
- `plugin.json`·`commands/`·`agents/`·`skills/` 실제 코드는 PRD와 100% 일치(이번 감사로 새로 발견된 코드
  결함 0건) — 어긋난 건 전부 사용자 대면 문서 쪽이었음

---

## [플러그인] v0.6.0 — 2026-08-02 (Phase 2 활성화: 아이디어 추천·결정 기록)

### 배경
`CHECKPOINT.md` M1(edit·resume 실사용 검증)을 사용자가 새 세션에서 직접 실행해 통과 확인(총평 기준, 원문:
"이미 사용 해봤음. 그래서 내가 다음 phase로 넘어가려는거야"). M1·M2가 done으로 갱신되어 Phase 1 완료 전제
조건이 충족됐고, 이전 라운드에 안전하게 격리 준비해둔 `phase2-draft/`를 실제 위치로 활성화.

### 추가 (Added)

- **`/business-counselor:recommend [N]`** — 누적 프로필 기반 사업 아이디어 N개(기본 5, 최대 10) 추천, 각각
  Lean Canvas 포함. `bc-idea-generator` 서브에이전트를 단일 호출로만 사용(Phase 1과 동일한 안전 패턴)
- **`/business-counselor:decide <id> <go|drop|iterate|defer> ["메모"]`** — 아이디어 결정을 `decisions.jsonl`에
  append-only로 기록. `eval-*`/`idea-*` ID 접두사로 `ideas/evaluated/`·`ideas/generated/` 자동 분기
- **`skills/pre-mortem/SKILL.md`** — Pre-mortem 시나리오를 Phase 1의 인라인 3개에서 5개로 확장하는 정식 스킬
- **`agents/bc-idea-generator.md`** — 프로필 기반 아이디어 생성 전문 에이전트. `bc-idea-evaluator`와 동일하게
  `tools: Read, Write, Glob`만 부여해 서브에이전트 분기·외부 API 호출을 런타임 수준에서 차단
- `plugin.json`의 `agents` 화이트리스트 배열에 `bc-idea-generator` 추가(자동 등록 아님 — 명시적 등록 필요)

### 알려진 제약 (Known limitation)

- 위 4개 기능은 **정적 검증(JSON 유효성·frontmatter 린터·시크릿 스캔)만 통과**했고, 실제 자연어 대화로
  실행하는 실사용 검증은 아직 미실행 — AI가 대행할 수 없는 영역(`tests/manual-scenarios.md`의
  "Phase 2 진입 전 회귀 매트릭스" 참조)

---

## [플러그인] v0.5.3 — 2026-08-02 (세션 파일 덮어쓰기 버그 수정 + M1 검증 문서 정정)

### 배경
`CHECKPOINT.md`의 M1(시나리오 2·6 실사용 검증)을 실행하기 전, 7단계 절차를 실제 파일과 한 단계씩 대조 검토.
그 결과 **M1을 그대로 완주하면 실사용 데이터가 손실되거나 정상 동작이 FAIL로 기록되는 요인**을 발견해 선제 수정.

### 수정 (Fixed) — 치명

- **`commands/start.md` 세션 파일명 `001` 하드코딩 → 같은 날 세션 기록 덮어쓰기**
  - 증거: `start.md`는 `sessions/{YYYY-MM-DD}_001.md`로 **고정**, `resume.md`는 `{NNN}` 당일 순번,
    `evaluate.md`는 "그날 최대 번호 +1" + "파일 *수* +1 금지" 경고까지 명시 — **세 명령의 규칙이 서로 달랐음**
  - 실패 경로: M1 순서가 `resume`(2단계) → 프로필 삭제(5단계) → `start`(7단계)라, **하루에 완주하면
    resume이 만든 `_001.md`를 start가 같은 이름으로 다시 만들어 덮어씀** = M1의 resume 검증 증거가 그 자리에서 소실
  - 수정: `start.md`를 `evaluate.md`와 **동일한 채번 규칙**("그날 `sessions/` 최대 NNN +1, 없으면 001")으로 통일
  - 함께 수정: `resume.md`의 "당일 순번"도 같은 문구로 명확화 — 세 명령 중 하나만 애매하게 남기면
    이번 버그를 만든 것과 **똑같은 드리프트가 재발**하므로 (신규 규칙 발명 아님, 저장소 기존 문장 이식)

### 수정 (Fixed) — 검증 문서 오류

- **`CHECKPOINT.md` M1 done-when이 정상 동작을 FAIL로 판정** — "resume이 **1개만** 재질문해야 통과"라고 했으나,
  실 `profile.md`의 `monthly_income_krw`가 null이고 `resume.md` 매핑이 **자본 → `capital_krw`+`monthly_income_krw`**
  2필드라 스펙대로 동작해도 2건을 묻는 게 정상. 판정 기준을 **"이미 채워진 필드 재질문 0건"**으로 정정
- **`CHECKPOINT.md`가 자기 위험표의 치명 항목을 검증하지 않음** — 위험표는 "`sessions/`나 `ideas/evaluated/`까지
  같이 삭제됨 = 치명"이라 적었는데 체크리스트에는 `ideas/evaluated/`만 있었음 → `sessions/` 확인 항목 추가
- **`CHECKPOINT.md`에 M1의 파괴적 성격이 미기재** — 5단계가 실사용 `profile.md`를 실제 삭제하고 7단계가
  30~40분 재인터뷰를 요구하는데 그 비용·백업 절차가 없었음 → 사전 백업/사후 복원 절차를 M1 선행 조건으로 명시
- **설치 경로 오기** — `results-template.md`·`CHECKPOINT.md`가 `~/.claude/plugins/business-counselor/`를 설치 경로로
  기재. 실측 결과 그 폴더엔 `plugin.json`이 없고 옛 `data/` 잔존물만 있으며, **실제 구동본은
  `%APPDATA%\claude-code\plugins\marketplaces\business-counselor-marketplace`**(GitHub 클론) → 정정
- **명령 개수 "5개" 잔존** — v0.5.0에서 6→7개로 늘렸으나 `manual-scenarios.md` 시나리오 5와
  `results-template.md`에 "5개"가 남아 **`edit`·`help` 2개가 네임스페이스 충돌 검사에서 누락**돼 있었음 → 7개로 정정

### 추가 (Added)

- `CHECKPOINT.md`에 "M1에서 나와도 버그가 아닌 것" 표 신설 — ① resume이 월 수입도 묻는 것 ② edit이 frontmatter만
  비우고 본문 답변은 남기는 것 ③ 홈 루트 `AGENTS.md`(**내용 확인 결과 Codex 전역 설정, 이 플러그인과 무관** — 실측)
- `manual-scenarios.md` 시나리오 6에 "같은 날 `resume`→`start` 연속 실행 시 세션 파일 미덮어쓰기" 검증 항목 추가
  (본 릴리스 수정분의 회귀 방지)

### 스키마/버전
- schema_version 1.2 유지(데이터 구조·필드·경로 무변경). 플러그인 0.5.2 → 0.5.3(patch — 명령 프롬프트 버그 수정
  + 검증 문서 정정, 신규 기능 0).

### 미완료 (Pending)
- **본 수정은 push → 플러그인 업데이트 → Claude Code 완전 재시작을 거쳐야 실사용에 반영된다.** 미반영 상태로
  M1을 실행하면 덮어쓰기 버그가 그대로 재현됨
- M1(시나리오 2·6) 자체는 여전히 사람이 새 세션에서 직접 실행해야 함 (AI 대행 불가)

---

## [플러그인] v0.5.2 — 2026-07-27 (비개발자용 종합 README 신규 작성 — 한/영, md+html 4종)

### 배경
사용자 요청: "AI, 메신저, 컴퓨터, 모바일 기기, 전자기기, IT 기기 등을 처음 다루는 사람들이 정말 쉽게 이해
할 수 있도록" 목차·설치·사전 준비물·필요 프로그램·다운로드·빠른 시작·실행/사용/작동 방법·명령어·업데이트
요약(토글)·파일 위치·워크플로우·아키텍처·보안/데이터 흐름·문제 대처·FAQ·법률/저작권/라이선스/상업적 용도를
모두 포함하는 종합 README를 한국어(기본)·영어 두 언어, 각각 md·html 두 형식으로, 내용이 서로 동일하게
프로젝트 최상위에 작성.

### 추가/변경 (Added/Changed)
- **README.md**: 기존 요약형 문서를 18개 섹션(§0 읽는 법 ~ §18 부록)으로 전면 확장 재작성. 신규 섹션:
  다운로드 방법(설치와 분리), 실행 방법(설치 후 첫 실행 검증), 작동 방법(내부 동작 원리 — 단일 호출·냉철
  모드), 아키텍처(다이어그램+기술스택 표), 보안·데이터 흐름(데이터 흐름도+런타임 강제 원칙), 업데이트 내용
  요약(`<details>` 토글, 버전별 CHANGELOG.md 요약), FAQ 12문항, 법률·저작권·라이선스·상업적 용도(§17, 5개
  하위 절 — 소프트웨어 라이선스/결과물 권리/법적 면책/개인정보/상업적 용도 요약표)
- **README_EN.md**: 위와 동일 구조로 전량 영문 번역(기계적 1:1 대응 아님, 자연스러운 영어 문장으로 재작성)
- **README.html · README_EN.html** (신규 파일): 각각 README.md·README_EN.md와 **내용을 동일하게** 유지한
  독립 실행형 HTML(외부 리소스 0, 인라인 CSS, 라이트/다크 테마 자동 대응, `<details>` 네이티브 토글)
- 설치 방법에 "업데이트 방법"·"제거(삭제) 방법" 절 신규 추가(기존에는 설치만 있고 업데이트/제거 안내가
  없었음 — 누락 보완)
- 상업적 용도 판단 기준 명시: 플러그인 코드(Apache-2.0, 상업적 이용·재판매 가능) vs 분석 결과물(사용자
  소유, 정확성 미보장이므로 별도 검증 필요) vs 도구 자체를 투자/법률 자문으로 제공하는 것(권장하지 않음)을
  구분

### 변경 이유 (근거)
- 다운로드/설치/실행/사용/작동을 분리한 이유: 사용자가 명시적으로 5개 항목을 각각 요청 — 겹치는 개념이라도
  각 절의 역할을 절 서두에서 구분해 모순 없이 배치(다운로드=코드 확보, 설치=Claude Code 등록, 실행=최초
  구동 확인, 사용=기능별 절차, 작동=내부 원리)
- 라이선스 섹션에 "엄격한 기준" 적용: Apache-2.0 조건(고지·변경명시)·무보증·책임제한·상표권 미부여를
  원문 그대로 요약하고, 이 도구 특유의 법적 면책(자본시장법 제6조 제5항·제17조 등 기존 PRD/데이터모델
  frontmatter의 면책 문구)을 별도 절로 분리해 소프트웨어 라이선스와 서비스 성격 면책을 혼동하지 않도록 구성
- 업데이트 내용 요약을 토글로 처리한 이유: 전체 CHANGELOG.md 원문을 그대로 복사하면 README가 지나치게
  길어짐 — 요약만 접어서 보여주고 원문 링크로 연결(중복 최소화)

### 스키마/버전
- schema_version 1.2 유지(데이터 구조 무변경). 플러그인 0.5.1 → 0.5.2(patch — 문서 전용, 기능 변경 없음).

### 미완료 (Pending)
- 없음(문서 작업 자체는 완결). 기능적으로는 `CHECKPOINT.md`의 M1(edit·resume 실사용 검증)이 여전히 다음
  단계로 남아있음(본 릴리스와 무관, 별도 트랙).

---

## [플러그인] v0.5.1 — 2026-07-27 (검증 중 발견 결함 3건 수정)

### 배경
`/business-counselor:edit` 추가 후 정합성 검증(린터·JSON·독립 에이전트 교차검증·실 profile.md 대조) 중 발견.

### 수정 (Fixed)
- **`risk_appetite` 문서-구현 불일치**: `02_DATA_MODEL.md`가 `conservative/balanced/aggressive`로
  문서화했으나 실제 구현(`start.md`)과 실 데이터는 `low/medium/high` 사용 중 — 문서를 실제 구현에 맞춰 정정
- **`capital_krw`/`monthly_income_krw` 단위 불일치**: 문서는 "만원 단위"(예: 5000)라 했으나 실제로는
  원 단위 그대로 저장(예: 20000000, 필드명 `_krw`와 일치) — 문서 정정
- **README/README_EN 파일 트리 주석**: `commands/` 옆 "6개" 표기가 `edit` 추가 후 갱신 안 됨 → 7개로 정정
- `resume.md`에 "완료된 필드를 사용자가 자발적으로 정정하려 하면 `edit`로 안내" 규칙 추가(resume/edit 역할 경계 명확화)

### 스키마/버전
- schema_version 1.2 유지(실 데이터 형식 변경 없음, 문서만 실제와 일치시킴). 0.5.0 → 0.5.1(patch — 문서
  정정 + 명령 파일 1개 소규모 규칙 추가, 신규 기능 없음).

---

## [플러그인] v0.5.0 — 2026-07-27 (프로필 수정·삭제 명령 추가 — `/business-counselor:edit`)

### 배경
프로필 최초 생성(v0.4.0에서 처음 실증)까지는 됐지만, 이미 답한 항목을 바꾸거나(수정) 지우는(제거) 것은
명령으로 할 방법이 없었다. `/business-counselor:resume`은 "빈 항목만 채우기" 전용이라 이미 채워진 값은
건드리지 않는다. 사용자 요청: "플러그인 설치 후 플러그인으로도 프로필을 추가/수정/제거 할 수 있도록 하기."

### 추가 (Added)
- **`/business-counselor:edit "요청"`** 신규 명령 — 자연어 요청을 3가지로 판별해 처리:
  1. 필드 값 변경 (예: "자본을 3000만원으로 바꿔줘") — 현재값→새값 확인 후 반영
  2. 필드 비우기 (예: "관심도메인 지워줘") — 확인 후 해당 필드만 null
  3. 프로필 전체 삭제 (예: "프로필 전체 삭제해줘") — **비가역 경고 + 확인 필수**, `profile.md`만 삭제
     (`sessions/`·`ideas/evaluated/`는 별도 자산이라 보존)
- `id`·`schema_version`·`last_updated`·`profile_updates`·`disclaimer` 5개 시스템 관리 필드는
  이 명령의 수정 대상에서 명시적으로 제외
- `profile_updates` 배열이 이제 `resume`의 "(추가)"뿐 아니라 `edit`의 "(수정)"·"(비움)" 이력도 함께 기록
- `tests/manual-scenarios.md`에 시나리오 6(edit) 신설 — 값 변경·비우기·삭제취소·삭제확정·삭제후평가기록보존까지 검증

### 변경 (Changed)
- 명령 6개 → **7개**로 확장(`help.md`·`AGENTS.md`·README 2종·PRD 5문서 전부 동기화)
- `04_PROJECT_SPEC.md` 가드레일에 "확인 없는 프로필 삭제 금지" 규칙 추가

### 스키마/버전
- schema_version 1.2 유지(Profile 필드 구조 무변경, `profile_updates` 값 형식만 확장). 플러그인
  0.4.0 → 0.5.0(minor) — 새 명령 추가.

### 미완료 (Pending)
- 새 명령의 실 E2E 검증은 다음 새 세션에서 필요 (시나리오 6 절차대로).

---

## [플러그인] v0.4.0 — 2026-07-27 (데이터 저장 위치 이전 — `.claude/` 밖으로, 실 E2E에서 발견된 저장 실패 결함)

### 배경
실 E2E(새 세션, `/business-counselor:evaluate "동네 카페 사장님들을 위한 재고 관리 앱"`)에서 평가가 §1~§5까지
전부 완료되고 verdict(no-go/28)까지 나왔으나, 결과 파일을 `~/.claude/plugins/business-counselor/data/ideas/evaluated/`에
저장하는 단계에서 2회(서브에이전트 1회 + 상위 세션 직접 재시도 1회) 시스템 보호 장치에 막혔다.

### 원인 (실측 확인 — 직접 재현)
같은 문제를 이 저장소를 관리하는 세션에서 직접 재현: `~/.claude/plugins/business-counselor/data/ideas/evaluated/`뿐
아니라 `~/.claude/plugins/` 바로 아래, `~/.claude/` 루트까지 전부 AI 직접 쓰기가 차단됨을 확인했다(Write 도구·Bash
리다이렉트 두 가지 다른 방식으로 재현, 우연이 아님). 반면 `~/.claude/` 바깥 경로는 정상적으로 쓰기가 됐다. 즉
`~/.claude/` 전체가 "시스템 설정"으로 보호 대상이 되어 있어, 하위 경로를 아무리 바꿔도 `.claude/` 안에 있는 한
해결되지 않는다. 이 플러그인의 코드(`plugin.json`·`commands/`·`agents/`·`skills/`)는 여전히 `~/.claude/plugins/`
안에 정상 설치되어 동작한다 — 막힌 건 **AI가 새로 쓰는 사용자 데이터**뿐이다.

### 수정 (Changed) — Breaking
- 데이터 저장 위치: `~/.claude/plugins/business-counselor/data/` → **`~/Documents/business-counselor/`**
- 하위 구조는 동일하게 유지: `profile.md`·`sessions/`·`ideas/evaluated/`·`ideas/generated/`·`decisions.jsonl`
  (`data/` 한 겹만 없어지고 나머지 트리는 그대로)
- 문서 17개(README 2종·AGENTS.md·CLAUDE.md·PRD 4문서+README·명령 6개·에이전트·테스트 2종) 경로 표기 전체 동기화
- 린터 2종(`frontmatter-linter.sh`/`.ps1`) 기본 검사 경로도 동일하게 변경
- 기존 실사용 평가 3건(2026-06-15_eval-001~003.md)을 새 위치로 **바이트 단위 동일하게 이전 완료**(크기 확인:
  11908·13373·18609 바이트, 원본과 일치) — 사용자가 수동으로 옮길 필요 없음
- `PRD/02_DATA_MODEL.md`에 이전 사유 명시(목적 변경이 아니라 "사람이 직접 읽고 수정 가능"이라는 원래 목적을
  지키기 위한 이전이라는 점을 문서화)

### 왜 이 방향인가 (기각한 대안 포함)
- ~~기존 경로 유지 + 매번 수동 복사~~: 대상 사용자(비개발자·바이브코더)에게 평가할 때마다 수동 파일 이동을
  강제하는 건 MVP 목표("매일 쓸 수 있는 수준")와 정면 충돌해 기각
- ~~사용자 머신의 보호 장치에 예외 등록~~: 이 저장소 밖의 결정이라 이식성이 없고(다른 머신 재설치 시 재발),
  이 플러그인 하나의 편의를 위해 사용자의 전역 안전장치를 건드리는 건 범위 밖이라 기각
- `~/Documents/business-counselor/`: `.claude/` 보호 범위 밖 + 비개발자가 파일 탐색기에서 별도 설명 없이
  찾을 수 있는 위치라 채택

### 스키마/버전
- schema_version 1.2 유지(필드 구조 무변경, 저장 경로만 변경). 플러그인 0.3.0 → 0.4.0(minor) — 사용자 데이터
  경로가 바뀌는 실사용 영향이 있는 변경이라 patch가 아닌 minor로 격상.

### 미완료 (Pending)
- 새 위치로 이전 후 실제 `/business-counselor:evaluate` 저장이 정상 통과하는지는 다음 새 세션 E2E에서 확인 필요
  (이번 수정은 근본 원인 분석·경로 변경까지이며, 변경 후 재현 테스트는 별도).

---

## [플러그인] v0.3.0 — 2026-07-27 (명령 이름 간소화 — `counsel-` 접두어 제거)

### 배경
`/business-counselor:counsel-evaluate`처럼 플러그인 이름(`business-counselor`)과 명령 접두어
(`counsel-`)가 의미상 중복돼 명령이 불필요하게 길다는 사용자 피드백. 플러그인 네임스페이스
자체가 이미 `business-counselor:`이므로 `counsel-`은 정보량 없이 글자 수만 늘리고 있었음.

### 변경 (Changed) — Breaking
- 명령 파일 6개 rename: `counsel-start.md`→`start.md`, `counsel-resume.md`→`resume.md`,
  `counsel-evaluate.md`→`evaluate.md`, `counsel-list.md`→`list.md`, `counsel-show.md`→`show.md`,
  `counsel-help.md`→`help.md`
- 새 명령: `/business-counselor:start`·`/business-counselor:resume`·`/business-counselor:evaluate`·
  `/business-counselor:list`·`/business-counselor:show`·`/business-counselor:help`
  (구 `/business-counselor:counsel-*` 형태는 더 이상 동작하지 않음 — 파일명이 곧 라우팅이므로)
- 네임스페이스 가드레일 재정의: `/business-counselor:counsel-*` → `/business-counselor:*`
  (모든 PRD·README·AGENTS.md·CLAUDE.md·에이전트·스킬·테스트 문서 19개 파일 동기화)
- Phase 2/3 계획 명령명도 동일 규칙으로 통일(아직 미구현, 문서만): `counsel-recommend`→`recommend`,
  `counsel-decide`→`decide`, `counsel-research`→`research`, `counsel-followup`→`followup`,
  `counsel-stats`→`stats`

### 스키마/버전
- schema_version 1.2 유지(데이터 스키마 무변경). 플러그인 0.2.2 → 0.3.0(minor) — 명령 표면(public
  interface) 변경이라 patch가 아닌 minor로 격상. `claude plugin update`가 버전 미변경 시 재동기화하지
  않는 특성(v0.2.2에서 확인)상, 기존 설치 사용자가 새 명령을 받으려면 이 버전 상승이 필수.

### 주의 (기존 설치 사용자)
- 기존에 `/business-counselor:counsel-*` 형태를 북마크·메모해둔 경우 전부 무효화됨. 업데이트 후
  `/business-counselor:help`로 새 명령 목록 확인 권장.

---

## [플러그인] v0.2.2 — 2026-07-27 (명령 네임스페이스 표기 정정 — 실 E2E에서 발견된 치명 결함)

### 배경
새 세션에서 실제로 플러그인을 설치하고 명령을 실행하는 E2E 검증 중, `/counsel:start`·`/counsel:resume`는
(사용자가 실제 등록된 이름을 보고 `/business-counselor:counsel-start` 형태로 직접 입력해) 정상 동작했으나,
문서에 적힌 그대로 `/counsel:evaluate "..."`를 입력하자 **"Unknown command"로 3회 연속 실패**했다.

### 원인 (실측 확인)
Claude Code 플러그인의 슬래시 명령은 `/<플러그인 이름>:<명령 파일명>` 형태로만 등록되며, 명령 파일
frontmatter의 `name:` 필드로 임의의 네임스페이스(`counsel:`)를 지정해도 실제 라우팅에는 반영되지 않는다.
즉 `/counsel:xxx`는 **애초에 한 번도 작동한 적이 없는 표기**였고, 실제 동작하는 유일한 형식은
`/business-counselor:counsel-xxx`이다. `tests/manual-scenarios.md`에 2026-05-07 초안 시점부터
"명령·에이전트 충돌 시 prefix 강화(`/counsel:` → `/business-counselor:`) 검토"라는 대비책이 이미
적혀 있었던 것으로 보아, 설계 당시에도 이 가능성이 완전히 배제되지는 않았던 것으로 보인다.

### 수정 (Fixed)
- `commands/*.md` 6개 파일의 frontmatter `name:` 필드 및 본문 예시를 `business-counselor:counsel-*`로 정정
- `README.md`·`README_EN.md`·`AGENTS.md`·`CLAUDE.md`·`agents/bc-idea-evaluator.md`·`skills/mom-test/SKILL.md`
  의 모든 명령 예시·안내 문구 정정
- `PRD/01_PRD.md`·`03_PHASES.md`·`04_PROJECT_SPEC.md`·`PRD/README.md`의 네임스페이스 규칙·예시 전면 정정
  (규칙 자체는 "플러그인 자동 접두사 네임스페이스 강제"로 재해석 — 목적은 동일, 표기만 정정)
- `tests/manual-scenarios.md`·`tests/results-template.md`의 테스트 명령 예시 정정
- 비개발자용 E2E 테스트 가이드(Artifact)의 복사-붙여넣기 명령 4곳 정정 후 재게시

### 검증 (Verified / 미검증)
- 새 세션에서 `/business-counselor:counsel-start`·`/business-counselor:counsel-resume` 실제 동작 확인(정상)
- **후속 재검증(같은 날)**: `/business-counselor:counsel-evaluate`도 정상 인식·실행 확인 —
  모호 입력 시 보강 질문 2개 정상 유도, 프로필 없을 때 확인 질문(`counsel-evaluate.md` 49~50행 스펙대로) 정상 출력.
  단, 5단계 전체 출력(§1~§5 + verdict)까지는 아직 도달 못 함(사용자가 "프로필 없이 진행" 여부 미응답).
- 인터뷰(`/business-counselor:counsel-start`)는 생애사 질문 2개까지만 진행되고 사용자가 아직 미답변 — profile.md 미생성 상태

### 스키마/버전
- schema_version 1.2 유지. 플러그인 0.2.1 → 0.2.2(patch) — 이 버전 상승 자체가 필요했던 이유:
  `claude plugin update`는 버전 번호가 그대로면 최신 커밋을 다시 받아오지 않음(실측 확인) — 버전을
  올리지 않으면 이미 설치한 사용자가 `update`만으로는 이 치명 결함 수정을 받을 수 없었음. 아래
  v0.2.2(마켓플레이스 등록 개선) 항목과 함께 이번 버전에 포함.

---

## [플러그인] v0.2.2 — 2026-07-27 (마켓플레이스 등록 방식 개선)

### 배경
`marketplace.json`의 `name`이 `"local-plugins"`로 설정돼 있어 README가 git clone 후 로컬 경로로만
등록하는 방법만 안내하고 있었음. 실측 결과 `claude plugin marketplace add sodam-ai/business-counselor`로
GitHub 저장소를 직접 참조해 등록하는 것이 이미 가능함을 확인 — 진짜 원인은 마켓플레이스 이름이었음
(형제 플러그인들은 모두 고유 마켓플레이스 이름을 사용 중이었는데 이 저장소만 제네릭한 이름).

### 수정 (Fixed)
- `marketplace.json`: `name` `"local-plugins"` → `"business-counselor-marketplace"` (형제 플러그인 명명 관례 일치)
- README.md·README_EN.md: GitHub 직접 등록을 방법 A(권장)로 승격, git clone 방법은 방법 B로 재배치,
  ZIP 방법은 방법 C로 이동. 모든 설치 명령에서 `@local-plugins` → `@business-counselor-marketplace`

### 검증 (Verified)
- `claude plugin marketplace add sodam-ai/business-counselor` 실측 성공 확인(클론 없이 GitHub 직접 등록)

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
- **시나리오 5 스테일 경로 (신규 발견, 심각)**: `tests/results-template.md`의 환경 무결성 스냅샷이
  1개월 이상 방치된 구 프로젝트 경로(`D--AI-Tool-CLI-LLM-Claude-Code`)를 참조 → 그대로 실행 시
  실제 변경을 놓치는 **허위 PASS** 위험. 실측(2026-07-26)으로 라이브 경로(`C--Users-PC`, 최근
  수정 확인)로 교체 + 프로젝트 폴더명이 바뀔 수 있음을 주석으로 명시 + settings.json 후보 2곳 모두 해시.
- **13-personas 출처 인용 죽은 링크**: `PRD/04_PROJECT_SPEC.md`·`skills/13-personas/SKILL.md`가
  인용하던 `user_persona_triggers.md`가 구경로·라이브 경로 어디에도 존재하지 않음(sodam-persona
  플러그인으로 재구성되며 폐기됨, 2026-07-26 확인). 13명 다관점 **내용 자체는 정상**(P0-1 채택
  스냅샷을 의도적으로 고정) — 인용문만 "폐기된 스냅샷" 사실을 정확히 반영하도록 수정.
  ⚠️ 현재 라이브 페르소나 체계는 15명(#14 회계세무·#15 마케팅 추가)이나 13→15 동기화는
  **범위 밖**(별도 결정 필요, 이번 수정에서 확장하지 않음).

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
- **E2E 시나리오 4(핵심 경로) 실측 통과**: `/business-counselor:counsel-evaluate` 실제 실행 → §1~§5 + frontmatter 정상, 린터 PASS. v0.1.1 수정(§4 확률+완화책·#11/#13 ⚠️·단일호출·verdict 강제하향·NNN·환각태깅) 전부 실동작 확인.
- **실측 발견**: 출력 ~11,900자(≈6~8k 토큰)로 PRD `<6,000` 목표 초과 → 본 버전에서 압축 규칙으로 대응.

### 추가 (Added)
- **「한눈 요약」 카드**: 평가 출력 맨 위 TL;DR(판정 ✅/⚠️/⛔·확신도·강점·막힌곳·다음행동). 색·기호 단독 의존 금지(텍스트 라벨 병기=접근성). `agents/bc-idea-evaluator.md`·`templates/evaluation.template.md` 반영.
- **`/business-counselor:counsel-help` 명령**: 명령 5개·추천 흐름·전문용어 풀이를 한 장에(비개발자 온보딩·접근성). 용어집을 매 평가 인라인 대신 help에 모아 토큰 절약. AGENTS.md·README 2종 등록.
- **「타겟 고객의 한마디」(§1 부록)**: 13명 전문가 패널과 별개로, 실제 '돈 낼 고객' 1인칭 예상 반응(첫반응·거부이유·현재대안·지갑여는조건)을 §1 표 아래 추가. 13행 표·5단계·페르소나 1:1 정합 무수정(부록 형태). §3 Mom Test와 "가설↔검증"으로 연결해 중복 회피. agents·template·help 반영.

### 고도화 (Improved)
- **출력 분량 원칙(깊이 우선)**: 브레비티는 「한눈 요약」 카드가 담당 → §1~§5 본문은 분석 깊이 보존. 줄이는 건 불필요한 반복·중복(특히 frontmatter bull/bear ↔ §5 본문)뿐. `<6,000` 토큰은 강제 → **가이드로 강등**(깊이와 충돌 시 깊이 우선). ※ 초기 "줄 수 하드캡" 방침은 분석 정확도 저하 우려로 철회(사용자 피드백 반영).

### 고도화 (Improved, 추가)
- **화면/저장 분리(점진적 공개)**: 깊은 §1~§5는 파일에 그대로 저장하되, **화면 응답은 「한눈 요약」 카드 + show 안내까지만** 출력. 실사용자가 5쪽을 강제로 읽지 않게 함 — 압축이 아니라 *안 보여줄 뿐*이라 깊이 손실 0. 사용자 피드백("출력이 너무 길다") 반영.
- **2단계 기본/전체 모드**: 기본 `/business-counselor:counsel-evaluate`=「한눈 요약」 카드만 생성(빠름·짧음), `"...전체"`/`--full`=§1~§5 전체 생성. 두 모드 모두 13관점·적대토론 **내부 추론 필수**(verdict 품질 유지). 속도·길이 동시 해결. 사용자 피드백('전체는 선택에 따라 작성') 반영. frontmatter `mode: summary|full` 기록.

### 미검증 (Pending)
- 한눈 요약·압축의 실제 토큰 절감 효과는 다음 `/business-counselor:counsel-evaluate` 실행에서 재확인 필요(빌드≠작동).
- 시나리오 1(인터뷰→profile)·2(resume)·5(환경 무결성) 실 E2E 미완.

### 스키마/버전
- schema_version 1.2 유지. 플러그인 0.1.1 → 0.2.0 (신규 명령 추가 = minor).

---

## [플러그인] v0.1.1 — 2026-06-15 (Phase 1 안정화 + 기존 기능 고도화)

### 수정 (Fixed) — 정합성 결함 6건
- **린터 과잉 검증 버그**: `frontmatter-linter.sh`가 모든 .md에 6필드를 요구해 `/business-counselor:counsel-start` 직후 profile.md·세션 파일이 FAIL하던 문제 → 파일 유형별 검증(모든 파일=disclaimer+schema_version, evaluated/generated=6필드)으로 수정. 02_DATA_MODEL.md 정합.
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
- 수동 시나리오 5건 실 E2E (사용자가 플러그인 설치 후 `/business-counselor:counsel-*` 실행 — `tests/results-template.md`로 기록).

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
