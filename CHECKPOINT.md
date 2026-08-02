# CHECKPOINT — business-counselor

> 마일스톤 + 검증 커맨드 + done-when. 세션이 바뀌어도 이 파일만 보면 "지금 뭘 해야 하는지" 알 수 있게 유지한다.
> 최종 갱신: 2026-08-02 · v0.6.0 · Phase 2 파일 활성화 완료(실사용 검증 대기) · Phase 3 파일 작성 완료(활성화 보류)

---

## 현재 상태 요약 (사실만, 추측 없음)

- Phase 1 명령 7개: 구현·설치·라이브 검증 완료: `start`·`resume`·`edit`·`evaluate`·`list`·`show`·`help`
- Phase 2 명령 2개(`recommend`·`decide`) + 스킬 `pre-mortem` + 에이전트 `bc-idea-generator`: **2026-08-02 파일 활성화 완료**(정적 검증 PASS), **실사용 검증은 미실행**(사용자가 아직 직접 실행 안 함)
- 데이터 위치: `~/Documents/business-counselor/` (구 `~/.claude/plugins/.../data/`에서 이전, 이유: `.claude/` 전체가 AI 직접 쓰기 차단 대상이라는 게 실측으로 확인됨)
- profile.md 실제 존재 확인, 평가 5건 누적 확인
  - 단, **본문 6개 카테고리는 전부 답변됐지만 frontmatter 4필드는 비어 있음**: `birth_year`·`residence`·`family_status`·`monthly_income_krw`
  - 이 중 앞 3개는 `resume.md`의 카테고리-필드 매핑에 아예 없어 `resume`으로는 채워지지 않음(채우려면 `edit`). 저심각도, 기능 차단 없음
- `tests/manual-scenarios.md` Phase 1 시나리오 **6/6 PASS**(시나리오 2·6은 사용자 자체 검증 기준, `tests/results/2026-08-02_run-001.md` 참조)
- `tests/results/` 폴더 생성됨, 정식 기록 1건 존재

### 실제 설치 경로 (2026-08-02 실측 — 기존 기재가 틀렸음)

- 구동본: `%APPDATA%\claude-code\plugins\marketplaces\business-counselor-marketplace` (GitHub 클론, `business-counselor@business-counselor-marketplace: true`)
- `~/.claude/plugins/business-counselor/`는 **설치본이 아님** — `plugin.json`이 없고 옛 `data/` 잔존물만 있음
- 저장소(v0.5.2) ↔ 설치본(v0.5.1) 차이는 `git diff 5475fea..main` 결과 **README 4종·CHANGELOG·CHECKPOINT·버전 표기뿐**. `commands/`·`agents/`·`skills/` 변경 0건
- → **저장소 수정은 push·플러그인 업데이트·Claude Code 완전 재시작을 거쳐야 실사용에 반영됨**

---

## M1: 시나리오 2·6 실사용 검증 (edit 명령 + resume 정상 경로)

### ✅ 상태: done — 사용자 자체 검증 완료 (2026-08-02)

사용자가 새 세션에서 직접 `edit`/`resume`을 포함한 실사용 테스트를 완료했고, 총평상 이상 없음을 확인함
(원문: "이미 사용 해봤음. 그래서 내가 다음 phase로 넘어가려는거야"). 아래 8단계 체크리스트는 참고용 원안으로
남겨두되, **개별 단계별 세부 로그는 AI가 직접 관찰한 것이 아니라 사용자의 총평 확인에 근거**한다.
(구체적 이상 징후가 나중에 발견되면 이 섹션을 다시 열어 기록할 것.)

### ⚠️ M1은 실사용 데이터를 파괴하는 테스트다 — 사전 준비 필수 (아래는 원래 계획 — 기록용 보존)

5단계에서 **실제 `profile.md`가 삭제되고**, 7단계에서 **30~40분 인터뷰를 처음부터 다시** 하게 된다.
6단계는 "평가 5건이 같이 지워질 수도 있다"를 전제로 한 검사다(아래 위험표 참조). 따라서:

