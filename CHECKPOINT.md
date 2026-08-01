# CHECKPOINT — business-counselor

> 마일스톤 + 검증 커맨드 + done-when. 세션이 바뀌어도 이 파일만 보면 "지금 뭘 해야 하는지" 알 수 있게 유지한다.
> 최종 갱신: 2026-08-02 · 저장소 main: v0.5.2 · **실제 설치·구동본: v0.5.1** (GitHub sodam-ai/business-counselor)

---

## 현재 상태 요약 (사실만, 추측 없음)

- 명령 7개 구현·설치·라이브 검증 완료: `start`·`resume`·`edit`·`evaluate`·`list`·`show`·`help`
- 데이터 위치: `~/Documents/business-counselor/` (구 `~/.claude/plugins/.../data/`에서 이전, 이유: `.claude/` 전체가 AI 직접 쓰기 차단 대상이라는 게 실측으로 확인됨)
- profile.md 실제 존재 확인, 평가 5건 누적 확인
  - 단, **본문 6개 카테고리는 전부 답변됐지만 frontmatter 4필드는 비어 있음**: `birth_year`·`residence`·`family_status`·`monthly_income_krw`
  - 이 중 앞 3개는 `resume.md`의 카테고리-필드 매핑에 아예 없어 `resume`으로는 채워지지 않음(채우려면 `edit`). 저심각도, 기능 차단 없음
- `tests/manual-scenarios.md` 시나리오 **6개 중 4개 실측 PASS**(1·3·4·5), **2개 미검증**(2·6)
- `tests/results/` 폴더 자체가 아직 없음 — 정식 기록 0건(전부 채팅 로그로만 존재)

### 실제 설치 경로 (2026-08-02 실측 — 기존 기재가 틀렸음)

- 구동본: `%APPDATA%\claude-code\plugins\marketplaces\business-counselor-marketplace` (GitHub 클론, `business-counselor@business-counselor-marketplace: true`)
- `~/.claude/plugins/business-counselor/`는 **설치본이 아님** — `plugin.json`이 없고 옛 `data/` 잔존물만 있음
- 저장소(v0.5.2) ↔ 설치본(v0.5.1) 차이는 `git diff 5475fea..main` 결과 **README 4종·CHANGELOG·CHECKPOINT·버전 표기뿐**. `commands/`·`agents/`·`skills/` 변경 0건
- → **저장소 수정은 push·플러그인 업데이트·Claude Code 완전 재시작을 거쳐야 실사용에 반영됨**

---

## M1: 시나리오 2·6 실사용 검증 (edit 명령 + resume 정상 경로)

### ⚠️ M1은 실사용 데이터를 파괴하는 테스트다 — 사전 준비 필수

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
**상태**: pending

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

- [ ] `tests/results-template.md`를 `tests/results/2026-MM-DD_run-NNN.md`로 복사
- [ ] 시나리오 1~6 결과를 실제로 기록(체크박스 채우기, 메모 작성)
- [ ] "통합 판정" PASS/FAIL 기입

**검증**: `powershell -File tests\frontmatter-linter.ps1` 실행 결과 PASS + 기록 파일에 시나리오 6개 체크박스 전부 체크된 상태
**done-when**: `tests/results/` 폴더 안에 실제 기록 파일 존재, 6/6 PASS 명시
**상태**: blocked (M1 미완료 — 검증 데이터 없이 기록만 먼저 하면 허위 기록이 됨)

---

## M3: Phase 2 착수 여부 재검토 (조건부, 지금은 범위 밖)

PRD(`03_PHASES.md`)의 명시적 전제 조건: "Phase 1이 안정적으로 동작(평가 5건 이상 누적, profile.md 1차 완성)" +
시나리오 5건(현재는 6건으로 확장) 전부 PASS. M2까지 완료되기 전까지 이 마일스톤은 시작하지 않는다.

**상태**: blocked (M2 완료 전까지 시작 금지 — 재확인·재제안도 하지 않음)

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

1. 이 파일의 "현재 상태 요약"과 M1~M3 상태(pending/blocked)만 보면 됨 — 다른 문서 재독 불필요
2. M1이 `pending`이면 → 위 7단계를 새 세션에서 그대로 실행
3. M1이 `done`으로 바뀌어 있으면 → M2로 이동
4. M2까지 `done`이면 → 그때 M3(Phase 2) 착수를 사용자에게 제안
