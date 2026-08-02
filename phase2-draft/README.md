# Phase 2 초안 (DRAFT — 비활성)

> 이 폴더는 `plugin.json`이 전혀 참조하지 않습니다. 안에 있는 파일은 **실제로 호출되지 않습니다.**
> `commands/`·`skills/`는 폴더 전체가 자동 등록되고 `agents/`는 화이트리스트 방식이지만,
> 이 폴더는 그 어느 경로에도 걸리지 않아 안전합니다 (2026-08-02 검증: `git diff plugin.json` 변경 0건).

## 포함된 파일

| 파일 | 활성화 시 목적지 | PRD 근거 |
|---|---|---|
| `commands/recommend.md` | `commands/recommend.md` | `PRD/03_PHASES.md` Phase 2 §기능 |
| `commands/decide.md` | `commands/decide.md` | 〃 |
| `skills/pre-mortem/SKILL.md` | `skills/pre-mortem/SKILL.md` | 〃 |
| `agents/bc-idea-generator.md` | `agents/bc-idea-generator.md` | 〃 |

## 활성화 조건 (반드시 순서대로)

1. `CHECKPOINT.md` M1(edit·resume 실사용 검증) `done`
2. `CHECKPOINT.md` M2(Phase 1 게이트 정식 기록, 6/6 PASS) `done`
3. 위 4개 파일을 각자의 목적지 경로로 이동
4. `plugin.json`의 `agents` 배열에 `"./agents/bc-idea-generator.md"` 추가 (`commands`·`skills`는 폴더 자동 등록이라 이동만으로 충분)
5. `tests/manual-scenarios.md`의 "Phase 2 진입 전 회귀 매트릭스" 실행

## 왜 코드가 아니라 "준비"로 그쳤는가

`CHECKPOINT.md` M3가 "M1·M2 완료 전까지 Phase 2 착수 금지"를 명시하고 있고, M1이 아직 실행되지 않았습니다(사람이 새 세션에서 직접 대화해야 하는 검증이라 AI가 대행 불가). 파일 내용 자체는 완전하게 작성했지만, 검증 안 된 Phase 1 위에 Phase 2가 실제로 얹히는 일(=활성화)은 벌어지지 않도록 이 폴더로 격리했습니다.