- [x] **사전 백업 완료** — `~/Documents/business-counselor_BACKUP_pre-M1_20260802\` (7개 파일 SHA-256 전량 일치 확인, 2026-08-02)
- [ ] **M1 종료 후 복원**: 7단계에서 만든 새 프로필·세션을 확인만 하고, 백업 폴더 내용을 `~/Documents/business-counselor\`로 되돌린다 (원본 인터뷰 보존 → 재인터뷰 불필요)
- [ ] **선행 조건**: `commands/start.md` 세션 채번 수정(v0.5.3)이 **설치본에 반영된 뒤** 실행할 것. 미반영 상태로 하루에 완주하면 2단계 `resume`이 만든 세션 파일을 7단계 `start`가 덮어쓴다

### 검증 7단계

- [ ] `/business-counselor:edit "관심도메인 지워줘"` 실행 → 확인 질문 뜨는지, "네" 답변 후에만 반영되는지
- [ ] `/business-counselor:resume` 실행 → **방금 비운 `domain_interests` + 기존에 비어 있던 `monthly_income_krw`만** 질문하는지
      (⚠️ "1개만"이 아니다 — `resume.md`의 카테고리-필드 매핑상 **자본 → `capital_krw`+`monthly_income_krw`** 2필드이고 후자가 원래 null이라, 스펙대로 동작해도 2건을 묻는 것이 정상.
       **판정 기준은 "이미 채워진 필드를 재질문하지 않는가" 0건**)
- [ ] `/business-counselor:edit "프로필 전체 삭제해줘"` 실행 → 비가역 경고 + 확인 질문 뜨는지
- [ ] 확인 질문에 **"아니요"로 취소** → `profile.md`가 그대로 남아있는지 확인
- [ ] 다시 `/business-counselor:edit "프로필 전체 삭제해줘"` → 이번엔 **"네"** → 실제 삭제되는지
- [ ] 삭제 후 `~/Documents/business-counselor/ideas/evaluated/*.md`(과거 평가 5건)는 그대로 남아있는지 확인
- [ ] 삭제 후 `~/Documents/business-counselor/sessions/*.md`(과거 인터뷰 기록)도 그대로 남아있는지 확인
      (⚠️ 아래 위험표가 `sessions/` 동반 삭제를 **치명**으로 분류했는데 기존 체크리스트에 이 항목이 빠져 있었음 — 2026-08-02 추가)
- [ ] 삭제 후 `/business-counselor:start` 재실행 → 새 인터뷰가 정상 시작되는지 확인

**검증**: 위 8단계를 **새로 연 Claude Code 세션**에서 사람이 직접 실행 (AI 대행 불가 — 실제 자연어 대화·확인 응답 필요)
**done-when**: 8단계 전부 스펙대로 동작. 확인 질문 누락 0건, **이미 채워진 필드 재질문 0건**, 삭제 범위 오류(`sessions/`·`ideas/evaluated/`까지 같이 삭제됨) 0건
**상태**: done (사용자 자체 검증 완료, 2026-08-02 — 총평 기준, 세부 단계별 로그는 미기록)

### M1에서 나와도 버그가 아닌 것 (오판정 방지 — 2026-08-02 추가)

| 현상 | 왜 정상인가 |
|---|---|
| `resume`이 "월 수입"도 함께 물음 | `monthly_income_krw`가 원래 null. 위 판정 기준 참조 |
| 관심도메인을 비웠는데 본문 "## 5. 관심도메인" 답변이 그대로 보임 | `edit.md`는 frontmatter만 비우고 본문에는 "수정 이력" 한 줄만 추가하도록 설계됨 |
| 홈 루트 `C:\Users\PC\AGENTS.md`가 존재함 | 내용 확인 결과 **Codex 전역 설정**이며 이 플러그인과 무관 (2026-08-02 실측). 가드레일 위반 아님 |

### M1 예상 위험/실패 시나리오 (사전 검토)
| 위험 | 내용 | 실패 시 심각도 |
|---|---|---|
| 확인 질문 우회 | 사용자의 다른 맥락 발화("네" 등)를 AI가 삭제 확인으로 오인식 | **치명** — 사용자 동의 없이 프로필 소실 가능 |
| resume 오분류 | 방금 비운 필드를 "누락"이 아니라 "모호"로 잘못 분류해 다른 질문을 하거나, 이미 채워진 다른 필드를 재질문 | 중간 — UX 저하, 데이터 손실은 아님 |
| 삭제 범위 오류 | 프로필 삭제 시 `sessions/`나 `ideas/evaluated/`까지 같이 지워짐 | **치명** — 평가 이력 소실 |
| 확인 후 미반영 | "네" 확인까지 받았는데 실제 파일 변경이 반영 안 됨(이전 라운드에 유사 사례로 `.claude/` 쓰기 차단 있었음 — 지금은 Documents라 재발 가능성 낮지만 미확정) | 낮음 — 재시도로 해결 가능하나 사용자 혼란 |

이 표의 항목들은 코드 정적 분석으로는 증명 불가 — M1 실측으로만 확정된다.

---

## M2: Phase 1 게이트 정식 기록 (M1 완료 후에만 착수)

- [x] `tests/results-template.md`를 `tests/results/2026-08-02_run-001.md`로 복사
- [x] 시나리오 1~6 결과를 기록(6/6 PASS, 사용자 총평 확인 기준 — 위 M1 섹션 참조)
- [x] "통합 판정" PASS 기입

**검증**: `powershell -File tests\frontmatter-linter.ps1` 실행 결과 PASS + 기록 파일에 시나리오 6개 체크박스 전부 체크된 상태
**done-when**: `tests/results/` 폴더 안에 실제 기록 파일 존재, 6/6 PASS 명시
**상태**: done (2026-08-02, `tests/results/2026-08-02_run-001.md`)

---

## M3: Phase 2 착수

PRD(`03_PHASES.md`)의 명시적 전제 조건: "Phase 1이 안정적으로 동작(평가 5건 이상 누적, profile.md 1차 완성)" +
시나리오 6건 전부 PASS. M1·M2 완료(2026-08-02) → 착수.

- [x] `phase2-draft/` 4개 파일을 실제 위치로 이동 (`commands/recommend.md`·`commands/decide.md`·`skills/pre-mortem/SKILL.md`·`agents/bc-idea-generator.md`)
- [x] `plugin.json`의 `agents` 배열에 `"./agents/bc-idea-generator.md"` 추가
- [ ] `tests/manual-scenarios.md`의 "Phase 2 진입 전 회귀 매트릭스" 실행 — **미실행**. `/business-counselor:recommend`·`/business-counselor:decide` 등은 실제 자연어 대화로만 검증 가능해 AI 대행 불가(M1과 동일 사유). 정적 검증(JSON 유효성·frontmatter 린터·시크릿 스캔·격리 해제 확인)은 통과
- [x] 버전 bump(v0.6.0) + CHANGELOG 갱신

**상태**: 파일 활성화 완료(2026-08-02), **실사용 검증은 아직 미실행** — 사용자가 새 세션에서 `/business-counselor:recommend`·`/business-counselor:decide`를 실제로 실행해봐야 최종 완료로 볼 수 있음

---

## M4: Phase 3 준비 (파일 작성 완료, 활성화는 보류)

### 상태: 파일 작성 done (2026-08-02) / 활성화 blocked

`phase3-draft/` 4개 파일(`research`·`followup`·`stats` 명령 + `bc-market-researcher` 에이전트) 작성 완료.
`plugin.json` 미참조 확인(격리 유지). **Phase 2와 달리 곧바로 활성화하지 않음** — 아래 근거:

- `ideas/generated/` 0건, `decisions.jsonl` 없음(2026-08-02 실측) — Phase 2가 아직 한 번도 실사용되지 않음
- Phase 2 자체가 방금 병합되어 사용자 설치본에 아직 반영 전(재설치·재시작 필요) — 물리적으로 사용 불가능한 시점
- PRD 자체의 Phase 3 착수 조건("Phase 1+2 10건 이상 누적", "시나리오 10건 PASS") 미충족
- Phase 3는 이 플러그인 최초로 외부 API(`WebSearch`)를 여는 단계라 PII·비용 리스크가 Phase 1·2와 다른 등급

### 활성화 조건 (`phase3-draft/README.md` 참조)

1. Phase 2 실사용 증거 확인 (`ideas/generated/`·`decisions.jsonl`에 실제 기록 발생)
2. PRD 착수 조건(10건 누적, 시나리오 10건 PASS) 충족
3. `bc-market-researcher.md`의 "활성화 전 필수 검증" 체크리스트 사람이 직접 확인
4. 파일 이동 + `plugin.json` 등록 + 회귀 매트릭스 실행

### 이번 라운드에 함께 확정한 PRD 미결 항목

- `PRD/03_PHASES.md`: 월 외부 호출 한도 **100회 확정**(하드 차단)
- `PRD/02_DATA_MODEL.md`: `research/*.md` TTL 만료 시 **자동 삭제 확정**(archived/ 이동 없음)

---

## 참고 — 알려진 저심각도 이슈 (M1~M3와 무관, 별도 처리 대기)

이 항목들은 기능을 막지 않는 낮은 심각도로 이미 확인됐고, 새 증거 없이는 우선순위를 올리지 않는다:

- `bc-idea-evaluator`가 자체 생성하는 frontmatter `timestamp` 필드가 실제 파일 생성 시각과 다르게 기록됨
  (2건 재현: eval-001 15:00 vs 실제 ~07:10, eval-002 09:30 vs 실제 ~08:43). `list` 명령이 실제 파일 시각으로
  정렬해 우회 중이라 기능 영향은 없음.
- `evaluate`의 모드 감지("전체"/"detail" 등 키워드)가 아이디어 문장 안에 우연히 같은 단어가 들어가면 오탐할
  이론적 가능성 — 실사용에서 아직 확인된 적 없음.
- `show`/`list`의 ID 매칭 방식이 경로 안전성을 명시적으로 검증하지 않음 — 외부 노출 없는 개인용 로컬 도구라
  실질 위험은 낮다고 판단.

---

## 재개 방법 (다음 세션·다른 사람이 이어받을 때)

1. 이 파일의 "현재 상태 요약"과 M1~M3 상태만 보면 됨 — 다른 문서 재독 불필요
2. M1·M2는 done(2026-08-02, 사용자 자체 검증). M3는 파일 활성화까지 done, **실사용 검증만 남음**
3. 사용자가 "다음 phase로 넘어가자"라고 말하면 항상 본인이 이미 테스트 완료했다는 뜻으로 간주하고 게이트로 막지 않는다
   (`~/.claude/projects/*/memory/feedback_phase-transition-implies-user-tested.md` 참조)
4. 다음 실질 남은 일: `/business-counselor:recommend`·`/business-counselor:decide`를 사용자가 새 세션에서 직접 실행 → 결과 알려주면 이 문서의 M3 "미실행" 항목 갱신
5. Phase 3(`phase3-draft/`)는 파일까지만 작성됨 — M4 활성화 조건 충족 전까지는 "다음 phase로 넘어가자"가 와도 파일 이동·plugin.json 등록은 보류(외부 API 첫 도입이라 Phase 2보다 검증 기준이 높음)
