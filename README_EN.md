# AI Business Counselor (business-counselor)

> **Claude Code Plugin** · v0.1.0 · Phase 1 MVP  
> Enter your business idea and AI instantly delivers a 5-stage cold analysis from 13 expert perspectives.

**No coding required.** Just type commands in the Claude Code chat window.

---

## Key Features

A single input triggers a **one-call, 5-stage analysis** — no multiple API calls.

| Stage | Name | Description |
|-------|------|-------------|
| § 1 | **13-Persona Evaluation** | 13 experts (developer, security, lawyer, investor, etc.) each score 1–5 |
| § 2 | **Lean Canvas** | Auto-generates 9-block business model (problem, customer, revenue, etc.) |
| § 3 | **Mom Test Questions** | 5 evidence-based customer interview questions |
| § 4 | **Pre-mortem** | Top 3 failure causes assuming the project has already failed |
| § 5 | **Adversarial Debate** | Bull (optimist) · Bear (pessimist) · Judge (ruling) → go / iterate / no-go verdict |

All results are automatically saved to `~/.claude/plugins/business-counselor/data/`.

---

## Installation

### Prerequisites

- [Claude Code](https://claude.ai/download) installed
- [Git](https://git-scm.com/downloads) installed (Method A only. Method B does not require Git)

### Method A — Install with Git (Recommended)

Run the following commands in your terminal in order.  
**Important:** After `git clone`, do NOT enter the cloned folder — run the next commands from the same location.

```bash
# 1. Download the repository
git clone https://github.com/sodam-ai/business-counselor.git

# 2. Register local marketplace (run from the folder that contains business-counselor/)
claude plugin marketplace add ./business-counselor

# 3. Install plugin
claude plugin install business-counselor@local-plugins

# 4. Verify installation
claude plugin list
```

Installation is successful when you see `business-counselor@local-plugins  √ enabled`.

### Method B — Install via ZIP (No Git Required)

1. Go to the [GitHub page](https://github.com/sodam-ai/business-counselor) → click **Code** → **Download ZIP**
2. Extract the downloaded ZIP file
3. Rename the extracted folder to **`business-counselor`** (default name is `business-counselor-main`)
4. Open a terminal in the folder that contains `business-counselor/` and run:

```bash
claude plugin marketplace add ./business-counselor
claude plugin install business-counselor@local-plugins
claude plugin list
```

Installation is successful when you see `business-counselor@local-plugins  √ enabled`.

After installation, **restart Claude Code** to activate `/counsel:` commands.

---

## Usage

### First-time Setup

```
/counsel:start
```

AI conducts a short interview about you — capital, time, skills, domain interests (~12 questions). Answer in plain language. This context personalizes all future analyses.

### Analyze an Idea

```
/counsel:evaluate "AI-powered real estate matching platform"
```

Wrap your idea in quotes. If the idea is vague, AI asks 1–2 clarifying questions first.

### All Commands

| Command | Description |
|---------|-------------|
| `/counsel:start` | Start your AI interview (first time only) |
| `/counsel:evaluate "idea"` | 5-stage cold analysis |
| `/counsel:list` | View all past analyses |
| `/counsel:resume` | Continue/update your interview |
| `/counsel:show <id>` | Re-view a specific analysis |

---

## Guide for Non-Developers

> For those who have never written code.

### What is a "terminal"?

A terminal is a text-based window for sending commands to your computer.

- **Windows**: Start → search "PowerShell" → Open
- **Mac**: Spotlight (⌘+Space) → search "Terminal" → Open

### Step 1: Install Claude Code

1. Go to [claude.ai/download](https://claude.ai/download)
2. Download and run the installer
3. Type `claude` in terminal → a chat window opens — installation successful

### Step 2: Install This Plugin

**If you have Git** (paste these 3 lines into terminal in order):

```bash
git clone https://github.com/sodam-ai/business-counselor.git
claude plugin marketplace add ./business-counselor
claude plugin install business-counselor@local-plugins
```

> No Git? Install it from [git-scm.com/downloads](https://git-scm.com/downloads), or use the ZIP method below.

**If you don't have Git** (ZIP download):

1. Go to [github.com/sodam-ai/business-counselor](https://github.com/sodam-ai/business-counselor)
2. Click the green **Code** button → **Download ZIP**
3. Extract the ZIP file
4. Rename the folder to `business-counselor` (remove `-main` if present)
5. Open a terminal in the folder that contains `business-counselor/` and run:

```bash
claude plugin marketplace add ./business-counselor
claude plugin install business-counselor@local-plugins
```

**Verify installation**: Type `claude plugin list` → confirm `business-counselor  √ enabled`

### Step 3: First Use

1. Type `claude` in terminal → restart Claude Code if this is the first run after install
2. Type `/counsel:start` → Enter
3. Answer AI's questions in plain language
4. After interview, type `/counsel:evaluate "my idea"`

---

## Folder Structure

```
business-counselor/
├── plugin.json                  ← Plugin manifest
├── CLAUDE.md                    ← AI behavior rules
├── AGENTS.md                    ← AI agent entry point
├── CHANGELOG.md                 ← Change history
│
├── commands/                    ← Command files (5)
│   ├── counsel-start.md
│   ├── counsel-resume.md
│   ├── counsel-evaluate.md
│   ├── counsel-list.md
│   └── counsel-show.md
│
├── skills/                      ← AI analysis skills (5)
│   ├── 13-personas/SKILL.md
│   ├── lean-canvas/SKILL.md
│   ├── mom-test/SKILL.md
│   ├── adversarial-debate/SKILL.md
│   └── goal-driven/SKILL.md
│
├── agents/
│   └── bc-idea-evaluator.md     ← Core analysis agent
│
├── templates/                   ← Output templates
├── tests/                       ← Linter & scenario tests
└── PRD/                         ← Product planning docs
```

**Data location** (auto-created after install):
```
~/.claude/plugins/business-counselor/data/
├── profile.md           ← Your profile (interview result)
├── sessions/            ← Interview conversation logs
└── ideas/evaluated/     ← Idea analysis results
```

---

## Operations Notes

### Data Security

- Your profile and analysis results are stored **on your local machine only**
- No data is sent to external servers (Phase 1 & 2 policy)
- Data path: `~/.claude/plugins/business-counselor/data/`

### Legal Disclaimer

This tool does NOT constitute:

- Investment advisory services (Korean Capital Markets Act Art. 6(5))
- Business consulting · Tax advisory · Legal advisory

**All analysis outputs are reference opinions only.** Consult qualified professionals (lawyers, accountants, financial advisors) before making significant decisions.

### Known Limitations (Phase 1)

- No external research (live market data) → planned for Phase 3
- No auto idea generation → planned for Phase 2
- `consistency_score` (repeated evaluation consistency) not yet implemented → Phase 2

---

## License

Apache License 2.0 · Copyright 2026 SoDam AI Studio

See the [LICENSE](./LICENSE) file for details.

---

[한국어 README](./README.md)
