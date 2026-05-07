# AI 사업 카운슬러 (business-counselor)

> **Claude Code 플러그인** · v0.1.0 · Phase 1 MVP  
> 사업 아이디어를 입력하면 AI가 13명 전문가 관점으로 5단계 냉철 분석을 즉시 제공합니다.

**코딩을 전혀 몰라도 됩니다.** Claude Code가 설치된 상태에서 채팅창에 명령어를 입력하기만 하면 됩니다.

---

## 주요 기능

아이디어 하나를 입력하면 **단 한 번의 호출**로 5단계 분석이 완료됩니다.

| 단계 | 이름 | 설명 |
|------|------|------|
| § 1 | **13명 다관점 평가** | 개발자·보안·법무·투자자 등 13명 전문가가 각각 1~5점으로 평가 |
| § 2 | **Lean Canvas** | 9블록 비즈니스 모델 자동 구성 (문제·고객·수익모델 등) |
| § 3 | **Mom Test 검증 질문** | 실제 고객 인터뷰에 쓸 수 있는 검증 질문 5개 생성 |
| § 4 | **Pre-mortem** | "실패했다고 가정"했을 때 가장 가능성 높은 실패 원인 3가지 |
| § 5 | **적대 토론** | Bull(긍정)·Bear(부정)·Judge(판정) 3자 토론 → go/iterate/no-go 최종 판정 |

모든 분석 결과는 `~/.claude/plugins/business-counselor/data/`에 자동 저장됩니다.

---

## 설치 방법

### 사전 요구사항

- [Claude Code](https://claude.ai/download) 설치 완료

### 설치 (3단계)

```bash
# 1. 이 저장소를 다운로드
git clone https://github.com/sodam-ai/business-counselor.git

# 2. 로컬 마켓플레이스 등록
claude plugin marketplace add ./business-counselor/.claude-plugin

# 3. 플러그인 설치
claude plugin install business-counselor@local-plugins
```

설치가 완료되면 Claude Code 채팅창에서 `/counsel:` 명령어를 바로 사용할 수 있습니다.

---

## 사용법

### 처음 사용할 때

```
/counsel:start
```

AI가 여러분에 대한 인터뷰를 시작합니다. 자본·시간·역량·관심 분야 등 약 12개 질문에 자연어로 답변하면 됩니다. 이 정보는 이후 아이디어 분석의 맞춤 맥락으로 활용됩니다.

### 아이디어 분석

```
/counsel:evaluate "AI로 부동산 중개 플랫폼 만들기"
```

아이디어를 큰따옴표 안에 입력하면 됩니다. 모호한 경우 AI가 보강 질문 1~2개를 먼저 합니다.

### 명령어 전체 목록

| 명령어 | 설명 |
|--------|------|
| `/counsel:start` | 나에 대한 AI 인터뷰 시작 (처음 한 번만) |
| `/counsel:evaluate "아이디어"` | 아이디어 5단계 냉철 분석 |
| `/counsel:list` | 지금까지 분석한 아이디어 목록 보기 |
| `/counsel:resume` | 인터뷰 이어서 하기 (정보 보완) |
| `/counsel:show <id>` | 특정 분석 결과 다시 보기 |

---

## 비개발자 가이드

> 코딩을 한 번도 해본 적 없는 분을 위한 안내입니다.

### "터미널"이 무엇인가요?

터미널은 컴퓨터에 명령을 텍스트로 입력하는 창입니다.

- **Windows**: 시작 버튼 → "PowerShell" 검색 → 실행
- **Mac**: Spotlight(⌘+Space) → "Terminal" 검색 → 실행

### Claude Code 설치

1. [claude.ai/download](https://claude.ai/download) 접속
2. 다운로드 후 설치 실행
3. 터미널에서 `claude` 입력 → 대화창이 열리면 설치 성공

### 이 플러그인 설치 (아래 3줄을 터미널에 순서대로 붙여넣기)

```bash
git clone https://github.com/sodam-ai/business-counselor.git
claude plugin marketplace add ./business-counselor/.claude-plugin
claude plugin install business-counselor@local-plugins
```

### 첫 사용

1. 터미널에서 `claude` 입력하여 대화창 열기
2. `/counsel:start` 입력 → Enter
3. AI의 질문에 자연어로 자유롭게 답변
4. 인터뷰 완료 후 `/counsel:evaluate "내 아이디어"` 입력

---

## 폴더 구조

```
business-counselor/
├── plugin.json                  ← 플러그인 설정 파일
├── CLAUDE.md                    ← AI 행동 규칙
├── AGENTS.md                    ← AI 에이전트 진입점
├── CHANGELOG.md                 ← 변경 이력
│
├── commands/                    ← 명령어 파일 (5개)
│   ├── counsel-start.md
│   ├── counsel-resume.md
│   ├── counsel-evaluate.md
│   ├── counsel-list.md
│   └── counsel-show.md
│
├── skills/                      ← AI 분석 스킬 (5개)
│   ├── 13-personas/SKILL.md
│   ├── lean-canvas/SKILL.md
│   ├── mom-test/SKILL.md
│   ├── adversarial-debate/SKILL.md
│   └── goal-driven/SKILL.md
│
├── agents/
│   └── bc-idea-evaluator.md     ← 핵심 분석 에이전트
│
├── templates/                   ← 출력 양식
├── tests/                       ← 린터 및 시나리오 테스트
└── PRD/                         ← 제품 기획 문서
```

**데이터 저장 위치** (설치 후 자동 생성):
```
~/.claude/plugins/business-counselor/data/
├── profile.md           ← 내 정보 (인터뷰 결과)
├── sessions/            ← 인터뷰 대화 기록
└── ideas/evaluated/     ← 아이디어 분석 결과
```

---

## 운영 시 주의사항

### 데이터 보안

- 내 정보(프로필)와 아이디어 분석 결과는 **내 컴퓨터에만** 저장됩니다
- 외부 서버로 전송되지 않습니다 (Phase 1·2 정책)
- 데이터 경로: `~/.claude/plugins/business-counselor/data/`

### 법적 면책

본 도구는 다음에 해당하지 않습니다.

- 투자자문업 (자본시장법 제6조 제5항)
- 창업컨설팅업 · 세무자문 · 법률자문

**모든 분석 결과는 참고용 의견입니다.** 중요한 결정 전에 전문가(변호사·세무사·재무자문가) 상담을 권고합니다.

### 알려진 제한사항 (Phase 1)

- 외부 리서치(실시간 시장 데이터) 미지원 → Phase 3에서 추가 예정
- 아이디어 자동 생성 미지원 → Phase 2에서 추가 예정
- 동일 아이디어 반복 평가 일관성 점수(`consistency_score`) 미구현 → Phase 2

---

## 라이선스

Apache License 2.0 · Copyright 2026 SoDam AI Studio

자세한 내용은 [LICENSE](./LICENSE) 파일을 참조하세요.

---

[English README](./README_EN.md)
