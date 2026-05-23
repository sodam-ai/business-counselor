# business-counselor — 플러그인 전용 세션 규칙

> 이 CLAUDE.md는 business-counselor 플러그인 폴더 내부 전용입니다.
> 사용자의 전역 `~/.claude/CLAUDE.md`와는 별개이며, 전역 파일을 절대 수정하지 않습니다.

---

## 절대 하지 마 (DO NOT)

- **기존 환경 절대 수정 X**: `~/.claude/CLAUDE.md`, `MEMORY.md`, `user_persona*.md`,
  SessionStart·UserPromptSubmit hook 파일 수정·삭제·간섭 금지
- **네임스페이스 오염 X**: `/counsel:` 외 네임스페이스로 명령 만들지 마
- **에이전트 prefix 오염 X**: `bc-` prefix 없는 서브에이전트 만들지 마
- **AGENTS.md 글로벌 생성 X**: 플러그인 폴더 외부에 AGENTS.md 생성 금지
- **외부 API X (Phase 1·2)**: 사용자 명시 `/counsel:research` 호출 없이 외부 송신 0
- **멀티 에이전트 분리 X**: `bc-bull-advocate`·`bc-bear-critic`·`bc-devil-judge` 별도 에이전트 만들지 마
- **추가 서브에이전트 호출 X**: `/counsel:evaluate` 실행 시 `bc-idea-evaluator` 1회만
- **자동 가정 X**: 모호 입력 시 보강 질문 1~2개 후 진행 (자동 가정 금지)
- **면책 없는 파일 생성 X**: 모든 출력 파일에 `disclaimer` frontmatter 자동 삽입 필수
- **PII 외부 송신 X**: 이름·주소·자본금·생년월일 등 외부 전송 금지 (Phase 1·2)
- **종목·금융상품 추천 X**: 자본시장법 회색지대 직접 답변 금지

---

## 항상 해 (ALWAYS DO)

- **단일 호출 정책**: 한 명령 = 한 응답. `bc-idea-evaluator` 내부에서 5단계 완결
- **frontmatter 6필드 자동 삽입**: 모든 새 파일에
  `disclaimer` + `success_criteria` + `consistency_score` + `model_id` + `temperature` + `debate_mode: single-call`
- **스키마 버전 명시**: `schema_version: "1.2"` (모든 출력 파일)
- **출력 토큰 < 6,000**: 긴 결과 방지 (13명 한 줄 코멘트, 각 섹션 압축)
- **Mom Test 준수**: 인터뷰 질문은 과거 행동 기반 100%, 가설 기반 0건
- **모호 입력 처리**: 보강 질문 최대 2개 후 명확화 후 진행
- **환경 무결성 확인**: 배포 전 시나리오 5(tests/manual-scenarios.md) PASS 필수

---

## 파일 경로 규칙

| 파일 종류 | 경로 | 파일명 규칙 |
|----------|------|-----------|
| 프로필 | `~/.claude/plugins/business-counselor/data/profile.md` | 단일 파일, 누적 갱신 |
| 세션 | `~/.claude/plugins/business-counselor/data/sessions/` | `YYYY-MM-DD_NNN.md` |
| 평가 | `~/.claude/plugins/business-counselor/data/ideas/evaluated/` | `YYYY-MM-DD_eval-NNN.md` |
| 생성(Phase 2) | `~/.claude/plugins/business-counselor/data/ideas/generated/` | `YYYY-MM-DD_idea-NNN.md` |
| 결정(Phase 2) | `~/.claude/plugins/business-counselor/data/decisions.jsonl` | JSONL, timestamp ISO 8601 |

---

## 법적 면책 (자동 삽입 표준 문구)

모든 출력 파일 frontmatter `disclaimer` 필드에 아래 문구를 그대로 삽입:

```
본 도구는 자본시장법 제6조 제5항(투자자문업) 및 제17조(인가요건) 적용을 받지 않는
사업·창업 아이디어 의견 생성 도구이며, 특정 종목·금융상품·재무상품 추천이 아닙니다.
본 도구의 모든 출력은 참고용 의견이며, 투자자문업·투자일임업·창업컨설팅업·세무자문·
법률자문이 아닙니다. 모든 결정 및 실행의 책임은 사용자 본인에게 있으며, 변호사·세무사·
재무자문가의 자문이 필요한 사안은 해당 전문가 상담을 권고합니다.
```
