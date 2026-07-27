# business-counselor — 데이터 모델

> 이 문서는 플러그인이 다루는 핵심 데이터 구조를 정의합니다.
> 비개발자도 이해할 수 있는 "개념적 ERD"입니다.
> **물리적으로는 모두 마크다운 + JSONL 파일** (DB 없음).
> **버전: v1.2 (2026-05-07 self-review #2 반영 — 페르소나 v5 13명 다관점 매칭 + 면책 한국어 본문)**
> 변경 이력: ../CHANGELOG.md

---

## 저장 위치

```
~/Documents/business-counselor/
├── profile.md                    # 사용자 프로필 (1개, 누적 갱신)
├── sessions/
│   └── 2026-05-07_001.md         # 인터뷰 1회당 1파일
├── ideas/
│   ├── generated/
│   │   └── 2026-05-07_idea-001.md  # AI 추천 아이디어
│   └── evaluated/
│       └── 2026-05-07_eval-001.md  # 사용자 가져온 아이디어 판독
├── research/
│   └── 2026-05-07_market-001.md   # deep-research 캐시
└── decisions.jsonl                # 결정 로그 (1줄 = 1결정)
```

---

## 전체 구조 (개념적 ERD)

```
[Profile (1)] ───┬─→ [GeneratedIdea (N)]
                 ├─→ [EvaluatedIdea (N)]
                 └─→ [InterviewSession (N)] (프로필 누적 반영)

[GeneratedIdea] ─┬─→ [MarketResearch (선택, 0..1)]
[EvaluatedIdea] ─┘

[GeneratedIdea] ─┬─→ [DecisionLog (0..N)]
[EvaluatedIdea] ─┘
```

---

## 엔티티 상세

### 1. Profile (`profile.md`)
사용자 본인의 누적 프로필. 인터뷰가 진행될수록 풍부해진다. 단일 파일.

| 필드 | 설명 | 예시 | 필수 |
|------|------|------|------|
| id | 고정값 `profile-main` | profile-main | O |
| schema_version | 스키마 버전 | 1.2 | O |
| last_updated | 마지막 갱신 ISO 시각 | 2026-05-07T14:32:00 | O |
| birth_year | 출생연도 | 1990 | O |
| residence | 거주지 (시·도 단위) | 서울 | O |
| family_status | 가족 상태 | 미혼/기혼·자녀N | O |
| capital_krw | 운용 가능 자본 (만원 단위) | 5000 | O |
| monthly_income_krw | 월 수입 | 350 | O |
| time_available_hr | 주당 활용 가능 시간 | 20 | O |
| skills | 보유 역량 (배열) | ["바이브코딩", "AI 도구 운영"] | O |
| domain_interests | 관심 도메인 | ["AI 이미지/영상", "온톨로지", "바이브코딩"] | O |
| risk_appetite | 리스크 성향 | conservative/balanced/aggressive | O |
| past_business | 과거 사업 이력 | "없음" 또는 자유서술 | X |
| profile_updates | 누적 갱신된 필드명 목록 (resume "(추가)"·edit "(수정)"·"(비움)" 이력 포함) | ["capital_krw", "skills", "risk_appetite(수정)"] | O |
| disclaimer | 면책 조항 | "본 프로필은 본인 작성. 외부 송신 0." | O |

**body**: Mom Test 인터뷰 답변 누적 (자유서술, 시간순) + `/business-counselor:edit`가 추가하는 "## 수정 이력" 섹션(v0.5.0)

**추가/수정/제거 (v0.5.0)**: `id`·`schema_version`·`last_updated`·`profile_updates`·`disclaimer` 5개는 시스템 관리
필드라 명령으로 직접 수정 대상이 아님. 나머지 사용자 응답 필드는 `/business-counselor:resume`(빈 값만 채움)과
`/business-counselor:edit`(이미 채워진 값 변경·비움, 프로필 전체 삭제)로 나뉘어 전부 커버된다.

---

### 2. InterviewSession (`sessions/YYYY-MM-DD_NNN.md`)
인터뷰 1회 = 1파일. Append-only.

| 필드 | 설명 | 예시 | 필수 |
|------|------|------|------|
| id | 세션 ID | session-2026-05-07-001 | O |
| timestamp | 시작 시각 | 2026-05-07T14:00:00 | O |
| topic | 인터뷰 주제 | "초기 프로필 인터뷰" / "역량 추가 질문" | O |
| questions_count | 질문 수 | 12 | O |
| answers_count | 답변 수 | 12 | O |
| profile_updates | 갱신된 필드 목록 | ["capital_krw", "skills"] | O |
| disclaimer | 면책 | (공통 frontmatter) | O |

**body**: Q/A 페어 (Mom Test 스타일, 과거 행동 기반 질문)

---

### 3. GeneratedIdea (`ideas/generated/YYYY-MM-DD_idea-NNN.md`)
AI가 사용자 프로필 기반 추천한 사업 아이디어. Phase 2부터.

| 필드 | 설명 | 예시 | 필수 |
|------|------|------|------|
| id | 아이디어 ID | idea-2026-05-07-001 | O |
| timestamp | 생성 시각 | 2026-05-07T15:00:00 | O |
| title | 아이디어 한 줄 | "한국 부동산 AI 매물 추적기" | O |
| profile_snapshot_hash | 생성 시점 프로필 해시 | sha256:abc... | O |
| fit_score | 사용자 적합도 (0~100) | 78 | O |
| persona_13_score | 13명 다관점 평균 (1~5, 페르소나 v5 1:1 매칭) | 3.7 | O |
| lean_canvas | 9블록 | (구조화 객체) | O |
| disclaimer | 면책 | (공통) | O |

**body**: Lean Canvas 1쪽(Problem·Customer Segments·UVP·Solution·Channels·Revenue Streams·Cost Structure·Key Metrics·Unfair Advantage)

---

### 4. EvaluatedIdea (`ideas/evaluated/YYYY-MM-DD_eval-NNN.md`)
사용자가 직접 가져온 아이디어를 판독한 결과. Phase 1부터.

| 필드 | 설명 | 예시 | 필수 |
|------|------|------|------|
| id | 평가 ID | eval-2026-05-07-001 | O |
| timestamp | 평가 시각 | 2026-05-07T16:00:00 | O |
| raw_idea | 원문 입력 | "AI로 한국 부동산 매물 자동 분석" | O |
| profile_snapshot_hash | 시점 프로필 해시 | sha256:def... | O |
| persona_13_scores | 13명 다관점 점수 (1~5, 페르소나 v5 1:1 매칭) | {시니어개발자:4, 시니어보안:3, 비개발자:5, QA:3, DevOps:4, AI엔지니어:4, 디자이너:3, UX:4, PM:4, 경영진:3, 변호사:2, 비용최적화:3, 전문투자자:2} | O |
| lean_canvas | 9블록 | (구조화) | O |
| mom_test_questions | 검증 질문 5개 | ["지난주 ...", "이전에 ..."] | O |
| pre_mortem_failures | 망할 시나리오 (Phase 1=3개 OK, Phase 2부터 5개) | [{cause, prob, mitigation}] | △ |
| **bull_arguments** | **Bull(긍정) 측 논거 배열 (단일 호출 내부 토론)** | ["TAM 5조원 추정 ...", "사용자 자본 X·역량 Y로 진입 가능"] | **O (v1.1+)** |
| **bear_arguments** | **Bear(부정) 측 논거 배열 (단일 호출 내부 토론)** | ["경쟁 포화", "자본시장법 회색지대 위험"] | **O (v1.1+)** |
| **judge_verdict** | **Judge 중재 — Bull/Bear 양측 평가 후 최종 판정 사유** | {weighted_for: ..., weighted_against: ..., final: "iterate"} | **O (v1.1+)** |
| **debate_mode** | **토론 모드 (분리 호출 금지)** | "single-call" | **O (v1.1+)** |
| **success_criteria** | **Karpathy Goal-Driven — 이 verdict가 맞으려면 측정값** | {metric: "고객 인터뷰 수", threshold: ">=10", deadline: "2026-06-07"} | **O (v1.1+)** |
| **consistency_score** | **N=3회 평가 분포 표준편차 (Phase 1=placeholder, Phase 2부터 측정)** | 0.12 (낮을수록 일관적) | **O (v1.1+)** |
| **model_id** | **재현성용 모델 식별자** | "claude-sonnet-4-6" | **O (v1.1+)** |
| **temperature** | **재현성용 샘플링 온도** | 0.2 | **O (v1.1+)** |
| verdict | go / iterate / no-go | iterate | O |
| confidence | 0~100 | 65 | O |
| risks | 위험 목록 | ["자본시장법 회색지대", "경쟁 포화"] | O |
| disclaimer | 면책 | (공통) | O |

**body**: 5단계 상세 분석 (§1 13관점 → §2 Lean Canvas → §3 Mom Test → §4 Pre-mortem → §5 적대 토론 Bull/Bear/Judge) + 출처(Phase 3에서 research/*.md 링크)

---

### 5. MarketResearch (`research/YYYY-MM-DD_market-NNN.md`) — Phase 3
deep-research 호출 결과 캐시. TTL 7일.

| 필드 | 설명 | 예시 | 필수 |
|------|------|------|------|
| id | 리서치 ID | market-2026-05-07-001 | O |
| timestamp | 수집 시각 | 2026-05-07T17:00:00 | O |
| query | 검색 키워드 | "한국 부동산 AI 시장 2026" | O |
| ttl_until | 만료 시각 | 2026-05-14T17:00:00 | O |
| sources | URL+제목 배열 | [{url, title, accessed_at}] | O |
| tldr | 1단락 요약 | "..." | O |
| disclaimer | 면책 | (공통) | O |

**body**: deep-research 원문(요약) + 시장규모·경쟁사·트렌드 섹션

---

### 6. DecisionLog (`decisions.jsonl`)
Append-only JSON Lines. 1줄 = 1 결정.

```json
{"timestamp":"2026-05-07T18:00:00","idea_id":"eval-2026-05-07-001","action":"iterate","note":"고객 인터뷰 5명 후 재평가","next_review":"2026-05-21"}
```

| 필드 | 설명 | 필수 |
|------|------|------|
| timestamp | ISO 시각 | O |
| idea_id | EvaluatedIdea 또는 GeneratedIdea ID | O |
| action | go / drop / iterate / defer | O |
| note | 한 줄 메모 | O |
| next_review | 다음 검토 예정일 (ISO date) | X |

---

## 모든 파일 공통 frontmatter (v1.2)

```yaml
---
id: <엔티티 ID>
schema_version: 1.2
timestamp: 2026-05-07T14:32:00
model_id: claude-sonnet-4-6       # v1.1+ 재현성용
temperature: 0.2                  # v1.1+ 재현성용
debate_mode: single-call          # v1.1+ Bull/Bear/Judge 분리 호출 금지
disclaimer: |
  본 도구는 자본시장법 제6조 제5항(투자자문업) 및 제17조(인가요건) 적용을 받지 않는
  사업·창업 아이디어 의견 생성 도구이며, 특정 종목·금융상품·재무상품 추천이 아닙니다.
  본 도구의 모든 출력은 참고용 의견이며, 투자자문업·투자일임업·창업컨설팅업·세무자문·
  법률자문이 아닙니다. 모든 결정 및 실행의 책임은 사용자 본인에게 있으며, 변호사·세무사·
  재무자문가의 자문이 필요한 사안은 해당 전문가 상담을 권고합니다. 본 도구를 통한
  의사결정으로 발생하는 손익 및 법적 책임 일체에 대해 도구 제작자는 책임지지 않습니다.
  본 도구를 사용함으로써 위 면책 조항에 동의한 것으로 간주됩니다.
---
```

> **v1.1 추가 필드 (EvaluatedIdea·GeneratedIdea 한정)**: `bull_arguments`·`bear_arguments`·`judge_verdict`·`success_criteria`·`consistency_score`
> **v1.2 면책 한국어 본문 1차 초안**: 자본시장법 제6조 제5항·제17조 명시. 본인용 사용 목적이라 충분. 향후 공개 시 변호사 검토 권고.

---

## 관계 (상세)

- **Profile 1 ↔ N InterviewSession**: 인터뷰가 진행될 때마다 Profile 필드 갱신. 세션은 history.
- **Profile → GeneratedIdea**: 추천 시점 Profile 해시를 GeneratedIdea에 기록 (재현성)
- **Profile → EvaluatedIdea**: 평가 시점 Profile 해시 기록 (시간 따른 변화 추적 가능)
- **GeneratedIdea / EvaluatedIdea → MarketResearch (0..1)**: Phase 3에서 선택적으로 외부 증거 첨부
- **GeneratedIdea / EvaluatedIdea → DecisionLog (0..N)**: 한 아이디어 여러 번 결정 가능 (iterate→go→drop 진화)

---

## 왜 이 구조인가

### 확장성
- **파일 분리**: 인터뷰·아이디어·판독 각각 별도 파일 → 한 아이디어 늘어도 다른 파일 영향 0
- **append-only decisions.jsonl**: 1줄 추가 방식으로 동시 쓰기 안전, 통계 분석 용이
- **profile_snapshot_hash**: 시점별 프로필 차이 추적 → "3개월 전 자본 적었을 때 평가 vs 지금"

### 단순성
- **DB 없음**: Sqlite·Postgres 도입 시 마이그레이션·스키마 관리 부담. 마크다운+grep 충분
- **frontmatter 표준**: YAML frontmatter는 GitHub·Obsidian·Notion·Cursor 모두 인식
- **사람이 직접 읽고 수정 가능**: AI가 잘못 쓴 경우 사용자가 vim/메모장으로 수정
- **저장 위치가 `~/Documents/business-counselor/`인 이유 (2026-07-27 변경)**: 원래는 `~/.claude/plugins/business-counselor/data/`였으나, 실 E2E에서 `~/.claude/` 전체를 "시스템 설정"으로 보고 AI 직접 쓰기를 막는 보호 장치가 발견됨(하위 경로를 바꿔도 소용없음, 직접 재현 확인). 위 "사람이 직접 읽고 수정 가능"이라는 목적 자체를 지키려면 `.claude/` 밖의 평범한 사용자 폴더로 옮기는 것이 유일한 방법이었음 — 목적 변경이 아니라 목적을 지키기 위한 이전.

### 보안 (페르소나 #11 변호사 + 데이터 안전)
- **로컬 only**: profile.md(자산·이력) 외부 송신 0
- **disclaimer 강제**: frontmatter 없이 새 파일 생성 금지(린터로 검증)
- **민감 영역 마스킹**: Phase 3 외부 호출 시 자본·이름 등 PII 키워드 자동 제거 후 검색 키워드만 전송. **사용자 명시 호출 시만 활성** (v1.1).

### 재현성·검증 가능성 (v1.1 Karpathy Goal-Driven)
- **model_id·temperature**: 같은 아이디어 두 번 평가 시 환경 차이 추적 가능. 향후 모델 변경 시 영향 분석.
- **debate_mode: single-call**: Bull/Bear/Judge 별도 서브에이전트 분리 호출 금지 → **API 비용 1/3** + Judge가 양측 증거를 한 응답에서 동시 평가.
- **success_criteria**: verdict가 옳다고 판단하려면 어떤 측정값이 어느 임계값 이상이어야 하는가를 명시 → 사용자가 N개월 후 자기 결정의 정확성 검증 가능 (Karpathy "loop until verified").
- **consistency_score**: Phase 2부터 N=3회 자동 재평가 → 표준편차로 평가 안정성 측정. 임계값 초과 시 "불안정" 표시.

---

## [NEEDS CLARIFICATION]

- [ ] `profile_snapshot_hash` 알고리즘: SHA-256 전체? 또는 핵심 필드만?
- [ ] `decisions.jsonl` 회전(rotation) 정책: 무한 누적? N개 후 archive/?
- [ ] `research/*.md` TTL 만료 시 자동 삭제? 또는 archived/ 이동?
- [ ] 다국어 필드 지원 여부: 모든 한국어로 진행? 영문 키워드 일부 허용?
- [ ] 인터뷰 카테고리 6종(생애사·자본·시간·역량·관심도메인·리스크성향) 외 가족·건강·도덕적 신념 추가 여부
- [ ] **v1.1 신규**: `bull_arguments`·`bear_arguments` 최소·최대 항목 수 (Bull 3개? Bear 5개?)
- [ ] **v1.1 신규**: `consistency_score` 임계값 (Phase 2 측정 시 0.20 초과 = 불안정 등)
- ✓ **v1.1 신규**: ~~`success_criteria.metric` 표준 카탈로그~~ → **v1.2 카탈로그 5개 완성** (04_PROJECT_SPEC.md §"항상 해" 참조. 2026-07-27 문서 간 불일치 발견·동기화)
