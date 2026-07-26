# business-counselor — 디자인 문서

> Show Me The PRD로 생성됨 (2026-05-07)
> 한국 사용자 본인용 Claude Code/Codex 플러그인
> **버전: v1.2 (2026-05-07 self-review #2 반영 — 페르소나 v5 13명 다관점 매칭 + P0 5개 해소)**
> 변경 이력: ../CHANGELOG.md

---

## 한 줄 요약

**AI 사업 카운슬러 플러그인** — 사용자 본인의 과거·현재·자산·역량 맥락을 누적해서 (1) 사업/창업 아이디어 추천 (2) 가져온 아이디어를 **5단계(페르소나 v5 13명 다관점·Lean Canvas·Mom Test·Pre-mortem·적대 토론 Bull/Bear/Judge)**로 냉철하게 판독. **모든 단계가 단일 호출 안에서 수행** (API 절약, Karpathy Goal-Driven Execution 패턴 적용). 13명 = 시니어 개발자·보안·비개발자·QA·DevOps·AI·디자이너·UX·PM·경영진·**변호사**·비용·**전문 투자자**.

---

## 문서 구성

| 문서 | 내용 | 언제 읽나 |
|------|------|----------|
| [01_PRD.md](./01_PRD.md) | 뭘 만드는지, 누가 쓰는지, 핵심 기능, 안 만드는 것 | 프로젝트 시작 전·아이디어 검토 시 |
| [02_DATA_MODEL.md](./02_DATA_MODEL.md) | 6개 엔티티(Profile·Session·GeneratedIdea·EvaluatedIdea·MarketResearch·DecisionLog) 구조 | 파일 구조 설계할 때 |
| [03_PHASES.md](./03_PHASES.md) | Phase 1(인터뷰+판독) → 2(추천+Pre-mortem) → 3(외부 리서치) | 개발 순서·시작 프롬프트 정할 때 |
| [04_PROJECT_SPEC.md](./04_PROJECT_SPEC.md) | 기술 스택, DO NOT, ALWAYS DO, 가드레일 | AI에게 코드 시킬 때 매번 |

---

## 빠른 시작 (개발 시작 시)

### Phase 1 (1~2주, MVP)
[03_PHASES.md의 "Phase 1 시작 프롬프트"](./03_PHASES.md#phase-1-시작-프롬프트-복사해서-바로-사용)를 복사해서 Claude Code에 붙여넣으세요.

핵심:
- 명령: `/business-counselor:start`, `/business-counselor:resume`, `/business-counselor:evaluate`, `/business-counselor:list`, `/business-counselor:show`
- 데이터: `~/Documents/business-counselor/`
- 외부 호출 0

### Phase 2 (+1~2주, 추천)
- 명령 추가: `/business-counselor:recommend`, `/business-counselor:decide`
- 4프레임 완성 (Pre-mortem 추가)
- DecisionLog 활성

### Phase 3 (+2~3주, 외부 리서치)
- 명령 추가: `/business-counselor:research`, `/business-counselor:followup`, `/business-counselor:stats`
- deep-research 또는 WebSearch 폴백 사용

---

## 기술 스택 한 줄

**Claude Code 네이티브 플러그인 + AGENTS.md 미러 (Codex 호환)**. 마크다운+JSONL 데이터. DB·서버·인증 0.

---

## 가드레일 (필수 — 항상 지킬 것)

| 규칙 | 이유 |
|------|------|
| 모든 명령 `/business-counselor:*` 네임스페이스 | 다른 플러그인과 충돌 방지 |
| 모든 서브에이전트 `bc-` prefix | 동일 |
| AGENTS.md는 플러그인 폴더 안에만 | 의도치 않은 글로벌 인식 차단 |
| 기존 hook·CLAUDE.md·MEMORY.md·user_persona*.md 절대 수정 X | 사용자 환경 보존 |
| 모든 출력 frontmatter에 disclaimer + success_criteria + consistency_score + model_id + temperature + debate_mode 자동 삽입 | 자본시장법 면책 + Karpathy Goal-Driven Execution + 재현성 |
| Phase 1·2에서 외부 송신 0 / Phase 3는 사용자 명시 호출 시만 | 로컬 보관 + API 절약 정책 |
| **단일 호출 5단계 강제 — Bull/Bear/Judge 분리 호출 금지** (v1.1) | API 비용 1/3 + 양측 증거 동시 평가 |
| **`/business-counselor:evaluate` 호출 시 추가 서브에이전트 호출 0** (v1.1) | 한 명령 = 한 응답 원칙 |

---

## 법적 경계 (필수 인지)

- 본 도구는 **참고용 의견 생성 도구**입니다.
- **자본시장법상 투자자문업·창업컨설팅업 인가 받지 않았습니다.**
- 모든 결정·실행 책임은 사용자 본인에게 있습니다.
- 특정 종목·금융상품 추천이 아닙니다.
- 변호사·세무사 자문이 필요한 사안은 전문가 상담을 권고합니다.

---

## 미결 사항 종합 ([NEEDS CLARIFICATION])

> 개발 시작 전 또는 진행 중 결정 필요한 사항

### 01_PRD.md
- [ ] 파일 저장 경로 확정
- [ ] 인터뷰 카테고리 6종 최종 확정
- ✓ ~~13관점 한국어 명칭 페르소나 일치 검증~~ → **v1.2 페르소나 v5 13명 다관점 1:1 매칭 완료**
- ✓ ~~Pre-mortem 시나리오 개수~~ → Phase 1=3개, Phase 2부터 5개 (v1.1 결정)
- ✓ ~~deep-research 폴백 방식~~ → Phase 3 사용자 명시 호출 시만, 미설치 시 WebSearch 폴백 (v1.1 결정)
- [ ] decisions.jsonl 형식 확정
- [ ] 시드 데이터 동봉 여부
- ✓ ~~버전 관리~~ → schema 1.0→1.1 갱신 완료 (v1.1)
- [ ] **v1.1 신규**: 적대 토론 system prompt 최종 문구
- [ ] **v1.1 신규**: success_criteria 표준 카탈로그

### 02_DATA_MODEL.md
- [ ] profile_snapshot_hash 알고리즘
- [ ] decisions.jsonl 회전 정책
- [ ] research/*.md TTL 만료 처리
- [ ] 다국어 필드 지원 여부
- [ ] 인터뷰 카테고리 6종 외 추가 여부 (가족·건강·도덕적 신념)
- [ ] **v1.1 신규**: bull_arguments·bear_arguments 최소·최대 개수
- [ ] **v1.1 신규**: consistency_score 임계값

### 04_PROJECT_SPEC.md
- [ ] 라이선스 (MIT vs 비공개)
- [ ] Codex AGENTS.md 활성 시점
- [ ] 면책 조항 한국어 문구 최종안 (법무 검토 권장)
- ✓ ~~13관점 한국어 라벨 페르소나 일치~~ → **v1.2 페르소나 v5 13명 1:1 매칭 완료** (04_PROJECT_SPEC.md §13명 다관점 표)
- [ ] Phase 3 외부 호출 한도
- [ ] 백업 정책
- [ ] **v1.1 신규**: 출력 토큰 < 6,000 한계 검증
- [ ] **v1.1 신규**: 적대 토론 시스템 프롬프트 최종 문구

---

## 다음 단계 (v1.2)

1. **읽기**: 01 → 02 → 03 → 04 순서 (변경 이력은 ../CHANGELOG.md)
2. **결정**: 미결 사항 중 P1 우선순위 미리 정함 (특히 라이선스·면책 한국어 문구·적대 토론 시스템 프롬프트)
3. **Phase 1 시작**: 03_PHASES.md의 "Phase 1 시작 프롬프트(v1.2)" 복사 → Claude Code 붙여넣기
4. **수동 테스트 5건**: ../tests/manual-scenarios.md (이미 작성됨) 시나리오 1~5 순서대로 실행
5. **회귀 매트릭스 PASS 확인 후 Phase 2 진입** (시나리오 5건 모두 PASS + 시나리오 5의 환경 무결성 검증 포함)

---

## 생성 완성도

**9.5 / 10** (v1.2 self-review #2 P0 5개 해소 후. v1.0=8.5, v1.1=9.0)

### 강점 (v1.1)
- 사용자 의도("냉철한 판독")와 정렬된 **5단계** 명시 (4프레임 + 적대 토론)
- **단일 호출 적대 토론 (Bull/Bear/Judge)** — 진짜 차별점·해자. ChatGPT/Cursor 일반 인터뷰와 결정적 차이
- **API 호출 최소화 정책** — 한 명령 = 한 응답. 별도 서브에이전트 분리 호출 금지 (사용자 요구 반영)
- **Karpathy Goal-Driven Execution** — success_criteria + consistency_score frontmatter 강제로 verdict 정량 검증 가능
- **재현성** — model_id·temperature·debate_mode 모두 frontmatter 명시
- 자본시장법 회색지대 명시적 면책 + frontmatter 자동화
- 기존 환경(bkit·everything-claude-code·페르소나 hook 등) 영향 차단 가드레일 상세
- Phase 분리 의존성·기간·회귀 테스트 명확 + 5건 시나리오 사전 정의(`tests/manual-scenarios.md`)
- DB 0 / 외부 송신 Phase 3만 + 사용자 명시 호출 시만 / 마크다운+JSONL 단순성 유지

### 개선 여지 (v1.2 후속)
- ✓ ~~13관점 한국어 라벨 user_persona.md와 1:1 매칭 미확인~~ → **v1.2 매칭 완료** (페르소나 v5 13명 다관점 직접 채택)
- 면책 조항 한국어 문구 법무 검토 미수행
- Phase 3 외부 호출 비용 한도 미확정
- 시드 데이터(예제 프로필·평가) 동봉 여부 미결정
- 적대 토론 시스템 프롬프트 최종 문구 미확정
- success_criteria 표준 카탈로그 미작성
- consistency_score 임계값 미확정 (Phase 2 측정 시작 후 결정)
- 출력 토큰 < 6,000 한계가 5단계 동시 출력에 충분한지 실측 미수행

### 다음 결정 트리거
- Phase 1 종료 후 사용자 1주 사용 → 인터뷰 카테고리·적대 토론 품질 충분 여부 결정
- 5건 평가 누적 후 → 13명 다관점 점수 분포 안정성 + Bull/Bear 균형 확인 → 가이드라인 조정
- Phase 2 진입 시 → consistency_score 실측 시작 → 임계값 데이터 기반 결정
