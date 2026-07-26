# AI Business Counselor (business-counselor)

> **Claude Code Plugin** · v0.2.2 · Phase 1 MVP
> Enter a business idea and AI instantly delivers a **5-stage cold analysis** from 13 expert perspectives.

**No coding required.** Just type commands in the Claude Code chat window.

> 🇺🇸 English · 🇰🇷 [한국어 README](./README.md) (primary)

---

## ⚡ Quick Start (3 lines)

If [Claude Code](https://claude.ai/download) is already installed, in your terminal:

```bash
claude plugin marketplace add sodam-ai/business-counselor
claude plugin install business-counselor@business-counselor-marketplace
```

→ Restart Claude Code → type `/business-counselor:evaluate "my idea in one line"`. Done.

New to this? Follow the **[Installation](#-installation)** and **[Usage](#beginner-guide)** below step by step.

---

## 🤔 What is this?

When a business idea strikes, this tool makes **13 experts coldly assess "will this actually work?"**

- Alone, it's easy to fall into "this seems great!" self-confidence bias.
- This tool exposes weaknesses via **13 expert lenses (developer, security, legal, investor, …) + adversarial debate (pro vs con vs judge).**
- The result is a one-line verdict: **go / iterate / no-go.**

It's not a separate app or website — it runs **inside Claude Code via commands**. All results are stored **on your local machine only** (zero external transmission).

---

## ✨ Key Features

A single input triggers a **one-call analysis**.

**Top "At-a-Glance Summary" card** (always shown) — verdict, confidence, strength, blocker, next action:

```
## At-a-Glance Summary
- Verdict: ⛔ no-go  ·  Confidence: 78/100
- Strength: ...
- Blocker: ...
- Next action: ...
```

Below it, the **5-stage detail** (only when you want it — see [Default/Full mode](#defaultcard--fulldetail-mode)):

| Stage | Name | Description |
|-------|------|-------------|
| § 1 | **13-Persona Evaluation** | 13 experts (dev, security, legal, investor, …) score 1–5 + ⚠️ risk flags |
| §1 add-on | **🗣 Target Customer's Voice** | The actual paying customer's 1st-person reaction (would I buy, dealbreaker, alternative) |
| § 2 | **Lean Canvas** | Auto-generated 9-block business model (problem, customer, revenue, …) |
| § 3 | **Mom Test Questions** | 5 past-behavior-based customer interview questions |
| § 4 | **Pre-mortem** | Top 3 failure causes + probability + mitigation, assuming it already failed |
| § 5 | **Adversarial Debate** | Bull (pro) · Bear (con) · Judge (ruling) → go / iterate / no-go |

All results auto-save to `~/.claude/plugins/business-counselor/data/`.

---

## 📦 Prerequisites / Required Software

| Requirement | Purpose | Download |
|-------------|---------|----------|
| **Claude Code** | The program this plugin runs in (required) | [claude.ai/download](https://claude.ai/download) |
| **Git** | Needed for Method A (Method B doesn't need it) | [git-scm.com/downloads](https://git-scm.com/downloads) |

- OS: Windows / macOS both supported
- Internet: only needed during install (zero external transmission while in use)
- No signup / API key / payment needed (uses Claude Code's own login)

---

## 🔧 Installation

### Method A — Install directly from GitHub (Recommended, no clone needed)

Paste one line at a time into your terminal:

```bash
# 1. Register the marketplace (references the GitHub repo directly — no clone needed)
claude plugin marketplace add sodam-ai/business-counselor

# 2. Install the plugin
claude plugin install business-counselor@business-counselor-marketplace

# 3. Verify
claude plugin list
```

→ Success when you see `business-counselor@business-counselor-marketplace  √ enabled`.

### Method B — Clone with Git (when editing the code directly)

> **Note:** After `git clone`, do NOT enter the cloned folder — run the next commands from the location where the folder is visible.

```bash
# 1. Download the repository
git clone https://github.com/sodam-ai/business-counselor.git

# 2. Register marketplace from the local path (from where the folder is visible)
claude plugin marketplace add ./business-counselor

# 3. Install the plugin
claude plugin install business-counselor@business-counselor-marketplace

# 4. Verify
claude plugin list
```

### Method C — Install via ZIP (No Git)

1. [GitHub page](https://github.com/sodam-ai/business-counselor) → green **Code** → **Download ZIP**
2. Extract the ZIP
3. Rename the folder to **`business-counselor`** (remove `-main` if present)
4. Open a terminal where the folder is visible and run:

```bash
claude plugin marketplace add ./business-counselor
claude plugin install business-counselor@business-counselor-marketplace
claude plugin list
```

**Restart Claude Code** after install to activate `/business-counselor:*` commands.

---

<a id="beginner-guide"></a>
## 🚀 Usage (Quick First Run)

### Step 1 — (Optional) Interview about you

```
/business-counselor:start
```

Answer ~12 questions (capital, time, skills, interests) in plain language (1–2 at a time, ~30–40 min). This personalizes future analyses. (You can skip and evaluate directly — it uses general criteria.)

### Step 2 — Analyze an idea

```
/business-counselor:evaluate "an AI service that analyzes real estate listings"
```

Wrap the idea in quotes. If vague, AI asks 1–2 clarifying questions first. The result appears as a top **"At-a-Glance Summary" card**.

<a id="mode-guide"></a>
### Default (card) / Full (detail) mode

- **Default**: `/business-counselor:evaluate "idea"` → **summary card only** (fast, short).
- **Full**: `/business-counselor:evaluate "idea" full` → **full §1–§5 detail** generated & saved. (see [Default/Full mode](#mode-guide) below)
- Re-view saved full analysis: `/business-counselor:show <id>`

---

## 📋 All Commands

| Command | Description |
|---------|-------------|
| `/business-counselor:help` | Usage, commands & glossary on one screen |
| `/business-counselor:start` | Start the AI interview about you (first time) |
| `/business-counselor:resume` | Continue the interview (fill missing info) |
| `/business-counselor:evaluate "idea"` | Analyze — default is the summary card |
| `/business-counselor:evaluate "idea" full` | Analyze — full §1–§5 detail |
| `/business-counselor:list` | List past analyses (id · verdict · confidence) |
| `/business-counselor:show <id>` | Re-view a specific full analysis |

> Stuck? Type `/business-counselor:help` first.

---

## ⚙️ How It Works / Workflow

```
[once]   /business-counselor:start  →  answer interview  →  save your profile (profile.md)
                                  │
[each time]  /business-counselor:evaluate "idea"
            │
            ├─ if vague → AI asks 1–2 clarifying questions → answer
            │
            ▼
        In a single call, AI internally runs:
        13-persona → target customer's voice → Lean Canvas → Mom Test → Pre-mortem → adversarial debate
            │
            ▼
        Screen: "At-a-Glance Summary" card (verdict · confidence · strength · blocker · next)
        Saved : result file (.md)  →  /business-counselor:list to list, /business-counselor:show to re-view
```

- **Single call**: one command = one analysis (zero extra calls). Fast & cost-saving.
- **Cold mode**: blocks positivity bias and surfaces weaknesses/risks first. Legal/investment risks flagged with ⚠️.

---

## 📁 File & Doc Locations

**Plugin folder** (where you installed):
```
business-counselor/
├── plugin.json          ← Plugin manifest
├── CLAUDE.md            ← AI behavior rules
├── AGENTS.md            ← AI agent entry point
├── CHANGELOG.md         ← Change history
├── commands/            ← 6 commands (start·resume·evaluate·list·show·help)
├── skills/              ← analysis skills (13-personas·lean-canvas·mom-test·adversarial-debate·goal-driven)
├── agents/              ← bc-idea-evaluator (core analysis engine)
├── templates/           ← output templates
├── tests/               ← linters & scenarios
└── PRD/                 ← planning docs (01_PRD·02_DATA_MODEL·03_PHASES·04_PROJECT_SPEC)
```

**Your data** (auto-created after install, local only):
```
~/.claude/plugins/business-counselor/data/
├── profile.md           ← Your profile (interview result)
├── sessions/            ← Interview logs
└── ideas/evaluated/     ← Idea analysis results
```
> `~` is your home folder. On Windows usually `C:\Users\(you)\.claude\...`.

---

## 🆘 Troubleshooting

| Symptom | Cause | Fix |
|---------|-------|-----|
| `/business-counselor:*` commands not showing | Not restarted after install | **Quit and relaunch Claude Code** |
| `plugin list` shows no enabled | Missing register/install | Re-run `marketplace add sodam-ai/business-counselor` → `install ...@business-counselor-marketplace` |
| `claude: command not found` | Claude Code missing/path | Install from [claude.ai/download](https://claude.ai/download), restart |
| `git: command not found` | Git missing | Install [git-scm.com](https://git-scm.com/downloads) or use ZIP (Method B) |
| Evaluation takes 5–8 min | Deep analysis is naturally slow | Normal. For speed, use **default (card) mode** |
| Result is just a short card | Default is card mode | Full: `/business-counselor:evaluate "..." full` or `/business-counselor:show <id>` |
| Errors like `uv: command not found` | **Unrelated to this plugin** | Ignore (another tool's notice) |
| Evaluated without profile | Interview skipped | Uses general criteria. For tailored, run `/business-counselor:start` first |

> Still stuck? Type `/business-counselor:help` to see current usage.

---

## 🔒 Operations / Security Notes

### Data security
- Your profile and analyses are stored **on your local machine only**.
- Not sent to external servers (Phase 1 & 2 policy). The analysis engine has file read/write only (no internet calls).
- Data path: `~/.claude/plugins/business-counselor/data/`

### Legal disclaimer
This tool does **NOT** constitute: investment advisory (Korean Capital Markets Act Art. 6(5)) · business consulting · tax/legal advisory.
**All outputs are reference opinions only.** Consult qualified professionals (lawyers, accountants, financial advisors) before significant decisions.

### Known limitations (Phase 1)
- No external market research (live data) → Phase 3
- No auto idea generation (`/business-counselor:recommend`) → Phase 2
- Repeated-evaluation consistency score (`consistency_score`) not measured → Phase 2

---

## 📄 License

Apache License 2.0 · Copyright 2026 SoDam AI Studio

See the [LICENSE](./LICENSE) file for details.

---

🇰🇷 [한국어 README](./README.md) (primary) · Change history: [CHANGELOG.md](./CHANGELOG.md)
