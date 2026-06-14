# business-counselor — PRD (Product Requirements Document)

> 생성일: 2026-05-07
> 생성 도구: Show Me The PRD (Claude Code)
> 한국 사용자(개인, 비개발자) 본인 사용 전용
> **버전: v1.2 (2026-05-07 self-review #2 반영 — 페르소나 v5 13명 다관점 매칭 + P0 5개 해소)**
> 변경 이력: ../CHANGELOG.md

---

## 1. 제품 개요

### 한 줄 요약
**AI 사업 카운슬러** — Claude Code/Codex 플러그인 형태로 작동하며, 사용자 본인의 과거·현재·자산·역량 맥락을 누적해서 (1) 사용자에게 맞는 사업/창업 아이디어를 추천하고 (2) 사용자가 가져온 아이디어를 **5단계(페르소나 v5 13명 다관점 + Lean Canvas + Mom Test + Pre-mortem + 적대 토론 Bull/Bear/Judge)**로 냉철하게 판독한다. 13명 = 시니어 개발자·보안·QA·DevOps·AI·디자이너·UX·PM·경영진·**변호사**·비용·**전문 투자자**·비개발자 — 각자 1~5점 평가.

### 해결하는 문제
- **객관적 시점 부재**: 본인의 아이디어를 평가할 때 자기 확신 편향에 빠지기 쉬움
- **맥락 반영의 어려움**: 일반적인 컨설팅·블로그 조언은 "내 자본·시간·역량·관심사"를 모르고 일반론만 제시
- **검증 비용**: 검증 프레임워크(Mom Test·Lean Canvas·Pre-mortem)를 매번 수동으로 적용하기 번거로움
- **재방문 부재**: 한 번 평가한 아이디어를 시간이 지난 후 시장 변화 반영해 재평가하는 시스템 부재

### 핵심 가치 (차별점)
1. **누적 프로필 기반**: 인터뷰로 사용자 맥락을 마크다운에 누적 → 모든 추천·판독이 사용자 맞춤
2. **5단계 강제**: 13관점·Lean Canvas·Mom Test·Pre-mortem 4프레임 + 적대 토론 1단계 자동 적용 (수동 적용 부담 0)
3. **냉철 모드 기본**: 사용자 의도("냉철한 판독")에 정렬, 긍정 편향 차단
4. **CLI 네이티브**: 별도 앱·웹 없음. 이미 쓰는 Claude Code/Codex 안에서 슬래시 명령으로 호출
5. **로컬 데이터**: 모든 민감 정보(자산·이력·아이디어) 로컬 파일. 외부 송신 0 (Phase 3 외부 호출도 사용자 명시 호출 시만 활성)
6. **단일 호출 적대 토론 (진짜 해자)**: Bull(긍정)/Bear(부정)/Judge(중재) 3관점을 **단일 응답 안에서** 강제 → API 분리 호출 0 (토큰·비용 절약) + Judge가 양측 증거 한 번에 봐서 판정 품질 ↑. 일반 ChatGPT 인터뷰와의 결정적 차이점.
7. **Goal-Driven Execution(Karpathy 패턴)**: 모든 verdict에 `success_criteria`(이 판정이 맞으려면 X 측정값 Y 이상) + `consistency_score`(N=3회 평가 분포 표준편차) 동반. 자기 편향·환각 자가 차단.

### 법적 경계 (필수 인지) — v1.2 본문 박힘

> 본 도구는 자본시장법 제6조 제5항(투자자문업) 및 제17조(인가요건) 적용을 받지 않는 사업·창업 아이디어 의견 생성 도구이며, 특정 종목·금융상품·재무상품 추천이 아닙니다. 본 도구의 모든 출력은 참고용 의견이며, 투자자문업·투자일임업·창업컨설팅업·세무자문·법률자문이 아닙니다. 모든 결정 및 실행의 책임은 사용자 본인에게 있으며, 변호사·세무사·재무자문가의 자문이 필요한 사안은 해당 전문가 상담을 권고합니다. 본 도구를 통한 의사결정으로 발생하는 손익 및 법적 책임 일체에 대해 도구 제작자는 책임지지 않습니다. 본 도구를 사용함으로써 위 면책 조항에 동의한 것으로 간주됩니다.

- 모든 출력에 위 면책 조항 자동 삽입 (frontmatter `disclaimer` 필드, 02_DATA_MODEL.md 공통 frontmatter 참조)
- 최종 판단·실행 책임은 사용자 본인
- 특정 종목·재무상품 추천 금지(필터 적용)
- 본 면책은 1차 초안. 향후 공개 시 변호사 검토 권고.

---

## 2. 사용자

### 주요 사용자
- **누구**: 본인 1명 (개인 도구). 비개발자, 비전문가, 자연어 바이브코딩 사용자
- **상황**: 새 사업 아이디어 떠올렸을 때 / 누군가의 아이디어를 평가받고 싶을 때 / 본인 상황에 맞는 사업 방향 탐색 시
- **목표**: 객관적·맥락 반영된 평가를 받아 의사결정 품질 향상

### 사용자 시나리오

**시나리오 1 — 첫 사용 (인터뷰)**
1. 사용자가 Claude Code에서 `/counsel:start` 입력
2. AI가 Mom Test 스타일 질문 던짐 ("지난 1년 동안 가장 시간을 많이 쓴 일은?")
3. 사용자 답변 → `~/.claude/plugins/business-counselor/data/profile.md`에 누적
4. 30~40분 인터뷰 후 프로필 1차 완성

**시나리오 2 — 아이디어 가져오기 (판독)**
1. 사용자가 `/counsel:evaluate "AI로 한국 부동산 매물 자동 분석"` 입력
2. AI가 누적 프로필 + 4프레임 적용
3. 13명 다관점(페르소나 v5) 점수표·Lean Canvas·Mom Test 검증 질문·Pre-mortem 위험 시나리오·Bull/Bear/Judge 적대 토론·go/no-go 권고 출력
4. 결과는 `data/ideas/evaluated/2026-05-07_eval-001.md`에 저장

**시나리오 3 — 추천 받기 (Phase 2)**
1. 사용자가 `/counsel:recommend 5` 입력
2. AI가 누적 프로필 기반 사업 아이디어 5개 + 각 Lean Canvas 출력
3. 사용자가 마음에 드는 1~2개에 대해 `/counsel:evaluate <id>`로 심층 판독

**시나리오 4 — 재방문 (Phase 3)**
1. 3개월 뒤 `/counsel:followup eval-001` 입력
2. AI가 deep-research로 시장 변화 수집 + 과거 판독과 비교
3. 결정 갱신(go→drop, drop→reconsider 등) → `decisions.jsonl`에 추가

---

## 3. 핵심 기능

| 기능 | 설명 | 우선순위 | 복잡도 |
|------|------|----------|--------|
| A. 자기 인터뷰 & 프로필 누적 (`/counsel:start`, `/counsel:resume`) | Mom Test 스타일 질문으로 과거·현재·자산·역량·관심사·리스크 성향 누적 | P1 (MVP) | 간단 |
| C. 가져온 아이디어 냉철 판독 (`/counsel:evaluate`) | 5단계(13명 다관점·Lean Canvas·Mom Test·Pre-mortem·적대 토론) 적용 후 점수·위험·go/no-go | P1 (MVP) | 보통 |
| **단일 호출 적대 토론 (Bull/Bear/Judge)** | 별도 서브에이전트 분리 호출 0 — 한 응답 안에서 3관점 강제. API 절약 + 양측 증거 동시 평가 | **P1 (MVP)** | 보통 |
| **Goal-Driven 성공 기준·일관성 점수** | 모든 verdict에 `success_criteria` + `consistency_score` frontmatter 자동 삽입 | **P1 (MVP)** | 간단 |
| 면책 조항 자동 삽입 | 모든 출력 frontmatter에 disclaimer 자동 추가 | P1 (MVP) | 간단 |
| B. AI 사업 아이디어 추천 (`/counsel:recommend`) | 누적 프로필 기반 N개 아이디어 + 각 Lean Canvas | P2 | 보통 |
| 결정 로그 (`/counsel:list`, `/counsel:show`) | 과거 추천·판독 검색·재참조 | P2 | 간단 |
| Pre-mortem 프레임 정교화 | "이 사업이 망한다면 왜?" 시나리오 5개 자동 생성 (Phase 1은 3개 OK) | P2 | 보통 |
| D. 외부 시장 리서치 (`/counsel:research`) | deep-research 또는 WebSearch 호출. **사용자 명시 호출 시만 활성** (default 비활성) | P3 | 복잡 |
| 재방문 (`/counsel:followup`) | 과거 아이디어 시장 변화 반영 재평가 | P3 | 보통 |
| 결정 통계 (`/counsel:stats`) | go/drop 비율·명중률 패턴 요약 | P3 | 간단 |

---

## 4. 사용자 흐름 (User Flow)

### 핵심 흐름 — 인터뷰 → 판독
```
/counsel:start → AI 질문 → 사용자 답 → profile.md 누적 → /counsel:evaluate <아이디어>
   → 4프레임 분석 → 점수·위험·go/no-go → evaluated/*.md 저장 → 면책 조항 출력
```

### 상세 흐름 (Phase 1 기준)

1. **인터뷰 시작 (`/counsel:start`)**: 처음이면 빈 profile.md 생성. AI가 Mom Test 스타일 6개 카테고리(생애사·자본·시간·역량·관심도메인·리스크 성향) 질문 시작
2. **누적 (`/counsel:resume`)**: 다음 세션에서 이어서. 부족 영역 자동 감지하여 우선 질문
3. **아이디어 입력 (`/counsel:evaluate "<idea>"`)**: 한 줄 또는 paragraph 입력. 모호하면 AI가 보강 질문 1~2개
4. **분석**: 5단계 자동 적용 — **단일 호출 내부에서 모두 수행 (별도 API 호출 0)**
   - § 1. 13명 다관점 (페르소나 v5 1:1 매칭): 시니어 개발자·보안·비개발자·QA·DevOps·AI·디자이너·UX·PM·경영진·변호사·비용·전문 투자자 각 1~5점 + 한 줄 코멘트. #11 변호사 + #13 투자자는 도메인 키워드 자동 강조.
   - § 2. Lean Canvas: 9블록
   - § 3. Mom Test: "이 사용자가 실제로 돈 낼 증거 있나" 검증 질문 5개 (과거 행동 기반)
   - § 4. Pre-mortem: "1년 후 망했다면 이유" (Phase 1은 3개 OK, Phase 2부터 5개 강제)
   - § 5. **적대 토론**: Bull(긍정 가능성 최대화) → Bear(실패 시나리오 발굴) → Judge(양측 증거 종합 후 최종 verdict)
5. **출력**: evaluated/*.md (5단계 섹션 + verdict + confidence + success_criteria + consistency_score + disclaimer frontmatter)
6. **결정 기록**: 사용자가 선택 시 `/counsel:decide <id> <go|drop|iterate>` → decisions.jsonl 1줄 추가

---

## 5. 성공 기준

### Phase 1 MVP 완료 기준 (정량화 — Karpathy Goal-Driven)
- [ ] `/counsel:start`로 인터뷰 시작·답변·profile.md 생성·세션 종료 후 재시작 정상 동작 (인터뷰 30~40분 범위)
- [ ] `/counsel:evaluate "<임의 아이디어>"` 입력 시 **5단계**(13관점·Lean Canvas·Mom Test·**Pre-mortem 3개**·적대 토론) 출력 정상
- [ ] 적대 토론 출력 시 **Bull / Bear / Judge 3섹션 명시 분리** (단일 호출 내부)
- [ ] 모든 출력 파일에 `disclaimer`·`success_criteria`·`consistency_score` 3개 frontmatter 필드 자동 삽입 (consistency_score는 Phase 1 placeholder OK)
- [ ] 명령 5개 모두 `/counsel:` 네임스페이스 (다른 플러그인과 충돌 0)
- [ ] 서브에이전트 1개(`bc-idea-evaluator`) 전용 (Phase 1은 단일 — bull/bear/judge 별도 분리 X). `bc-` prefix 강제
- [ ] AGENTS.md는 플러그인 폴더 안에만 존재 (사용자 홈/프로젝트 루트에 새 AGENTS.md 생성 금지)
- [ ] 기존 hook(SessionStart·UserPromptSubmit) 절대 수정·간섭 안 함
- [ ] **별도 서브에이전트 호출 0** (단일 호출 정책 — API 절약)
- [ ] **외부 API 호출 0** (Phase 1·2 정책)
- [ ] 출력 분량: 깊이 우선 (브레비티는 「한눈 요약」 카드, `<6,000`은 강제 아닌 가이드 — v0.2.0)
- [ ] 수동 테스트 시나리오 5건 모두 PASS (`tests/manual-scenarios.md`)

### Phase 2 추가 기준
- [ ] `/counsel:recommend 5` → 5개 아이디어 + 각 Lean Canvas 정상 출력
- [ ] generated→evaluate→decide 한 사이클 완전 동작
- [ ] Pre-mortem 프레임 추가로 4/4 완성

### Phase 3 추가 기준
- [ ] deep-research 미설치 시 WebSearch 폴백 정상
- [ ] research 캐시·TTL(7일) 동작
- [ ] `/counsel:followup` 시 과거 판독과 변경점 명확 표시

---

## 6. 안 만드는 것 (Out of Scope)

> 이 목록은 명시적으로 Phase 1~3 중 만들지 않습니다. AI에게 코드를 시킬 때 함께 공유하세요.

- **다중 사용자 지원** — 이유: 본인용 개인 도구. 인증·공유·권한 관리 일체 없음
- **웹 UI / 모바일 앱** — 이유: CLI 네이티브. Claude Code/Codex 안에서만 동작
- **데이터베이스(SQLite·Postgres 등)** — 이유: 마크다운/JSONL 파일이 데이터. 검색은 grep/find으로 충분
- **클라우드 동기화** — 이유: 로컬 보관 정책. 사용자가 원하면 Git private repo 수동으로
- **자동매매·실거래 연동** — 이유: 자본시장법 회색지대 회피. 본 도구는 의견 생성기, 실행은 사용자 본인
- **특정 종목·금융상품 추천** — 이유: 자본시장법상 투자자문 회색지대. 사업 아이디어만 다룸
- **법률·세무 자문 직접 답변** — 이유: 변호사·세무사 전문 영역. 일반론 + "전문가 상담 권고" 출력만
- **이미지·영상 생성** — 이유: 본 플러그인 범위 밖. 필요 시 다른 도구 사용
- **결제·과금 시스템** — 이유: 본인용. 무료
- **다국어 UI** — 이유: 한국어만. 사용자 언어 한국어
- **백업/복구 자동화** — 이유: Git 또는 OS 백업으로 충분. Phase 4+ 검토
- **별도 호출 멀티 에이전트 (Bull/Bear/Judge 분리 호출)** — 이유: API 비용 절약. 단일 호출 내부 토론으로 대체. `bc-bull-advocate`·`bc-bear-critic`·`bc-devil-judge` 별도 서브에이전트 만들지 X
- **default 활성 외부 API 호출** — 이유: API 절약 정책. Phase 3 외부 호출은 사용자가 `/counsel:research` 명시 입력 시만 활성. 자동 백그라운드 호출 0

---

## 7. [NEEDS CLARIFICATION]

> 개발 시작 전에 결정 필요한 사항. v1.1 self-review로 일부 해소됨(✓).

- [ ] **파일 저장 경로 확정**: 기본 `~/.claude/plugins/business-counselor/data/`. 사용자 환경(`C:\Users\PC\AppData\Roaming\claude-code\plugins\...`) 에서 작동 확인 필요
- [ ] **인터뷰 카테고리 6종 최종 확정**: 생애사/자본/시간/역량/관심도메인/리스크성향 6개로 충분한지, 아니면 가족·건강 추가 필요한지
- ✓ ~~**13관점 한국어 명칭 최종**~~ → **v1.2 페르소나 v5 13명 다관점 1:1 매칭 완료**. 영문 코드 폐기·전문가 시점 표 채택 (04_PROJECT_SPEC.md 참조).
- ✓ **Pre-mortem 시나리오 개수**: ~~5개? 7개?~~ → **Phase 1=3개 OK, Phase 2부터 5개 강제** (v1.1 결정)
- ✓ **deep-research 폴백 방식**: ~~미설치 시 WebSearch만? Codex Web search?~~ → **Phase 3 사용자 명시 호출 시만 활성. deep-research 우선·미설치 시 WebSearch 폴백** (v1.1 결정)
- [ ] **decisions.jsonl 형식 확정**: 최소 필드(timestamp, ideaId, action, note)만? confidence·context 추가?
- [ ] **시드 데이터(예제)**: 사용자가 바로 체험할 수 있는 더미 프로필·평가 예제 동봉 여부 (P2/P3 검토)
- ✓ **버전 관리**: ~~schema_version 1.0으로 시작~~ → **schema 1.0→1.1 첫 갱신 완료 (v1.1)**. 마이그레이션 정책: Phase 2 시작 시 1.1→1.2 가이드 작성
- [ ] **적대 토론 시스템 프롬프트 최종 문구**: Bull/Bear/Judge 각 1단락. v1.1 신규 항목.
- [ ] **success_criteria 측정 지표 표준 세트**: 일반론 vs 도메인 특화. v1.1 신규 항목.
