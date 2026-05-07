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

### Install (3 steps)

```bash
# 1. Clone this repository
git clone https://github.com/sodam-ai/business-counselor.git

# 2. Register local marketplace
claude plugin marketplace add ./business-counselor/.claude-plugin

# 3. Install plugin
claude plugin install business-counselor@local-plugins
```

Once installed, `/counsel:` commands are available in Claude Code chat.

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

### Install Claude Code

1. Go to [claude.ai/download](https://claude.ai/download)
2. Download and run the installer
3. Type `claude` in terminal → a chat window opens — installation successful

### Install This Plugin (paste these 3 lines into terminal in order)

```bash
git clone https://github.com/sodam-ai/business-counselor.git
claude plugin marketplace add ./business-counselor/.claude-plugin
claude plugin install business-counselor@local-plugins
```

### First Use

1. Type `claude` in terminal to open chat
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
