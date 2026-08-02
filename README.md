# AI 사업 카운슬러 (business-counselor)

> **Claude Code 플러그인** · v0.5.2 · Phase 1 MVP · Apache-2.0(오픈소스, 상업적 이용 가능)
> 사업 아이디어를 입력하면 AI가 13명 전문가 관점으로 **5단계 냉철 분석**을 즉시 제공합니다.

**코딩을 전혀 몰라도 됩니다.** 컴퓨터·스마트폰을 다루는 게 아직 어색한 분도 그대로 따라 하면 됩니다. Claude Code 채팅창에 명령어만 입력하면 끝입니다.

> 🇰🇷 한국어 문서(기본) · 🇺🇸 [English README](./README_EN.md) · 🖥 [HTML 버전으로 보기](./README.html)

---

## 목차

0. [이 문서를 처음 보신다면](#read-me-first)
1. [이게 뭔가요? (개요)](#overview)
2. [사전 준비물 · 필요 프로그램](#prerequisites)
3. [다운로드 방법](#download)
4. [설치 방법](#install)
5. [빠른 시작 (3줄 요약)](#quickstart)
6. [실행 방법](#run)
7. [사용 방법 (단계별 가이드)](#usage)
8. [명령어 전체](#commands)
9. [작동 방법 (내부 동작 원리)](#how-it-works)
10. [워크플로우 (전체 흐름도)](#workflow)
11. [파일 · 문서 위치](#files)
12. [아키텍처](#architecture)
13. [보안 · 데이터 흐름](#security)
14. [업데이트 내용 요약](#changelog)
15. [문제 · 오류 대처 방법](#troubleshooting)
16. [FAQ (자주 묻는 질문)](#faq)
17. [법률 · 저작권 · 라이선스 · 상업적 용도](#legal)
18. [부록 (용어 풀이)](#appendix)

---

<a id="read-me-first"></a>
## 0. 이 문서를 처음 보신다면

이 문서는 **컴퓨터·AI 도구를 처음 써보는 분**도 끝까지 따라 할 수 있도록 썼습니다. 아래 3가지만 미리 알아두면 나머지는 다 순서대로 읽으면 됩니다.

- **"터미널"** = 글자로 명령을 입력하는 검은/흰 화면입니다. Claude Code를 설치하면 같이 쓰게 됩니다. 마우스로 아이콘을 누르는 대신 글자를 치고 Enter를 누르는 방식이라고 생각하면 됩니다.
- **"명령어(슬래시 명령)"** = `/business-counselor:evaluate`처럼 슬래시(`/`)로 시작하는 글자입니다. Claude Code **채팅창**에 그대로 타이핑하고 Enter를 누르면 실행됩니다. 터미널이 아니라 **채팅창**에 입력한다는 점이 중요합니다.
- **"플러그인"** = Claude Code에 기능을 하나 추가해주는 부품입니다. 이 문서가 설명하는 `business-counselor`가 바로 그 플러그인입니다. 설치하면 `/business-counselor:`로 시작하는 명령어들이 새로 생깁니다.

막히는 부분이 있으면 언제든 [문제 · 오류 대처 방법](#troubleshooting)과 [FAQ](#faq)로 건너뛰어도 됩니다.

---

<a id="overview"></a>
## 1. 이게 뭔가요? (개요)

사업/창업 아이디어가 떠올랐을 때, **"이거 될까?"를 13명의 전문가가 냉정하게 따져주는 도구**입니다.

- 혼자 생각하면 "좋은 것 같은데?" 하고 자기 확신에 빠지기 쉽습니다.
- 이 도구는 개발자·보안·법무·투자자 등 **13명 전문가 시점 + 적대 토론(찬성 vs 반대 vs 판정)**으로 약점까지 들춰냅니다.
- 결과는 **go(추진) / iterate(보완) / no-go(비추천)** 한 줄 판정으로 정리됩니다.

별도 앱·웹사이트가 아니라, 이미 쓰는 **Claude Code 안에서 명령어로** 동작합니다. 모든 결과는 **내 컴퓨터에만** 저장됩니다(외부 전송 0).

### 주요 기능

아이디어 하나를 입력하면 **단 한 번의 호출**로 분석이 완료됩니다(추가 API 호출 없음 — [보안 · 데이터 흐름](#security) 참고).

**맨 위 「한눈 요약」 카드** (항상 표시) — 판정·확신도·강점·막힌 곳·다음 행동을 한눈에:

```
## 한눈 요약
- 판정: ⛔ no-go  ·  확신도: 78/100
- 강점: ...
- 막힌 곳: ...
- 다음 행동: ...
```

그 아래 **5단계 상세 분석** (원할 때만, [기본/전체 모드](#usage) 참고):

| 단계 | 이름 | 설명 |
|------|------|------|
| § 1 | **13명 다관점 평가** | 개발·보안·법무·투자자 등 13명이 각각 1~5점 평가 + ⚠️ 위험 경고 |
| §1 부록 | **🗣 타겟 고객의 한마디** | 실제 '돈 낼 고객' 1인칭 예상 반응(살까·거부이유·대안) |
| § 2 | **Lean Canvas** | 사업 모델 9칸(문제·고객·수익 등) 자동 구성 |
| § 3 | **Mom Test 검증 질문** | 실제 고객 인터뷰에 쓸 과거행동 기반 질문 5개 |
| § 4 | **Pre-mortem** | "1년 뒤 망했다면 왜?" 실패 원인 3개 + 확률 + 완화책 |
| § 5 | **적대 토론** | Bull(찬성)·Bear(반대)·Judge(판정) → go / iterate / no-go |

누구를 위한 도구인가: 사업·창업 아이디어를 검증하고 싶은 **1인 창업자·부업 준비자·사이드 프로젝트 기획자** 본인용 도구입니다. 팀 협업 기능(다중 사용자 계정, 공유 대시보드 등)은 없습니다.

---

<a id="prerequisites"></a>
## 2. 사전 준비물 · 필요 프로그램

### 필요 프로그램

| 준비물 | 용도 | 필수 여부 | 다운로드 |
|--------|------|-----------|----------|
| **Claude Code** | 이 플러그인이 동작하는 프로그램 자체 | **필수** | [claude.ai/download](https://claude.ai/download) |
| **Claude 계정** | Claude Code 로그인용 (플러그인 자체 로그인은 없음) | **필수** | Claude Code 최초 실행 시 안내 |
| **Git** | [설치 방법](#install) A/B에 필요 | 선택 (방법 C는 불필요) | [git-scm.com/downloads](https://git-scm.com/downloads) |

### 사전 확인할 것

- **운영체제**: Windows 또는 macOS (둘 다 지원). Linux는 Claude Code 자체가 동작하는 환경이면 동일하게 동작할 것으로 예상되나, 이 프로젝트에서 별도로 실측하지는 않았습니다.
- **인터넷**: 설치할 때만 필요합니다. 설치가 끝난 뒤 인터뷰·평가를 진행하는 동안에는 (Claude Code 자체의 모델 통신을 제외하면) 이 플러그인이 별도로 외부에 데이터를 보내지 않습니다.
- **비용**: 플러그인 자체는 무료(오픈소스)입니다. Claude Code 이용에 필요한 별도 요금제·구독 여부는 Claude Code 자체 정책을 따릅니다(이 플러그인이 추가로 청구하는 비용은 없습니다).
- **회원가입·API 키·결제**: 이 플러그인은 요구하지 않습니다. Claude Code 자체 로그인만 있으면 됩니다.
- **디스크 공간**: 플러그인 코드는 수백 KB 수준(마크다운 파일 모음)이며, 사용하면서 쌓이는 내 데이터(인터뷰·평가 기록)도 텍스트 파일이라 용량 부담이 거의 없습니다.

---

<a id="download"></a>
## 3. 다운로드 방법

"다운로드"(코드를 내 컴퓨터로 가져오는 것)와 "설치"(Claude Code에 등록해서 실제로 쓸 수 있게 만드는 것)는 다른 단계입니다. 아래 3가지 방법 중 **방법 A는 다운로드와 설치가 한 번에** 끝나고, 방법 B·C는 다운로드를 먼저 한 뒤 설치 명령을 한 번 더 실행합니다.

| 방법 | 다운로드 방식 | 이럴 때 추천 |
|------|--------------|--------------|
| **A. GitHub 직접 등록 (권장)** | 별도 다운로드 단계 없음 — 등록 명령이 곧 다운로드 | 대부분의 사용자, 특히 처음 쓰는 분 |
| **B. Git 클론** | `git clone` 명령으로 저장소 전체를 내려받음 | 코드를 직접 열어보거나 수정하고 싶은 분 |
| **C. ZIP 다운로드** | GitHub 웹페이지에서 압축파일(zip)로 내려받음 | Git을 설치하고 싶지 않은 분 |

세 방법 모두 아래 [설치 방법](#install)에서 이어집니다. GitHub 저장소 주소는 다음과 같습니다: `https://github.com/sodam-ai/business-counselor` (Public, 누구나 접근 가능).

---

<a id="install"></a>
## 4. 설치 방법

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

1. [GitHub 페이지](https://github.com/sodam-ai/business-counselor) → 초록색 **Code** 버튼 → **Download ZIP**
2. 다운로드된 ZIP 압축 해제
3. 폴더 이름을 **`business-counselor`** 로 변경 (`-main` 이 붙어있으면 제거)
4. 그 폴더가 보이는 위치에서 터미널을 열고:

```bash
claude plugin marketplace add ./business-counselor
claude plugin install business-counselor@business-counselor-marketplace
claude plugin list
```

**설치 후 Claude Code를 완전히 껐다가 다시 실행**하면 `/business-counselor:*` 명령을 쓸 수 있습니다.

### 업데이트 방법

새 버전이 나왔을 때(아래 [업데이트 내용 요약](#changelog) 참고) 다음 두 명령을 순서대로 실행합니다:

```bash
claude plugin marketplace update business-counselor-marketplace
claude plugin update business-counselor@business-counselor-marketplace
```

> **왜 두 줄인가요?** 마켓플레이스 정보만 갱신하고 플러그인 자체를 갱신하지 않으면 새 기능이 반영되지 않습니다(실측 확인된 동작). 반드시 두 명령을 **순서대로 모두** 실행하세요. 업데이트 후에도 Claude Code 재시작이 필요합니다.

### 제거(삭제) 방법

플러그인만 끄고 싶다면:

```bash
claude plugin uninstall business-counselor@business-counselor-marketplace
```

마켓플레이스 등록까지 완전히 지우려면:

```bash
claude plugin marketplace remove business-counselor-marketplace
```

> 정확한 옵션명은 사용 중인 Claude Code 버전에 따라 달라질 수 있습니다. `claude plugin --help`로 최신 명령 목록을 확인하는 것을 권장합니다. **주의**: 플러그인을 제거해도 `~/Documents/business-counselor/`에 저장된 내 프로필·평가 기록은 **자동으로 삭제되지 않습니다** — 그 데이터는 플러그인 폴더가 아니라 별도의 문서 폴더에 있기 때문입니다([파일 · 문서 위치](#files) 참고). 프로필 자체를 지우고 싶다면 [`/business-counselor:edit`](#commands)를 쓰거나 해당 폴더를 직접 삭제하세요.

---

<a id="quickstart"></a>
## 5. 빠른 시작 (3줄 요약)

이미 [Claude Code](https://claude.ai/download)가 설치돼 있다면, 터미널에서:

```bash
claude plugin marketplace add sodam-ai/business-counselor
claude plugin install business-counselor@business-counselor-marketplace
```

→ Claude Code 재시작 → 채팅창에 `/business-counselor:evaluate "내 아이디어 한 줄"` 입력. 끝.

처음이라 위 명령이 막막하면 위의 **[설치 방법](#install)**과 아래 **[사용 방법](#usage)**을 그대로 따라 하세요.

---

<a id="run"></a>
## 6. 실행 방법

설치가 끝났다면 실제로 실행해보는 단계입니다.

1. **Claude Code를 엽니다.** 데스크톱 앱이나 터미널에서 `claude`를 입력해 실행합니다(설치 환경에 따라 다름 — [claude.ai/download](https://claude.ai/download) 안내를 따르세요).
2. **채팅창이 보이는지 확인합니다.** 이 채팅창에 앞으로 모든 명령을 입력합니다(터미널이 아닙니다).
3. **설치가 잘 됐는지 다시 확인하려면** 채팅창이 아니라 터미널에서 `claude plugin list`를 입력해 `business-counselor`가 `enabled` 상태인지 봅니다.
4. **첫 명령을 입력합니다.** 채팅창에 다음을 그대로 타이핑하고 Enter를 누릅니다:
   ```
   /business-counselor:help
   ```
   이 명령은 아무것도 저장하거나 바꾸지 않고 사용법만 보여주므로, 처음 실행해보기에 가장 안전합니다.
5. `/business-counselor:help`가 정상적으로 명령·용어 요약을 보여주면 설치와 실행이 모두 성공한 것입니다. 이제 [사용 방법](#usage)으로 넘어가세요.

---

<a id="usage"></a>
## 7. 사용 방법 (단계별 가이드)

### 1단계 — (선택) 나에 대한 인터뷰

```
/business-counselor:start
```

자본·시간·역량·관심 분야 등 약 12개 질문에 자연어로 답하면 됩니다(한 번에 1~2개씩, 약 30~40분). 이 정보로 이후 분석이 **내 상황에 맞춰** 더 정확해집니다. (건너뛰고 바로 평가해도 됩니다 — 일반 기준으로 평가됩니다.)

인터뷰를 하다가 중간에 멈췄다면, 다음에 이어서 하려면:

```
/business-counselor:resume
```

`resume`은 **아직 답하지 않은 항목만** 다시 물어봅니다. 이미 답한 항목은 다시 묻지 않습니다.

### 2단계 — (선택) 이미 답한 내용 수정·삭제

이미 답한 항목의 **값을 바꾸거나** 지우고 싶으면:

```
/business-counselor:edit "자본을 3000만원으로 바꿔줘"
/business-counselor:edit "관심 도메인 지워줘"
```

프로필을 **통째로 삭제**하고 싶으면:

```
/business-counselor:edit "프로필 전체 삭제해줘"
```

전체 삭제는 **되돌릴 수 없습니다.** AI가 먼저 비가역(되돌릴 수 없음) 경고를 보여주고, "네/삭제"처럼 명확히 확인하기 전까지는 실제로 지워지지 않습니다. 삭제해도 지금까지의 **아이디어 평가 기록은 남습니다**(프로필만 지워짐).

### 3단계 — 아이디어 분석

```
/business-counselor:evaluate "AI로 부동산 매물 분석해주는 서비스"
```

아이디어를 **큰따옴표(`"`) 안에** 입력합니다. 아이디어가 너무 짧거나 모호하면 AI가 보강 질문을 1~2개 먼저 합니다. 결과는 맨 위 **「한눈 요약」 카드**로 나옵니다.

### 기본(카드) / 전체(상세) 모드

- **기본**: `/business-counselor:evaluate "아이디어"` → **「한눈 요약」 카드만** (빠르고 짧음, 수십 초~수 분).
- **전체**: `/business-counselor:evaluate "아이디어" 전체` → **§1~§5 상세 분석 전부** 생성·저장(내부적으로는 기본 모드도 5단계를 모두 추론하지만, 화면에는 요약만 보여줍니다 — 분석 깊이는 두 모드가 동일합니다. 평가가 5~8분 걸리는 것은 정상입니다).
- 이미 저장된 전체 분석을 나중에 다시 보려면: `/business-counselor:show <id>`

### 4단계 — 지난 기록 확인

```
/business-counselor:list
```

지금까지 분석한 아이디어 목록을 id·판정·확신도와 함께 보여줍니다.

```
/business-counselor:show eval-2026-07-27-001
```

`list`에서 확인한 실제 id를 그대로 넣으면 해당 분석의 전체 §1~§5 내용을 다시 볼 수 있습니다. **주의**: 이 문서에 적힌 `eval-2026-07-27-001` 같은 예시는 설명용 가짜 id입니다 — 실제로 존재하는 id가 아니므로 그대로 입력하면 "찾을 수 없음" 결과가 나옵니다. 항상 내 `/business-counselor:list` 결과에 실제로 표시된 id를 복사해서 쓰세요.

### 5단계 — (선택) AI가 먼저 아이디어 추천

내가 아이디어를 안 가져오고, AI가 내 프로필 기반으로 먼저 제안해주길 원하면:

```
/business-counselor:recommend 5
```

프로필 기반 아이디어 5개(기본값, 1~10 조정 가능)를 각 Lean Canvas와 함께 추천합니다. 마음에 드는 걸
`/business-counselor:evaluate`로 심층 판독하거나, 바로 결정을 기록할 수 있습니다:

```
/business-counselor:decide idea-2026-08-02-001 go "고객 인터뷰부터 시작"
```

`<id>`는 `eval-*`(판독) 또는 `idea-*`(추천) 모두 가능하고, `<action>`은 `go`/`drop`/`iterate`/`defer` 중 하나입니다.
결정은 `decisions.jsonl`에 append-only로 쌓여 나중에 `/business-counselor:show <id>`로 이력을 다시 볼 수 있습니다.

### 막히면

```
/business-counselor:help
```

전체 명령·추천 흐름·용어 풀이를 한 화면에 보여줍니다. 언제든 먼저 입력해보세요.

---

<a id="commands"></a>
## 8. 명령어 전체

| 명령어 | 설명 | 데이터 변경 여부 |
|--------|------|:---:|
| `/business-counselor:help` | 사용법·명령·용어를 한 화면에 요약 | 없음 |
| `/business-counselor:start` | 나에 대한 AI 인터뷰 시작 (처음 한 번) | profile.md 생성 |
| `/business-counselor:resume` | 인터뷰 이어서 하기 (빠진 정보만 보완) | profile.md 갱신 |
| `/business-counselor:edit "요청"` | 이미 답한 정보 수정·비우기, 프로필 전체 삭제(확인 필수) | profile.md 변경/삭제 |
| `/business-counselor:evaluate "아이디어"` | 아이디어 분석 — 기본은 한눈 요약 카드 | 평가 결과 파일 생성 |
| `/business-counselor:evaluate "아이디어" 전체` | 아이디어 분석 — §1~§5 전체 상세 화면 표시 | 평가 결과 파일 생성 |
| `/business-counselor:recommend [N]` | 내 프로필 기반 아이디어 N개(기본 5) 추천, 각 Lean Canvas 포함 | 추천 결과 파일 생성 |
| `/business-counselor:decide <id> <action>` | 판독·추천 결과에 대한 결정(go/drop/iterate/defer) 기록 | decisions.jsonl 추가 |
| `/business-counselor:list` | 지금까지 분석·추천한 목록 (id·판정·확신도) | 없음 |
| `/business-counselor:show <id>` | 특정 분석·추천 전체 다시 보기 | 없음 |

> 막히면 언제든 `/business-counselor:help` 를 먼저 입력하세요.

---

<a id="how-it-works"></a>
## 9. 작동 방법 (내부 동작 원리)

- **단일 호출 원칙**: `/business-counselor:evaluate` 한 번 = 내부 서브에이전트(`bc-idea-evaluator`) 호출 한 번. 13명 평가·Lean Canvas·Mom Test·Pre-mortem·적대 토론 5단계를 **모두 이 한 번의 호출 안에서** 처리합니다. 응답마다 별도의 서브에이전트를 여러 번 부르지 않기 때문에 속도가 빠르고 비용이 절약됩니다.
- **냉철(cold) 모드**: 이 도구는 "잘 될 것 같다"는 긍정 편향을 의도적으로 차단하도록 설계됐습니다. 13명 중 법무(#11)·투자자(#13) 관점이 강한 부정 신호를 주면, 나머지 관점 점수가 높아도 최종 판정은 강제로 `iterate` 또는 `no-go` 쪽으로 기웁니다.
- **모호한 입력 처리**: 아이디어 문장이 너무 짧거나 불명확하면 AI가 임의로 가정해서 진행하지 않고, 먼저 1~2개의 보강 질문을 합니다.
- **프로필 반영**: `/business-counselor:start`·`resume`으로 답한 내 자본·시간·역량 정보가 있으면, 평가가 내 상황에 맞춰 더 구체적으로 나옵니다. 프로필이 없어도 평가는 가능합니다(일반 기준 적용).
- **환각(hallucination) 방지 규칙**: 출처가 불분명한 시장 규모·통계 수치는 "(추정·미검증)"으로 명시적으로 표시하도록 설계돼 있습니다. 다만 이는 AI 응답 품질에 대한 설계 원칙이며, 100% 오류 없는 응답을 보장하는 장치는 아닙니다 — 중요한 결정에는 반드시 별도 검증을 거치세요.

---

<a id="workflow"></a>
## 10. 워크플로우 (전체 흐름도)

```
[처음 1회]  /business-counselor:start  →  인터뷰 답변  →  내 프로필(profile.md) 저장
                                   │
                        (수정하고 싶으면 /business-counselor:edit 언제든)
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

<a id="files"></a>
## 11. 파일 · 문서 위치

**플러그인 폴더** (설치한 곳 — 코드·설정, 직접 수정할 필요 없음):
```
business-counselor/
├── plugin.json          ← 플러그인 설정
├── CLAUDE.md            ← AI 행동 규칙
├── AGENTS.md            ← AI 에이전트 진입점
├── CHANGELOG.md         ← 변경 이력 원문(모든 버전 상세)
├── LICENSE              ← 라이선스 전문(Apache-2.0)
├── commands/            ← 명령어 9개 (start·resume·edit·evaluate·recommend·decide·list·show·help)
├── skills/               ← 분석 스킬 (13-personas·lean-canvas·mom-test·adversarial-debate·goal-driven·pre-mortem)
├── agents/               ← bc-idea-evaluator(판독)·bc-idea-generator(추천) — 핵심 분석 엔진 2개
├── templates/            ← 출력 양식
├── tests/                ← 린터·시나리오
└── PRD/                  ← 기획 문서 (01_PRD·02_DATA_MODEL·03_PHASES·04_PROJECT_SPEC)
```

**내 데이터 위치** (설치 후 자동 생성, **내 컴퓨터에만** 저장):
```
~/Documents/business-counselor/
├── profile.md            ← 내 정보 (인터뷰 결과)
├── sessions/              ← 인터뷰 기록 (1회당 1파일)
├── ideas/evaluated/       ← 아이디어 분석 결과 (1건당 1파일)
├── ideas/generated/       ← AI 추천 아이디어 (1건당 1파일)
└── decisions.jsonl        ← go/drop/iterate/defer 결정 기록 (append-only)
```
> `~` 는 사용자 홈 폴더입니다. Windows는 보통 `C:\Users\(내 이름)\Documents\business-counselor\` 입니다. macOS는 `/Users/(내 이름)/Documents/business-counselor/` 입니다. 파일 탐색기(Windows)나 Finder(macOS)로 직접 열어서 확인할 수 있습니다 — 전부 평범한 텍스트(.md) 파일입니다.

**왜 `.claude/` 폴더가 아니라 `Documents` 폴더인가요?** 처음에는 플러그인 설치 폴더 안(`~/.claude/plugins/...`)에 데이터를 저장했으나, 실제 사용 중 `~/.claude/` 폴더 전체가 "시스템 설정 영역"으로 보호되어 AI가 새 파일을 쓰지 못하는 문제가 발견됐습니다. 사람이 파일 탐색기로 쉽게 찾아 직접 열어볼 수 있어야 한다는 원래 목표를 지키기 위해, 보호 대상이 아닌 `Documents` 폴더로 옮겼습니다(v0.4.0, 자세한 경위는 [업데이트 내용 요약](#changelog) 참고).

---

<a id="architecture"></a>
## 12. 아키텍처

이 플러그인은 **별도의 서버나 데이터베이스가 없습니다.** 전부 텍스트 파일(Markdown)과 Claude Code라는 하나의 프로그램 위에서 동작합니다.

```
사용자 (Claude Code 채팅창에 타이핑)
        │  자연어 명령/답변
        ▼
Claude Code (호스트 프로그램 — 사용자 자신의 로그인·모델 호출을 사용)
        │  플러그인 라우팅: /business-counselor:<명령 파일명>
        ▼
commands/*.md  (명령 정의 9개 — 각 명령의 행동 규칙을 적은 문서)
        │
        ├─ start·resume·edit  →  profile.md 직접 읽기/쓰기
        ├─ list·show·decide    →  저장된 평가·추천·결정 파일 읽기/append
        ├─ evaluate             →  bc-idea-evaluator로 위임
        └─ recommend            →  bc-idea-generator로 위임
                    │
                    ▼
        agents/bc-idea-evaluator.md · bc-idea-generator.md  (격리된 서브에이전트 2개, 각각 단일 호출)
        도구 권한: 둘 다 Read · Write · Glob **만** 허용
        (Task·WebFetch·WebSearch 권한이 아예 없음 →
         외부 인터넷 호출도, 추가 서브에이전트 호출도
         "설정으로 막아놓은 것"이 아니라 애초에 도구가 없어 불가능)
                    │
                    ▼
        skills/*.md 6종 참조 — 분석 방법론 지식(13-personas·pre-mortem 등)
                    │
                    ▼
        결과를 텍스트 파일로 저장 (~/Documents/business-counselor/)
                    │
                    ▼
        화면에 「한눈 요약」 카드 표시
```

**기술 스택 요약**

| 구성 요소 | 형식 | 비고 |
|-----------|------|------|
| 플러그인 정의 | `plugin.json` (Claude Code 네이티브 형식) | 별도 빌드·컴파일 과정 없음 |
| 명령 | `commands/*.md` (마크다운) | 코드가 아니라 AI에게 주는 지시문 |
| 지식/방법론 | `skills/*.md` (Open Agent Skills 표준) | 5개 분석 프레임워크 정의 |
| 실행 엔진 | `agents/bc-idea-evaluator.md` (서브에이전트) | 도구 권한 제한으로 단일 호출·외부 차단을 강제 |
| 데이터 저장 | Markdown + YAML frontmatter | 데이터베이스(SQLite·Postgres 등) 없음 |
| 인증 | 없음 (Claude Code 자체 로그인 재사용) | 별도 회원가입·API 키 불필요 |

---

<a id="security"></a>
## 13. 보안 · 데이터 흐름

### 데이터가 어디로 가는지 (한눈에)

```
[내 입력: 아이디어·프로필 답변]
        │
        ▼
Claude Code (로컬 실행, 내 계정 로그인) ── AI 응답 생성을 위해서만 Anthropic 모델과 통신
        │
        ▼
bc-idea-evaluator 서브에이전트 (로컬 실행, Read·Write·Glob 권한만)
        │
        ├─ 외부로 별도 전송되는 것: 없음 (Phase 1·2 정책 — 이 플러그인 코드 차원에서
        │   인터넷 호출 도구 자체가 주어지지 않음)
        │
        └─ 내 컴퓨터에 남는 것 (전부 평범한 텍스트 파일):
             ~/Documents/business-counselor/profile.md
             ~/Documents/business-counselor/sessions/*.md
             ~/Documents/business-counselor/ideas/evaluated/*.md
```

### 보안 설계 원칙

- **로컬 전용 저장**: 프로필·평가 결과는 전부 내 컴퓨터의 `~/Documents/business-counselor/`에만 저장됩니다. 별도 클라우드 서버로 백업·동기화하지 않습니다(직접 클라우드 동기화 폴더 안에 두지 않는 한).
- **런타임으로 강제된 외부 차단**: "외부에 안 보낸다"는 것이 단순히 프롬프트 상의 약속이 아니라, 분석 서브에이전트(`bc-idea-evaluator`)에 **Read·Write·Glob 도구만 부여**하고 인터넷 접속에 쓰이는 도구(WebFetch·WebSearch)와 추가 호출 도구(Task)를 아예 주지 않는 방식으로 구현돼 있습니다. 즉 AI가 "규칙을 어기려 해도" 도구 자체가 없어 물리적으로 불가능합니다.
- **개인정보(PII) 최소 수집**: 인터뷰가 묻는 항목은 출생연도·거주지(시/도 단위)·가족 상태·자본/월수입·시간·역량·관심 도메인·리스크 성향뿐입니다. 주민등록번호·계좌번호·연락처 같은 민감 식별정보는 애초에 질문 항목에 없습니다.
- **텔레메트리(사용 통계) 없음**: 이 플러그인 자체는 실행 코드가 없는 마크다운/프롬프트 명세이며, 별도의 분석·로깅 서버로 사용 데이터를 전송하지 않습니다. Claude Code 자체의 통신(AI 응답 생성을 위한 모델 호출)만 발생하며, 이는 이 플러그인이 아니라 Claude Code 자체의 동작입니다.
- **Phase 3(계획, 미구현)의 예외**: 향후 외부 시장 리서치 기능(`research` 명령)이 추가되면 그때는 인터넷 검색이 필요합니다. 이 경우에도 **기본값은 비활성화**이며, 사용자가 명시적으로 해당 명령을 입력할 때만 활성화되도록 설계할 계획입니다(아직 구현되지 않았습니다 — 현재 버전에는 존재하지 않는 기능입니다).

### 삭제·백업

- 프로필을 지우고 싶으면 `/business-counselor:edit "프로필 전체 삭제해줘"` (확인 절차 있음) 또는 `~/Documents/business-counselor/profile.md` 파일을 직접 삭제하면 됩니다.
- 이 플러그인은 자동 백업 기능이 없습니다. 데이터를 보존하고 싶다면 `~/Documents/business-counselor/` 폴더를 사용자가 직접 복사해두는 것을 권장합니다.
- 플러그인을 제거해도 이 데이터 폴더는 남아있습니다([설치 방법](#install)의 "제거" 항목 참고).

---

<a id="changelog"></a>
## 14. 업데이트 내용 요약

아래는 요약입니다. 전체 원문(수정 이유·원인 분석 포함)은 [`CHANGELOG.md`](./CHANGELOG.md)에서 볼 수 있습니다. 각 항목을 눌러 펼쳐보세요.

<details>
<summary><strong>v0.5.2</strong> — 2026-07-27 · 비개발자용 종합 README(한/영, md+html) 신규 작성</summary>

- 목차·설치·사전 준비물·다운로드·빠른 시작·실행/사용/작동 방법·명령어·아키텍처·보안·문제 대처·FAQ·법률/라이선스를 모두 포함하는 종합 안내서로 README를 전면 재작성
- 한국어(README.md)·영어(README_EN.md) 두 언어, 각각 md·html 두 형식(총 4개 파일)으로 동일 내용 제공
- 기능 변경 없음(문서 전용 릴리스)

</details>

<details>
<summary><strong>v0.5.1</strong> — 2026-07-27 · 검증 중 발견 문서-구현 불일치 3건 수정</summary>

- `risk_appetite` 문서 표기를 실제 구현값(`low`/`medium`/`high`)에 맞춰 정정
- `capital_krw`·`monthly_income_krw` 단위 표기를 실제 저장 방식(원 단위 정수)에 맞춰 정정
- README 파일 트리 주석의 명령 개수 표기(6개→7개) 정정
- `resume`이 이미 채워진 필드를 사용자가 자발적으로 정정하려 할 때 `edit`로 안내하는 규칙 추가

</details>

<details>
<summary><strong>v0.5.0</strong> — 2026-07-27 · <code>/business-counselor:edit</code> 명령 신규 추가</summary>

- 이미 답한 프로필 항목을 값 변경 / 비우기 / 전체 삭제할 수 있는 명령 추가
- 전체 삭제는 비가역 경고 + 명시적 확인 후에만 실행, 평가 기록(`ideas/evaluated/`)은 별도 보존
- 시스템 관리 필드(id·schema_version·last_updated·profile_updates·disclaimer)는 수정 대상에서 제외
- 명령 6개 → 7개로 확장

</details>

<details>
<summary><strong>v0.4.0</strong> — 2026-07-27 · 데이터 저장 위치를 <code>~/.claude/</code> 밖으로 이전</summary>

- 실사용 중 `~/.claude/` 전체가 AI 쓰기 보호 대상임을 실측으로 확인 → 데이터 저장 위치를 `~/Documents/business-counselor/`로 변경
- 기존 실사용 평가 3건을 새 위치로 손실 없이 이전(바이트 단위 동일 확인)
- 관련 문서 전체(README 2종·PRD 4문서·명령 6개 등) 경로 동기화

</details>

<details>
<summary><strong>v0.3.0</strong> — 2026-07-27 · 명령 이름 간소화(<code>counsel-</code> 접두어 제거)</summary>

- `/business-counselor:counsel-evaluate` → `/business-counselor:evaluate`처럼 6개 명령 전체 단순화
- 플러그인 이름 자체가 이미 네임스페이스이므로 접두어 중복 제거

</details>

<details>
<summary><strong>v0.2.0 ~ v0.2.2</strong> — 2026-06-15 ~ 2026-07-27 · 사용성 고도화 + 실 E2E에서 발견된 결함 수정</summary>

- 「한눈 요약」 카드, `/business-counselor:help` 명령, 「타겟 고객의 한마디」 부록 추가
- 기본(카드)/전체(상세) 2단계 출력 모드 도입
- 실 사용 중 발견된 명령 네임스페이스 표기 오류(문서에는 있었지만 실제로 동작한 적 없던 표기) 수정
- 마켓플레이스 등록 방식을 GitHub 직접 등록 방식으로 개선

</details>

<details>
<summary><strong>v0.1.0 ~ v0.1.1</strong> — 2026-05-08 ~ 2026-06-15 · Phase 1 최초 구현 + 안정화</summary>

- 플러그인 골격, 명령 5개, 스킬 5종, 서브에이전트 1개 최초 구현
- 린터 과잉 검증·순번 충돌 등 정합성 결함 6건 수정
- Windows 네이티브 PowerShell 린터 추가

</details>

> 버전 번호 읽는 법: `주.부.수` 형식이며 부(minor) 버전 상승은 새 기능 추가, 수(patch) 버전 상승은 신규 기능 없는 수정을 뜻합니다(Semantic Versioning 관례를 따르되 엄격히 강제하지는 않습니다).

---

<a id="troubleshooting"></a>
## 15. 문제 · 오류 대처 방법

| 증상 | 원인 | 해결 |
|------|------|------|
| `/business-counselor:*` 명령이 안 보임 | 설치 후 미재시작 | **Claude Code를 완전히 껐다 다시 실행** |
| `plugin list`에 enabled 안 뜸 | 등록/설치 누락 | `marketplace add sodam-ai/business-counselor` → `install ...@business-counselor-marketplace` 다시 실행 |
| `claude: command not found` | Claude Code 미설치/경로 문제 | [claude.ai/download](https://claude.ai/download)에서 설치 후 재시작 |
| `git: command not found` | Git 미설치 | [git-scm.com](https://git-scm.com/downloads) 설치 또는 [ZIP 방법(C)](#download) 사용 |
| 업데이트했는데 새 명령이 안 보임 | 버전 갱신 명령을 하나만 실행했거나 재시작 안 함 | [업데이트 방법](#install) 두 줄 모두 실행 + 재시작 |
| 평가가 5~8분 걸림 | 깊은 분석은 원래 오래 걸림 | 정상입니다. 기다리거나, 다음에는 시간 여유 있을 때 실행하세요 |
| 결과가 카드만 짧게 나옴 | 기본이 카드 모드 | 전체는 `/business-counselor:evaluate "..." 전체` 또는 `/business-counselor:show <id>` |
| `show`에서 "찾을 수 없음" | 존재하지 않는 id를 입력함(이 문서의 예시 id 포함) | `/business-counselor:list`로 실제 id를 먼저 확인 후 복사해서 입력 |
| 프로필 없이 평가됨 | 인터뷰 미진행 | 일반 기준으로 평가됩니다. 맞춤 원하면 `/business-counselor:start` 먼저 |
| `edit`로 지운 항목이 안 지워진 것 같음 | 확인 질문에 "네"라고 답하지 않았거나 취소함 | `/business-counselor:edit`를 다시 입력해 요청을 명확히 하고, 확인 질문에 명확히 응답 |
| 프로필을 실수로 전체 삭제함 | 확인 절차를 거쳐 실제로 삭제된 상태 | 되돌릴 수 없습니다. `/business-counselor:start`로 새로 인터뷰를 시작하세요. 과거 아이디어 평가 기록은 삭제되지 않고 남아있습니다 |
| 다른 플러그인의 `uv: command not found` 등 오류 | **이 플러그인과 무관** | 무시해도 됩니다 (다른 도구의 알림) |

> 표에 없는 문제는 `/business-counselor:help`를 입력해 현재 사용법을 확인하거나, [GitHub Issues](https://github.com/sodam-ai/business-counselor/issues)에 문의하세요.

---

<a id="faq"></a>
## 16. FAQ (자주 묻는 질문)

**Q. 이 도구는 유료인가요?**
A. 플러그인 자체는 무료·오픈소스(Apache-2.0)입니다. Claude Code 이용 자체에 필요한 비용은 Claude Code 정책을 따르며, 이 플러그인이 별도로 추가 청구하는 요금은 없습니다.

**Q. 제 사업 아이디어나 자본 정보가 외부로 새어나가나요?**
A. 아닙니다. [보안 · 데이터 흐름](#security)에서 설명한 대로, Phase 1·2(현재 버전)는 인터넷으로 별도 전송하는 기능 자체가 코드 권한상 없습니다. 입력한 내용은 Claude Code의 AI 응답 생성 과정(여느 Claude Code 대화와 동일)과 내 컴퓨터의 로컬 파일에만 존재합니다.

**Q. AI가 평가한 결과를 100% 믿어도 되나요?**
A. 아니요. 이 도구는 **참고용 의견**을 제공하는 것이며, 사업 성공을 보장하지 않습니다. 특히 법률·투자·세무와 관련된 판단이 필요한 경우 반드시 변호사·세무사·재무자문가 등 전문가와 상담하세요. 자세한 내용은 [법률 · 저작권 · 라이선스 · 상업적 용도](#legal)를 확인하세요.

**Q. AI가 알아서 사업 아이디어를 골라주나요?**
A. 네. `/business-counselor:recommend`로 내 프로필 기반 아이디어를 AI가 먼저 추천받을 수 있습니다(Phase 2, v0.6.0+). 직접 아이디어를 가져와 평가받고 싶으면 기존처럼 `/business-counselor:evaluate`를 쓰면 됩니다 — 두 방식 다 지원합니다.

**Q. 인터넷이 없어도 쓸 수 있나요?**
A. 아니요. Claude Code 자체가 AI 모델과 통신해야 응답을 만들 수 있으므로 인터넷 연결이 필요합니다. 다만 이 플러그인이 별도로 외부 웹사이트를 검색하거나 데이터를 전송하지는 않습니다.

**Q. 다른 컴퓨터로 옮기면 제 데이터도 같이 옮겨지나요?**
A. 자동으로는 옮겨지지 않습니다. 데이터는 `~/Documents/business-counselor/` 폴더에 있으므로, 이 폴더를 직접 복사해서 새 컴퓨터의 같은 위치에 붙여넣으면 이어서 사용할 수 있습니다.

**Q. 삭제한 프로필이나 평가 기록을 복구할 수 있나요?**
A. 이 플러그인 자체에는 복구 기능(휴지통 등)이 없습니다. `/business-counselor:edit`의 전체 삭제는 확인 절차를 거치지만, 확인 후에는 되돌릴 수 없습니다. 삭제 전에 폴더를 백업해두는 것을 권장합니다.

**Q. 이 도구가 법률 자문이나 투자 자문인가요?**
A. 아닙니다. [법률 · 저작권 · 라이선스 · 상업적 용도](#legal)에 명시된 대로, 투자자문업·창업컨설팅업·세무자문·법률자문에 해당하지 않는 참고용 의견 도구입니다.

**Q. 여러 아이디어를 동시에 평가할 수 있나요?**
A. 한 번에 하나씩 순서대로 평가합니다. `/business-counselor:evaluate`를 아이디어별로 여러 번 실행하면 되고, 결과는 각각 별도 파일로 저장되어 `/business-counselor:list`에서 함께 확인할 수 있습니다.

**Q. 평가 결과(분석 텍스트)를 다른 곳에 써도 되나요? 상업적으로 이용해도 되나요?**
A. 네. 분석 결과는 내가 입력한 내 아이디어를 바탕으로 생성된 내 자료이며, 이 도구가 그 결과물의 소유권을 주장하지 않습니다. 다만 그 내용의 정확성은 보장되지 않으므로, 중요한 상업적 결정에 사용하기 전에는 반드시 별도 검증을 거치세요. 자세한 내용은 [법률 · 저작권 · 라이선스 · 상업적 용도](#legal)를 참고하세요.

**Q. 이 플러그인의 소스코드 자체를 제 제품에 가져다 써도 되나요?**
A. 네, Apache License 2.0에 따라 상업적 이용을 포함해 자유롭게 사용·수정·배포할 수 있습니다. 다만 라이선스 사본 포함, 변경 사항 명시 등 몇 가지 조건이 있습니다. 자세한 내용은 [법률 · 저작권 · 라이선스 · 상업적 용도](#legal)와 [`LICENSE`](./LICENSE) 원문을 확인하세요.

**Q. 오류가 나거나 이상하게 동작하면 어디에 알려야 하나요?**
A. [GitHub 저장소](https://github.com/sodam-ai/business-counselor)의 Issues 메뉴에 남겨주세요.

---

<a id="legal"></a>
## 17. 법률 · 저작권 · 라이선스 · 상업적 용도

> 아래 내용은 일반 정보 제공용이며 법률 자문이 아닙니다. 실제 상업적 이용·재배포·법적 판단이 필요한 경우 변호사 등 전문가 확인을 권장합니다.

### 17.1 이 소프트웨어(플러그인 코드)의 라이선스

이 플러그인(`business-counselor`)은 **Apache License 2.0** 아래 배포됩니다.

- **저작권자**: Copyright 2026 SoDam AI Studio
- **라이선스 전문**: [`LICENSE`](./LICENSE) 파일 (표준 Apache-2.0 원문)
- **허용되는 것** (요약 — 정확한 조건은 원문 기준):
  - 상업적 이용(제품에 포함, 판매, SaaS 운영 등)
  - 수정(코드를 바꿔서 사용)
  - 배포(다른 사람에게 재배포)
  - 특허 실시권 부여(기여자로부터의 특허 라이선스 포함)
  - 사적 이용
- **조건**:
  - 라이선스 사본과 저작권 고지를 함께 배포해야 합니다.
  - 수정한 파일에는 "변경했음"을 명시해야 합니다.
  - `NOTICE` 파일이 있다면 그 내용을 함께 배포해야 합니다.
- **보장하지 않는 것**:
  - **무보증(AS IS)**: 이 소프트웨어는 어떠한 형태의 보증도 없이 "있는 그대로" 제공됩니다. 상품성·특정 목적 적합성 등을 보증하지 않습니다.
  - **책임 제한**: 이 소프트웨어의 사용으로 발생하는 손해에 대해 저작권자·기여자는 법이 정한 경우를 제외하고 책임지지 않습니다.
  - **상표권 미부여**: 이 라이선스는 "SoDam AI Studio"·"business-counselor" 등의 이름·상표를 사용할 권리를 별도로 부여하지 않습니다(출처 표기 목적의 통상적 사용은 예외).

### 17.2 이 도구가 만들어내는 결과물(분석 텍스트)에 대하여

- 평가 결과(§1~§5 분석, 「한눈 요약」 카드 등)는 **사용자가 직접 입력한 사업 아이디어를 바탕으로 생성된 사용자 자신의 자료**입니다. 이 프로젝트(SoDam AI Studio)는 그 결과물 자체에 대한 소유권이나 이용 제한을 주장하지 않습니다.
- 다만 결과물의 **정확성·완전성·최신성은 보장되지 않습니다.** 결과물을 상업적 의사결정, 투자 유치 자료, 사업계획서 등에 활용하기 전에는 사실관계를 별도로 검증하시기 바랍니다.
- 결과물에 포함된 시장 규모·통계 등은 AI가 생성한 추정치일 수 있으며, 출처가 불분명한 수치는 "(추정·미검증)"으로 표시되도록 설계돼 있으나 완벽함을 보장하지는 않습니다.

### 17.3 법적 성격에 대한 면책 조항 (도구가 하지 않는 것)

이 도구는 다음에 **해당하지 않습니다**:

- **투자자문업**(대한민국 자본시장과 금융투자업에 관한 법률 제6조 제5항) 및 **투자일임업**(같은 법 제17조)
- 창업컨설팅업
- 세무자문
- 법률자문

**모든 분석 결과는 참고용 의견입니다.** 특정 종목·금융상품·재무상품을 추천하지 않으며, 사업의 성공이나 수익을 보장하지 않습니다. 중요한 결정을 내리기 전에는 변호사·세무사·재무자문가 등 해당 분야 전문가와 상담할 것을 권고합니다. 이 도구를 통한 의사결정으로 발생하는 손익 및 법적 책임 일체는 사용자 본인에게 있으며, 도구 제작자는 책임지지 않습니다.

### 17.4 개인정보·데이터 관련

- 자세한 데이터 처리 방식은 [보안 · 데이터 흐름](#security)을 참고하세요.
- 이 도구는 별도의 개인정보 수집·판매·제3자 제공을 하지 않습니다(로컬 저장 전용).
- 인터뷰 항목에 주민등록번호·계좌번호 등 민감한 고유식별정보는 포함돼 있지 않지만, 자유서술 답변란에 사용자가 임의로 민감정보를 적지 않도록 주의하시기 바랍니다.

### 17.5 상업적 용도 요약

| 항목 | 상업적 이용 가능 여부 | 비고 |
|------|:---:|------|
| 플러그인 코드를 그대로/수정해서 내 제품·서비스에 포함 | 가능 | Apache-2.0 조건(라이선스 고지·변경 명시) 준수 |
| 이 도구로 만든 사업 분석 결과를 사업계획서·투자유치 자료에 활용 | 가능 | 정확성 보장 없음 — 별도 검증 필수 |
| 이 도구를 재판매(유료 서비스화) | 가능 | Apache-2.0은 재판매를 금지하지 않음. 단, "SoDam AI Studio"·"business-counselor" 이름/상표를 마치 공식 제휴·보증인 것처럼 사용하는 것은 권장하지 않음 |
| 이 도구의 분석을 실제 투자 자문·법률 자문으로 제공 | **권장하지 않음 / 위험** | §17.3 참고 — 별도의 인허가·자격이 필요한 영역일 수 있음 |

---

<a id="appendix"></a>
## 18. 부록 (용어 풀이)

| 용어 | 뜻 |
|------|-----|
| Claude Code | Anthropic이 만든, 터미널·채팅창에서 AI와 대화하며 작업하는 프로그램. 이 플러그인이 동작하는 "본체"입니다. |
| 플러그인 | Claude Code에 기능을 추가하는 부품. `business-counselor`가 이 플러그인의 이름입니다. |
| 슬래시 명령 | `/business-counselor:evaluate`처럼 `/`로 시작하는, Claude Code 채팅창에 입력하는 명령어. |
| 마켓플레이스 | 플러그인들을 등록·배포하는 저장소 개념. `claude plugin marketplace add`로 등록합니다. |
| 서브에이전트 | 특정 작업(여기서는 아이디어 분석)만 전담하는, 도구 권한이 제한된 내부 AI 실행 단위. |
| 프로필(profile.md) | 인터뷰로 쌓인 나에 대한 정보가 저장된 파일. |
| verdict(판정) | 평가 결과의 최종 결론. go(추진)/iterate(보완)/no-go(비추천) 셋 중 하나. |
| Lean Canvas | 사업 모델을 9개 칸(문제·고객·수익 구조 등)으로 요약하는 유명한 기획 도구. |
| Mom Test | "어머니께 여쭤봐도 무조건 좋다고 하실 질문"을 피하고, 과거 행동 기반으로 진짜 수요를 검증하는 인터뷰 기법. |
| Pre-mortem | 일이 끝난 뒤 원인을 분석하는 "사후 부검(post-mortem)"과 반대로, 시작 전에 "이미 실패했다고 가정"하고 원인을 미리 찾아보는 기법. |
| frontmatter | 마크다운 파일 맨 위에 `---`로 감싸 넣는 구조화된 메타데이터(제목·날짜·버전 등)를 적는 표준 방식. |

---

## 라이선스 요약

Apache License 2.0 · Copyright 2026 SoDam AI Studio · 전문: [LICENSE](./LICENSE) · 상업적 이용 조건은 [§17](#legal) 참고.

---

🇺🇸 [English README](./README_EN.md) · 🖥 [HTML 버전](./README.html) · 변경 이력 원문: [CHANGELOG.md](./CHANGELOG.md) · 문의: [GitHub Issues](https://github.com/sodam-ai/business-counselor/issues)
