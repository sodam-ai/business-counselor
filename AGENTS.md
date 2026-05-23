# business-counselor — AGENTS.md

> **Codex/OpenAI 진입점.** 이 파일은 플러그인 폴더 안에만 존재합니다.
> 사용자 홈 루트·프로젝트 루트에 AGENTS.md 생성 금지 (의도치 않은 글로벌 인식 차단).
> Claude Code 사용자는 plugin.json을 통해 자동 인식.

---

## 한 줄 요약

**AI 사업 카운슬러** — 사용자 본인의 과거·자산·역량 맥락을 누적하여
아이디어를 5단계로 냉철하게 판독하는 Claude Code / Codex 플러그인.
현재: Phase 1 (5단계 MVP). 외부 API 호출 0.

---

## 명령 (Commands)

| 명령 | 설명 |
|------|------|
| `/counsel:start` | 자기 인터뷰 시작 — Mom Test 스타일 6카테고리 |
| `/counsel:resume` | 인터뷰 이어서 — 부족 영역 우선 질문 |
| `/counsel:evaluate "<idea>"` | 아이디어 5단계 냉철 판독 (단일 호출) |
| `/counsel:list` | 과거 평가 목록 |
| `/counsel:show <id>` | 특정 평가 재조회 |

---

## 에이전트 (Agents)

| 에이전트 | 설명 |
|----------|------|
| `bc-idea-evaluator` | 5단계 단일 호출 판독. Bull/Bear/Judge 분리 호출 금지. |

---

## 스킬 (Skills)

| 스킬 | 설명 |
|------|------|
| `13-personas` | 페르소나 v5 13명 다관점 1~5점 평가 |
| `lean-canvas` | 9블록 Lean Canvas |
| `mom-test` | Mom Test 과거 행동 기반 질문 생성 |
| `adversarial-debate` | Bull/Bear/Judge 단일 호출 토론 |
| `goal-driven` | Karpathy success_criteria 작성법 |

---

## 가드레일 (필수)

- 모든 명령: `/counsel:` 네임스페이스 강제
- 모든 에이전트: `bc-` prefix 강제
- AGENTS.md: 이 플러그인 폴더 안에만 (글로벌 X)
- 기존 hook·`~/.claude/CLAUDE.md`·`MEMORY.md`·`user_persona*.md` **절대 수정 X**
- 외부 API 호출 **0** (Phase 1·2 정책)
- 단일 호출 정책: `/counsel:evaluate` = `bc-idea-evaluator` 1회만
- 출력 파일 frontmatter: `disclaimer` + `success_criteria` + `consistency_score` + `model_id` + `temperature` + `debate_mode` 자동 삽입

---

## 데이터 경로

```
~/.claude/plugins/business-counselor/data/
├── profile.md
├── sessions/
├── ideas/evaluated/
└── (Phase 2+) ideas/generated/ · decisions.jsonl
```

---

## 법적 경계

본 플러그인은 자본시장법 제6조 제5항(투자자문업) 및 제17조(인가요건) 적용을 받지 않는
사업·창업 아이디어 의견 생성 도구입니다. 특정 종목·금융상품 추천이 아니며,
모든 결정 책임은 사용자 본인에게 있습니다.
