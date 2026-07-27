# AI 사업 카운슬러 (business-counselor)

> **Claude Code 플러그인** · v0.5.0 · Phase 1 MVP
> 사업 아이디어를 입력하면 AI가 13명 전문가 관점으로 **5단계 냉철 분석**을 즉시 제공합니다.

**코딩을 전혀 몰라도 됩니다.** Claude Code 채팅창에 명령어만 입력하면 됩니다.

> 🇰🇷 한국어 문서(기본) · 🇺🇸 [English README](./README_EN.md)

---

## ⚡ 빠른 시작 (3줄 요약)

이미 [Claude Code](https://claude.ai/download)가 설치돼 있다면, 터미널에서:

```bash
claude plugin marketplace add sodam-ai/business-counselor
claude plugin install business-counselor@business-counselor-marketplace
```

→ Claude Code 재시작 → 채팅창에 `/business-counselor:evaluate "내 아이디어 한 줄"` 입력. 끝.

처음이라 위 명령이 막막하면 아래 **[설치 방법](#-설치-방법)**과 **[사용 방법](#beginner-guide)**을 그대로 따라 하세요.

---

## 🤔 이게 뭔가요?

사업/창업 아이디어가 떠올랐을 때, **"이거 될까?"를 13명의 전문가가 냉정하게 따져주는 도구**입니다.

- 혼자 생각하면 "좋은 것 같은데?" 하고 자기 확신에 빠지기 쉽습니다.
- 이 도구는 개발자·보안·법무·투자자 등 **13명 전문가 시점 + 적대 토론(찬성 vs 반대 vs 판정)**으로 약점까지 들춰냅니다.
- 결과는 **go(추진) / iterate(보완) / no-go(비추천)** 한 줄 판정으로 정리됩니다.

별도 앱·웹사이트가 아니라, 이미 쓰는 **Claude Code 안에서 명령어로** 동작합니다. 모든 결과는 **내 컴퓨터에만** 저장됩니다(외부 전송 0).

---

## ✨ 주요 기능

아이디어 하나를 입력하면 **단 한 번의 호출**로 분석이 완료됩니다.

**맨 위 「한눈 요약」 카드** (항상 표시) — 판정·확신도·강점·막힌 곳·다음 행동을 한눈에:

```
## 한눈 요약
- 판정: ⛔ no-go  ·  확신도: 78/100
- 강점: ...
- 막힌 곳: ...
- 다음 행동: ...
```

그 아래 **5단계 상세 분석** (원할 때만, 아래 [기본/전체 모드](#기본카드--전체-상세-모드) 참고):

| 단계 | 이름 | 설명 |
|------|------|------|
| § 1 | **13명 다관점 평가** | 개발·보안·법무·투자자 등 13명이 각각 1~5점 평가 + ⚠️ 위험 경고 |
| §1 부록 | **🗣 타겟 고객의 한마디** | 실제 '돈 낼 고객' 1인칭 예상 반응(살까·거부이유·대안) |
| § 2 | **Lean Canvas** | 사업 모델 9칸(문제·고객·수익 등) 자동 구성 |
| § 3 | **Mom Test 검증 질문** | 실제 고객 인터뷰에 쓸 과거행동 기반 질문 5개 |
| § 4 | **Pre-mortem** | "1년 뒤 망했다면 왜?" 실패 원인 3개 + 확률 + 완화책 |
| § 5 | **적대 토론** | Bull(찬성)·Bear(반대)·Judge(판정) → go / iterate / no-go |

모든 결과는 `~/Documents/business-counselor/`에 자동 저장됩니다.

---

## 📦 사전 준비물 / 필요 프로그램

| 준비물 | 용도 | 다운로드 |
|--------|------|----------|
| **Claude Code** | 이 플러그인이 동작하는 프로그램 (필수) | [claude.ai/download](https://claude.ai/download) |
| **Git** | 설치 방법 A에 필요 (방법 B는 불필요) | [git-scm.com/downloads](https://git-scm.com/downloads) |

- 운영체제: Windows / macOS 모두 가능
- 인터넷: 설치할 때만 필요 (사용 중에는 외부 전송 0)
- 별도 회원가입·API 키·결제 **불필요** (Claude Code 자체 로그인만 사용)

---

## 🔧 설치 방법

### 방법 A — GitHub에서 바로 설치 (권장, git clone 불필요)

터미널에 한 줄씩 붙여넣고 Enter:

```bash
# 1. 마켓플레이스 등록 (GitHub 저장소를 직접 참조 — 클론 불필요)
claude plugin marketplace add sodam-ai/business-counselor

# 2. 플러그인 설치
claude plugin install business-counselor@business-counselor-marketplace

# 3. 설치 확인
claude plugin list
```

→ 목록에 `business-counselor@business-counselor-marketplace  √ enabled` 가 보이면 성공.

### 방법 B — Git으로 클론해서 설치 (코드를 직접 수정하며 쓸 때)

> **주의:** `git clone` 후 그 폴더 *안으로 들어가지 말고*, 폴더가 보이는 같은 위치에서 다음 명령을 실행하세요.

```bash
# 1. 저장소 다운로드
git clone https://github.com/sodam-ai/business-counselor.git

# 2. 로컬 경로로 마켓플레이스 등록 (business-counselor 폴더가 보이는 위치에서)
claude plugin marketplace add ./business-counselor

# 3. 플러그인 설치
claude plugin install business-counselor@business-counselor-marketplace

# 4. 설치 확인
claude plugin list
```

### 방법 C — ZIP으로 설치 (Git 없을 때)

1. [GitHub 페이지](https://github.com/sodam-ai/business-counselor) → 초록색 **Code** → **Download ZIP**
2. 다운로드된 ZIP 압축 해제
3. 폴더 이름을 **`business-counselor`** 로 변경 (`-main` 이 붙어있으면 제거)
4. 그 폴더가 보이는 위치에서 터미널을 열고:

```bash
claude plugin marketplace add ./business-counselor
claude plugin install business-counselor@business-counselor-marketplace
claude plugin list
```

**설치 후 Claude Code를 재시작**하면 `/business-counselor:*` 명령을 쓸 수 있습니다.

---

<a id="beginner-guide"></a>
## 🚀 사용 방법 (빠른 첫 사용)

### 1단계 — (선택) 나에 대한 인터뷰

```
/business-counselor:start
```

자본·시간·역량·관심 분야 등 약 12개 질문에 자연어로 답하면 됩니다(한 번에 1~2개씩, 약 30~40분). 이 정보로 이후 분석이 **내 상황에 맞춰** 더 정확해집니다. (건너뛰고 바로 평가해도 됩니다 — 일반 기준으로 평가됩니다.)

### 2단계 — 아이디어 분석

```
/business-counselor:evaluate "AI로 부동산 매물 분석해주는 서비스"
```

아이디어를 큰따옴표 안에 입력. 모호하면 AI가 보강 질문 1~2개를 먼저 합니다. 결과는 맨 위 **「한눈 요약」 카드**로 나옵니다.

<a id="mode-guide"></a>
### 기본(카드) / 전체(상세) 모드

- **기본**: `/business-counselor:evaluate "아이디어"` → **「한눈 요약」 카드만** (빠르고 짧음).
- **전체**: `/business-counselor:evaluate "아이디어" 전체` → **§1~§5 상세 분석 전부** 생성·저장. (아래 [기본/전체 모드](#mode-guide) 참고)
- 이미 저장된 전체 분석 다시 보기: `/business-counselor:show <id>`

---

## 📋 명령어 전체

| 명령어 | 설명 |
|--------|------|
| `/business-counselor:help` | 사용법·명령·용어를 한 화면에 요약 |
| `/business-counselor:start` | 나에 대한 AI 인터뷰 시작 (처음 한 번) |
| `/business-counselor:resume` | 인터뷰 이어서 하기 (빠진 정보 보완) |
| `/business-counselor:edit "요청"` | 이미 답한 정보 수정·비우기, 프로필 전체 삭제 |
| `/business-counselor:evaluate "아이디어"` | 아이디어 분석 — 기본은 한눈 요약 카드 |
| `/business-counselor:evaluate "아이디어" 전체` | 아이디어 분석 — §1~§5 전체 상세 |
| `/business-counselor:list` | 지금까지 분석한 목록 (id·판정·확신도) |
| `/business-counselor:show <id>` | 특정 분석 전체 다시 보기 |

> 막히면 언제든 `/business-counselor:help` 를 먼저 입력하세요.

---

## ⚙️ 작동 방법 / 워크플로우

```
[처음 1회]  /business-counselor:start  →  인터뷰 답변  →  내 프로필(profile.md) 저장
                                   │
[매번]  /business-counselor:evaluate "아이디어"
            │
            ├─ 모호하면 → AI가 보강 질문 1~2개 → 답변
            │
            ▼
        AI가 단 한 번의 호출로 내부에서:
        13명 평가 → 타겟 고객 한마디 → Lean Canvas → Mom Test → Pre-mortem → 적대 토론
            │
            ▼
        화면: 「한눈 요약」 카드 (판정·확신도·강점·막힌곳·다음행동)
        저장: 결과 파일(.md)  →  /business-counselor:list 로 목록, /business-counselor:show 로 다시 보기
```

- **단일 호출**: 한 명령 = 한 번의 분석(추가 호출 0). 빠르고 비용 절약.
- **냉철 모드**: 긍정 편향을 막고 약점·위험을 먼저 들춰냅니다. 법무·투자 위험은 ⚠️ 로 강조.

---

## 📁 파일 위치 / 문서 위치

**플러그인 폴더** (설치한 곳):
```
business-counselor/
├── plugin.json          ← 플러그인 설정
├── CLAUDE.md            ← AI 행동 규칙
├── AGENTS.md            ← AI 에이전트 진입점
├── CHANGELOG.md         ← 변경 이력
├── commands/            ← 명령어 6개 (start·resume·evaluate·list·show·help)
├── skills/              ← 분석 스킬 (13-personas·lean-canvas·mom-test·adversarial-debate·goal-driven)
├── agents/              ← bc-idea-evaluator (핵심 분석 엔진)
├── templates/           ← 출력 양식
├── tests/               ← 린터·시나리오
└── PRD/                 ← 기획 문서 (01_PRD·02_DATA_MODEL·03_PHASES·04_PROJECT_SPEC)
```

**내 데이터 위치** (설치 후 자동 생성, 내 컴퓨터에만):
```
~/Documents/business-counselor/
├── profile.md           ← 내 정보 (인터뷰 결과)
├── sessions/            ← 인터뷰 기록
└── ideas/evaluated/     ← 아이디어 분석 결과
```
> `~` 는 사용자 홈 폴더입니다. Windows는 보통 `C:\Users\(내 이름)\Documents\business-counselor\` 입니다.

---

## 🆘 문제·오류 대처 방법

| 증상 | 원인 | 해결 |
|------|------|------|
| `/business-counselor:*` 명령이 안 보임 | 설치 후 미재시작 | **Claude Code를 껐다 다시 실행** |
| `plugin list`에 enabled 안 뜸 | 등록/설치 누락 | `marketplace add sodam-ai/business-counselor` → `install ...@business-counselor-marketplace` 다시 실행 |
| `claude: command not found` | Claude Code 미설치/경로 | [claude.ai/download](https://claude.ai/download)에서 설치 후 재시작 |
| `git: command not found` | Git 미설치 | [git-scm.com](https://git-scm.com/downloads) 설치 또는 ZIP 방법(B) 사용 |
| 평가가 5~8분 걸림 | 깊은 분석은 원래 오래 걸림 | 정상입니다. 빠르게 원하면 **기본(카드) 모드** 사용 |
| 결과가 카드만 짧게 나옴 | 기본이 카드 모드 | 전체는 `/business-counselor:evaluate "..." 전체` 또는 `/business-counselor:show <id>` |
| 다른 플러그인의 `uv: command not found` 등 오류 | **이 플러그인과 무관** | 무시해도 됩니다 (다른 도구의 알림) |
| 프로필 없이 평가됨 | 인터뷰 미진행 | 일반 기준으로 평가됩니다. 맞춤 원하면 `/business-counselor:start` 먼저 |

> 그래도 안 되면 `/business-counselor:help` 를 입력해 현재 사용법을 확인하세요.

---

## 🔒 운영 / 보안 주의사항

### 데이터 보안
- 내 정보(프로필)와 분석 결과는 **내 컴퓨터에만** 저장됩니다.
- 외부 서버로 전송되지 않습니다 (Phase 1·2 정책). 분석 엔진은 파일 읽기/쓰기 권한만 가집니다(외부 인터넷 호출 차단).
- 데이터 경로: `~/Documents/business-counselor/`

### 법적 면책
본 도구는 다음에 **해당하지 않습니다**: 투자자문업(자본시장법 제6조 제5항)·창업컨설팅업·세무자문·법률자문.
**모든 분석 결과는 참고용 의견입니다.** 중요한 결정 전에는 변호사·세무사·재무자문가 등 전문가 상담을 권고합니다.

### 알려진 제한사항 (Phase 1)
- 외부 시장 리서치(실시간 데이터) 미지원 → Phase 3 예정
- 아이디어 자동 생성(`/business-counselor:recommend`) 미지원 → Phase 2 예정
- 반복 평가 일관성 점수(`consistency_score`) 미측정 → Phase 2 예정

---

## 📄 라이선스

Apache License 2.0 · Copyright 2026 SoDam AI Studio

자세한 내용은 [LICENSE](./LICENSE) 파일을 참조하세요.

---

🇺🇸 [English README](./README_EN.md) · 변경 이력: [CHANGELOG.md](./CHANGELOG.md)
