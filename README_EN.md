# AI Business Counselor (business-counselor)

> **Claude Code Plugin** · v0.6.5 · Phase 1 + Phase 2 (recommendations included) confirmed working in real use · Apache-2.0 (open source, commercial use allowed)
> Enter a business idea and AI instantly delivers a **5-stage cold analysis** from 13 expert perspectives.

**No coding required.** Even if you're still new to computers or smartphones, you can just follow along. Type commands in the Claude Code chat window — that's it.

> 🇺🇸 English · 🇰🇷 [한국어 README](./README.md) (primary) · 🖥 [View as HTML](./README_EN.html)

---

## Table of Contents

0. [Read This First](#read-me-first)
1. [What Is This? (Overview)](#overview)
2. [Prerequisites / Required Software](#prerequisites)
3. [Download](#download)
4. [Installation](#install)
5. [Quick Start (3 lines)](#quickstart)
6. [How to Run](#run)
7. [Usage Guide (step by step)](#usage)
8. [All Commands](#commands)
9. [How It Works (internals)](#how-it-works)
10. [Workflow (full diagram)](#workflow)
11. [File / Document Locations](#files)
12. [Architecture](#architecture)
13. [Security / Data Flow](#security)
14. [Update Summary](#changelog)
15. [Troubleshooting](#troubleshooting)
16. [FAQ](#faq)
17. [Legal / Copyright / License / Commercial Use](#legal)
18. [Appendix (Glossary)](#appendix)

---

<a id="read-me-first"></a>

## 0. Read This First

This document is written so that **anyone new to computers or AI tools** can follow it start to finish. Three things to know before you begin:

- **"Terminal"** = a text-based screen where you type commands instead of clicking icons. You'll get one when you install Claude Code.
- **"Command (slash command)"** = text starting with a slash (`/`), like `/business-counselor:evaluate`. You type it directly into the Claude Code **chat window** and press Enter. Note: the chat window, not the terminal.
- **"Plugin"** = an add-on that gives Claude Code a new capability. `business-counselor`, the subject of this document, is exactly that. Once installed, you get new commands starting with `/business-counselor:`.

If you get stuck, feel free to jump straight to [Troubleshooting](#troubleshooting) or the [FAQ](#faq).

---

<a id="overview"></a>

## 1. What Is This? (Overview)

When a business idea strikes, this tool makes **13 experts coldly assess "will this actually work?"**

- Alone, it's easy to fall into "this seems great!" self-confidence bias.
- This tool exposes weaknesses via **13 expert lenses (developer, security, legal, investor, …) + adversarial debate (pro vs con vs judge)**.
- The result is a one-line verdict: **go / iterate / no-go.**

It's not a separate app or website — it runs **inside Claude Code via commands**. All results are stored **on your local machine only** (zero external transmission).

### Key Features

A single input triggers a **one-call analysis** (no extra API calls — see [Security / Data Flow](#security)).

**Top "At-a-Glance Summary" card** (always shown) — verdict, confidence, strength, blocker, next action:

```
## At-a-Glance Summary
- Verdict: ⛔ no-go  ·  Confidence: 78/100
- Strength: ...
- Blocker: ...
- Next action: ...
```

Below it, the **5-stage detail** (only when you want it — see [Usage Guide](#usage)):

| Stage | Name | Description |
|-------|------|-------------|
| § 1 | **13-Persona Evaluation** | 13 experts (dev, security, legal, investor, …) score 1–5 + ⚠️ risk flags |
| §1 add-on | **🗣 Target Customer's Voice** | The actual paying customer's 1st-person reaction (would I buy, dealbreaker, alternative) |
| § 2 | **Lean Canvas** | Auto-generated 9-block business model (problem, customer, revenue, …) |
| § 3 | **Mom Test Questions** | 5 past-behavior-based customer interview questions |
| § 4 | **Pre-mortem** | Top 3 failure causes + probability + mitigation, assuming it already failed |
| § 5 | **Adversarial Debate** | Bull (pro) · Bear (con) · Judge (ruling) → go / iterate / no-go |

Who this is for: a **solo-use tool** for individual founders, side-hustlers, and side-project planners who want to stress-test a business idea. There is no team/multi-user feature (no shared accounts, no shared dashboard).

---

<a id="prerequisites"></a>

## 2. Prerequisites / Required Software

### Required Software

| Requirement | Purpose | Required? | Download |
|-------------|---------|:---:|----------|
| **Claude Code** | The program this plugin runs inside | **Required** | [claude.ai/download](https://claude.ai/download) |
| **Claude account** | To log into Claude Code (this plugin has no separate login) | **Required** | Prompted on first Claude Code launch |
| **Git** | Needed for [Installation](#install) methods A/B | Optional (Method C doesn't need it) | [git-scm.com/downloads](https://git-scm.com/downloads) |

### Before You Start

- **Operating system**: Windows and macOS are both supported. Linux is expected to work wherever Claude Code itself runs, but this project has not specifically tested it.
- **Internet**: Needed for install, and for Claude Code's own AI responses. Beyond that, this plugin does not separately transmit your data anywhere during interviews/evaluations.
- **Cost**: The plugin itself is free and open source. Any subscription/usage cost for Claude Code follows Claude Code's own pricing — this plugin adds no separate charge.
- **Sign-up / API key / payment**: Not required by this plugin. Only your existing Claude Code login is used.
- **Disk space**: The plugin's code is a few hundred KB of markdown files, and your accumulated data (interviews, evaluations) is plain text — negligible storage impact.

---

<a id="download"></a>

## 3. Download

"Downloading" (getting the code onto your machine) and "installing" (registering it with Claude Code so you can actually use it) are different steps. Of the three methods below, **Method A combines download and install into one step**; Methods B and C download first, then run one more install command.

| Method | How it downloads | Best for |
|--------|-------------------|----------|
| **A. Install directly from GitHub (Recommended)** | No separate download step — the registration command downloads it | Most users, especially first-timers |
| **B. Git clone** | `git clone` pulls down the full repository | Users who want to read or edit the code directly |
| **C. ZIP download** | Download a .zip from the GitHub web page | Users who don't want to install Git |

All three continue into [Installation](#install) below. GitHub repository address: `https://github.com/sodam-ai/business-counselor` (Public, accessible to anyone).

---

<a id="install"></a>

## 4. Installation

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

1. [GitHub page](https://github.com/sodam-ai/business-counselor) → green **Code** button → **Download ZIP**
2. Extract the ZIP
3. Rename the folder to **`business-counselor`** (remove `-main` if present)
4. Open a terminal where the folder is visible and run:

```bash
claude plugin marketplace add ./business-counselor
claude plugin install business-counselor@business-counselor-marketplace
claude plugin list
```

**Fully quit and relaunch Claude Code** after install to activate `/business-counselor:*` commands.

### How to Update

When a new version is released (see [Update Summary](#changelog)), run both commands in order:

```bash
claude plugin marketplace update business-counselor-marketplace
claude plugin update business-counselor@business-counselor-marketplace
```

> **Why two lines?** Updating only the marketplace metadata without updating the plugin itself will not bring in new behavior (confirmed by direct testing). Always run **both, in order**. Restart Claude Code afterward as well.

### How to Uninstall

To disable just the plugin:

```bash
claude plugin uninstall business-counselor@business-counselor-marketplace
```

To also remove the marketplace registration entirely:

```bash
claude plugin marketplace remove business-counselor-marketplace
```

> Exact option names may vary by your installed Claude Code version — run `claude plugin --help` to check the current command list. **Note**: uninstalling the plugin does **not** automatically delete your profile/evaluation history stored at `~/Documents/business-counselor/` — that data lives in a separate Documents folder, not inside the plugin folder (see [File / Document Locations](#files)). To remove your profile itself, use [`/business-counselor:edit`](#commands) or delete that folder directly.

---

<a id="quickstart"></a>

## 5. Quick Start (3 lines)

If [Claude Code](https://claude.ai/download) is already installed, in your terminal:

```bash
claude plugin marketplace add sodam-ai/business-counselor
claude plugin install business-counselor@business-counselor-marketplace
```

→ Restart Claude Code → type `/business-counselor:evaluate "my idea in one line"`. Done.

New to this? Follow the **[Installation](#install)** and **[Usage Guide](#usage)** below step by step.

---

<a id="run"></a>

## 6. How to Run

Once installed, here's how to actually try it.

1. **Open Claude Code.** Launch the desktop app, or type `claude` in a terminal (varies by setup — follow [claude.ai/download](https://claude.ai/download)).
2. **Confirm you see a chat window.** All commands go here from now on (not the terminal).
3. **Double-check install status** — not in the chat window, but back in the terminal, run `claude plugin list` and confirm `business-counselor` shows `enabled`.
4. **Type your first command.** In the chat window, type exactly:
   ```
   /business-counselor:help
   ```
   This command doesn't save or change anything — it just shows usage info — so it's the safest first thing to try.
5. If `/business-counselor:help` shows the command/glossary summary correctly, both installation and execution succeeded. Move on to [Usage Guide](#usage).

---

<a id="usage"></a>

## 7. Usage Guide (step by step)

### Step 1 — (Optional) Interview about you

```
/business-counselor:start
```

Answer ~12 questions (capital, time, skills, interests) in plain language (1–2 at a time, ~30–40 min). This personalizes future analyses. (You can skip and evaluate directly — it uses general criteria.)

If you paused mid-interview, continue with:

```
/business-counselor:resume
```

`resume` only re-asks the fields you **haven't answered yet** — it never re-asks fields you already filled in.

### Step 2 — (Optional) Edit or delete what you already answered

To **change the value** of an already-answered field, or clear it:

```
/business-counselor:edit "change my capital to 30 million KRW"
/business-counselor:edit "clear my domain interests"
```

To **delete your entire profile**:

```
/business-counselor:edit "delete my whole profile"
```

Full deletion is **irreversible.** The AI shows an irreversibility warning first, and nothing is actually deleted until you clearly confirm (e.g. "yes/delete"). Your past **idea evaluations are preserved** even after full profile deletion (only the profile itself is removed).

### Step 3 — Analyze an idea

```
/business-counselor:evaluate "an AI service that analyzes real estate listings"
```

Wrap the idea in **quotes (`"`)**. If the idea is too short or vague, AI asks 1–2 clarifying questions first. The result appears as a top **"At-a-Glance Summary" card**.

### Default (card) / Full (detail) mode

- **Default**: `/business-counselor:evaluate "idea"` → **summary card only** (fast, short — usually tens of seconds to a few minutes).
- **Full**: `/business-counselor:evaluate "idea" full` → **full §1–§5 detail** generated & saved (internally, default mode also reasons through all 5 stages — only the on-screen display differs, analysis depth is the same either way. Taking 5–8 minutes is normal).
- Re-view saved full analysis later: `/business-counselor:show <id>`

### Step 4 — Review past records

```
/business-counselor:list
```

Shows all past analyses with id, verdict, and confidence.

```
/business-counselor:show eval-2026-07-27-001
```

Use the real id shown in your `list` output. **Note**: the example id `eval-2026-07-27-001` in this document is a fictional placeholder for illustration — it does not actually exist, and typing it as-is will return "not found." Always copy an id that actually appears in your own `/business-counselor:list` output.

### Step 5 — (Optional) Let AI recommend ideas first

If you don't have an idea to bring and want the AI to propose some based on your profile:

```
/business-counselor:recommend 5
```

Recommends 5 ideas (default, adjustable 1–10) based on your profile, each with a Lean Canvas. You can
deep-evaluate a favorite with `/business-counselor:evaluate`, or record a decision directly:

```
/business-counselor:decide idea-2026-08-02-001 go "starting with customer interviews"
```

`<id>` can be either `eval-*` (evaluation) or `idea-*` (recommendation), and `<action>` is one of
`go`/`drop`/`iterate`/`defer`. Decisions accumulate append-only in `decisions.jsonl`, viewable later via
`/business-counselor:show <id>`.

### If you get stuck

```
/business-counselor:help
```

Shows all commands, the recommended flow, and a glossary on one screen. Feel free to run this any time.

---

<a id="commands"></a>

## 8. All Commands

| Command | Description | Changes data? |
|---------|--------------|:---:|
| `/business-counselor:help` | Usage, commands & glossary on one screen | No |
| `/business-counselor:start` | Start the AI interview about you (first time) | Creates profile.md |
| `/business-counselor:resume` | Continue the interview (fill missing info only) | Updates profile.md |
| `/business-counselor:edit "request"` | Change or clear an already-answered field, or delete the whole profile (confirmation required) | Changes/deletes profile.md |
| `/business-counselor:evaluate "idea"` | Analyze — default is the summary card | Creates an evaluation file |
| `/business-counselor:evaluate "idea" full` | Analyze — full §1–§5 detail shown on screen | Creates an evaluation file |
| `/business-counselor:recommend [N]` | Recommend N ideas (default 5) based on your profile, each with a Lean Canvas | Creates recommendation file(s) |
| `/business-counselor:decide <id> <action>` | Record a decision (go/drop/iterate/defer) on an evaluation or recommendation | Appends to decisions.jsonl |
| `/business-counselor:list` | List past analyses & recommendations (id · verdict · confidence) | No |
| `/business-counselor:show <id>` | Re-view a specific analysis or recommendation | No |

> Stuck? Type `/business-counselor:help` first.

---

<a id="how-it-works"></a>

## 9. How It Works (internals)

- **Single-call principle**: one `/business-counselor:evaluate` call = one call to the internal subagent (`bc-idea-evaluator`), and one `/business-counselor:recommend` call = one call to the internal subagent (`bc-idea-generator`). All 5 stages (13-persona review, Lean Canvas, Mom Test, Pre-mortem, adversarial debate) — or, for recommendations, N ideas with Lean Canvas each — run **inside that single call**. No repeated per-response subagent calls, which keeps it fast and cost-efficient.
- **Profile snapshot fingerprint**: every evaluation/recommendation output file stores a value (`profile_snapshot_hash`) that lets you tell which version of your profile it was based on. This value is **actually computed at the command-orchestration step, right before calling the subagent** — not by the subagent itself, since the subagent has no way to run a real computation (confirmed in v0.6.5 and fixed to work this way).
- **Cold mode**: this tool is deliberately designed to block "this seems great!" positivity bias. If the legal (#11) or investor (#13) persona flags a strong negative signal, the final verdict is forced toward `iterate` or `no-go` even if other scores are high.
- **Handling vague input**: if the idea is too short or unclear, the AI does not silently guess — it asks 1–2 clarifying questions first.
- **Profile personalization**: if you've answered the `/business-counselor:start`/`resume` interview, the evaluation is tailored to your actual capital, time, and skills. Evaluation still works without a profile (general criteria apply).
- **Anti-hallucination rule**: market-size figures or statistics without a clear source are designed to be explicitly labeled "(estimated, unverified)." This is a design principle for response quality, not a guarantee of zero errors — always verify independently before an important decision.

---

<a id="workflow"></a>

## 10. Workflow (full diagram)

```
[once]   /business-counselor:start  →  answer interview  →  save your profile (profile.md)
                                  │
                     (edit anytime with /business-counselor:edit)
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

### Second flow — AI recommends ideas first (Phase 2)

```
/business-counselor:recommend [N]  (needs a profile, default 5)
            │
            ▼
        AI generates N profile-based ideas + a Lean Canvas each, in one call
            │
            ▼
        Screen: table (ID · title · fit score)   Saved: recommendation file (.md, ideas/generated/)
            │
            ├─ Want to dig deeper on one → /business-counselor:evaluate "<title>"
            └─ Want to record a decision → /business-counselor:decide <id> <go|drop|iterate|defer> ["note"]
                                              │
                                              ▼
                                    1 line appended to decisions.jsonl (append-only, never edited/deleted)

/business-counselor:list  →  two tables: evaluation history + recommendation history, at a glance
/business-counselor:show <id>  →  works for both eval-* and idea-* IDs
```

---

<a id="files"></a>

## 11. File / Document Locations

**Plugin folder** (where you installed — code/config, no need to edit directly):
```
business-counselor/
├── plugin.json          ← Plugin manifest
├── CLAUDE.md            ← AI behavior rules
├── AGENTS.md            ← AI agent entry point
├── CHANGELOG.md         ← Full change history (all versions, detailed)
├── LICENSE              ← Full license text (Apache-2.0)
├── commands/            ← 9 commands (start·resume·edit·evaluate·recommend·decide·list·show·help)
├── skills/               ← analysis skills (13-personas·lean-canvas·mom-test·adversarial-debate·goal-driven·pre-mortem)
├── agents/               ← bc-idea-evaluator (evaluate) · bc-idea-generator (recommend) — 2 core engines
├── templates/            ← output templates
├── tests/                ← linters & scenarios
└── PRD/                  ← planning docs (01_PRD·02_DATA_MODEL·03_PHASES·04_PROJECT_SPEC)
```

**Your data** (auto-created after install, stored **on your local machine only**):
```
~/Documents/business-counselor/
├── profile.md            ← Your profile (interview result)
├── sessions/              ← Interview logs (one file per session)
├── ideas/evaluated/       ← Idea analysis results (one file per evaluation)
├── ideas/generated/       ← AI-recommended ideas (one file per idea)
└── decisions.jsonl        ← go/drop/iterate/defer decision log (append-only)
```
> `~` is your home folder. On Windows it's usually `C:\Users\(you)\Documents\business-counselor\`. On macOS it's `/Users/(you)/Documents/business-counselor/`. You can open this folder directly in File Explorer (Windows) or Finder (macOS) — every file is plain text (.md).

**Why `Documents` instead of the `.claude/` folder?** Data was originally stored inside the plugin's install folder (`~/.claude/plugins/...`), but real-world use revealed that the entire `~/.claude/` folder is protected as a "system configuration area," blocking the AI from writing new files there. To preserve the original goal — that a person can easily find and open their own data in File Explorer — the data was moved to the unprotected `Documents` folder (v0.4.0; see [Update Summary](#changelog) for details).

---

<a id="architecture"></a>

## 12. Architecture

This plugin has **no separate server or database.** Everything runs on plain text files (Markdown) plus the single Claude Code program.

```
User (typing in the Claude Code chat window)
        │  natural-language commands/answers
        ▼
Claude Code (host program — uses the user's own login and model calls)
        │  plugin routing: /business-counselor:<command filename>
        ▼
commands/*.md  (9 command definitions — documents describing each command's behavior)
        │
        ├─ start·resume·edit  →  read/write profile.md directly
        ├─ list·show·decide    →  read/append saved evaluation, recommendation & decision files
        ├─ evaluate             →  delegated to bc-idea-evaluator
        └─ recommend            →  delegated to bc-idea-generator
                    │
                    ▼
        agents/bc-idea-evaluator.md · bc-idea-generator.md  (2 isolated subagents, each single-call)
        Tool permissions: both Read · Write · Glob **only**
        (No Task/WebFetch/WebSearch permission at all →
         neither external internet calls nor extra subagent calls
         are "blocked by policy" — the tools simply don't exist)
                    │
                    ▼
        References 6 skills/*.md files — analysis methodology knowledge (13-personas, pre-mortem, etc.)
                    │
                    ▼
        Saves results as text files (~/Documents/business-counselor/)
                    │
                    ▼
        Displays the "At-a-Glance Summary" card on screen
```

**Tech stack summary**

| Component | Format | Notes |
|-----------|--------|-------|
| Plugin manifest | `plugin.json` (Claude Code native format) | No separate build/compile step |
| Commands | `commands/*.md` (Markdown) | Instructions to the AI, not executable code |
| Knowledge/methodology | `skills/*.md` (Open Agent Skills standard) | Defines the 5 analysis frameworks |
| Execution engine | `agents/bc-idea-evaluator.md` (subagent) | Restricted tool permissions enforce single-call + external blocking |
| Data storage | Markdown + YAML frontmatter | No database (no SQLite/Postgres etc.) |
| Authentication | None (reuses Claude Code's own login) | No separate sign-up/API key needed |

---

<a id="security"></a>

## 13. Security / Data Flow

### Where your data goes (at a glance)

```
[Your input: idea · profile answers]
        │
        ▼
Claude Code (runs locally, your own account login) ── talks to the Anthropic model only to generate AI responses
        │
        ▼
bc-idea-evaluator subagent (runs locally, Read/Write/Glob permissions only)
        │
        ├─ Separately transmitted externally: nothing (Phase 1·2 policy — this plugin's
        │   code is never given an internet-calling tool in the first place)
        │
        └─ What stays on your machine (all plain text files):
             ~/Documents/business-counselor/profile.md
             ~/Documents/business-counselor/sessions/*.md
             ~/Documents/business-counselor/ideas/evaluated/*.md
```

### Security design principles

- **Local-only storage**: your profile and evaluation results live only in `~/Documents/business-counselor/` on your machine. Nothing is backed up or synced to a separate cloud server (unless you personally place that folder inside your own cloud-sync folder).
- **Runtime-enforced external blocking**: "we don't send it externally" is not just a promise written in a prompt — it's implemented by giving the analysis subagent (`bc-idea-evaluator`) **only Read/Write/Glob tools**, with no internet-capable tools (WebFetch/WebSearch) and no extra-call tool (Task) at all. Even if the AI "wanted to" break the rule, it physically cannot — the tools don't exist for it to use.
- **Minimal PII collection**: the interview only asks about birth year, residence (city/province level), family status, capital/monthly income, available time, skills, domain interests, and risk appetite. Sensitive identifiers like national ID numbers or bank account numbers are never part of the question set.
- **No telemetry**: this plugin itself has no executable code — it's a markdown/prompt specification — and does not send usage data to any separate analytics or logging server. The only network communication is Claude Code's own model calls (needed to generate any AI response), which is Claude Code's own behavior, not something this plugin adds.
- **Phase 3 exception (planned, not implemented)**: a future external market-research feature (`research` command) would need internet search. Even then, the plan is for it to be **disabled by default**, activating only when the user explicitly types that command — but this does not exist in the current version.

### Deletion and backup

- To delete your profile: `/business-counselor:edit "delete my whole profile"` (with confirmation) or delete `~/Documents/business-counselor/profile.md` directly.
- This plugin has no automatic backup feature. If you want to preserve your data, manually copy the `~/Documents/business-counselor/` folder yourself.
- Uninstalling the plugin leaves this data folder untouched (see the "Uninstall" section under [Installation](#install)).

---

<a id="changelog"></a>

## 14. Update Summary

Below is a condensed summary. The full original text (with root-cause analysis) lives in [`CHANGELOG.md`](./CHANGELOG.md). Click each entry to expand.

<details>
<summary><strong>v0.6.5</strong> — 2026-08-04 · Fixed fake <code>profile_snapshot_hash</code> value + linter false-positive fix</summary>

- Found and fixed a defect where `profile_snapshot_hash` in recommendation/evaluation output files was not a real SHA-256 computation but a string the AI made up — the value is now actually computed by the calling command and passed in
- Also fixed a false-positive in the verification tool (frontmatter linter), which was requiring the same set of fields for recommendation and evaluation outputs even though they intentionally differ
- No feature change (internal correctness fix)

</details>

<details>
<summary><strong>v0.6.4</strong> — 2026-08-03 · Fixed <code>list</code>/<code>show</code> missing generated ideas + first confirmed real-world success of <code>recommend</code></summary>

- `list`/`show` previously only found evaluation results (`evaluated/`) and missed generated ideas (`generated/`) — fixed to find both
- `/business-counselor:recommend` was confirmed working for the first time in real user usage, validating the earlier install-sync fixes

</details>

<details>
<summary><strong>v0.6.3</strong> — 2026-08-03 · Re-investigated install-sync root cause + fixed special-character defect in idea descriptions</summary>

- The diagnosis from v0.6.2 turned out to be incomplete — the real root cause was that the install manager's version pointer wasn't being promoted (full detail in v0.6.2 below and in `CHANGELOG.md`)
- Fixed 2 defects (in both evaluation and recommendation output) where a double quote in the idea description could corrupt the saved file

</details>

<details>
<summary><strong>v0.6.2</strong> — 2026-08-03 · Boundary-value input review + first discovery of install-sync issue</summary>

- Fixed 2 boundary-value defects: a `decide` note with special characters could corrupt the record file; ambiguous validation of the recommendation count input
- First discovered, during real usage, that "updated but new commands don't show up" was actually an install-file sync issue

</details>

<details>
<summary><strong>v0.6.1</strong> — 2026-08-03 · Full doc-vs-implementation audit + fixed 5 docs that hadn't caught up to Phase 2</summary>

- Phase 2 (recommendation feature) code already existed, but `help` and README still told users "no recommendation feature" in 5 places — found and fixed

</details>

<details>
<summary><strong>v0.6.0</strong> — 2026-08-02 · Phase 2 (recommendations + decision logging) officially activated</summary>

- `/business-counselor:recommend` and `/business-counselor:decide` commands, plus a second analysis engine (`bc-idea-generator`), officially activated
- Commands expanded from 7 to 9

</details>

<details>
<summary><strong>v0.5.2</strong> — 2026-07-27 · New comprehensive beginner-friendly README (KR/EN, md+html)</summary>

- README fully rewritten as a comprehensive guide covering TOC, install, prerequisites, download, quick start, run/usage/how-it-works, commands, architecture, security, troubleshooting, FAQ, and legal/license
- Provided in both Korean (README.md) and English (README_EN.md), each in both md and html format (4 files total), with matching content
- No functional changes (documentation-only release)

</details>

<details>
<summary><strong>v0.5.1</strong> — 2026-07-27 · Fixed 3 doc-vs-implementation mismatches found during verification</summary>

- Corrected `risk_appetite` documentation to match the actual implementation values (`low`/`medium`/`high`)
- Corrected `capital_krw`/`monthly_income_krw` unit documentation to match actual storage (raw KRW integers)
- Fixed stale command-count comment in README file trees (6 → 7)
- Added a rule so `resume` redirects users to `edit` when they try to spontaneously correct an already-filled field

</details>

<details>
<summary><strong>v0.5.0</strong> — 2026-07-27 · New <code>/business-counselor:edit</code> command</summary>

- Added the ability to change, clear, or fully delete already-answered profile fields
- Full deletion requires an irreversibility warning + explicit confirmation; evaluation history (`ideas/evaluated/`) is preserved separately
- System-managed fields (id, schema_version, last_updated, profile_updates, disclaimer) are excluded from editing
- Commands expanded from 6 to 7

</details>

<details>
<summary><strong>v0.4.0</strong> — 2026-07-27 · Moved data storage outside <code>~/.claude/</code></summary>

- Confirmed by direct testing that the entire `~/.claude/` folder is protected against AI writes → moved data storage to `~/Documents/business-counselor/`
- Migrated 3 existing real evaluation records to the new location with zero data loss (byte-identical verification)
- Synchronized all related documentation (2 READMEs, 4 PRD docs, 6 commands, etc.) to the new path

</details>

<details>
<summary><strong>v0.3.0</strong> — 2026-07-27 · Simplified command names (removed <code>counsel-</code> prefix)</summary>

- Simplified all 6 commands, e.g. `/business-counselor:counsel-evaluate` → `/business-counselor:evaluate`
- Removed the redundant prefix since the plugin name itself already acts as the namespace

</details>

<details>
<summary><strong>v0.2.0 – v0.2.2</strong> — 2026-06-15 – 2026-07-27 · Usability improvements + fixes found during real E2E testing</summary>

- Added the "At-a-Glance Summary" card, the `/business-counselor:help` command, and the "Target Customer's Voice" add-on
- Introduced a 2-tier output mode: default (card) vs. full (detail)
- Fixed a command-namespace documentation error found in real use (a form that had never actually worked)
- Improved marketplace registration to support direct GitHub registration

</details>

<details>
<summary><strong>v0.1.0 – v0.1.1</strong> — 2026-05-08 – 2026-06-15 · Initial Phase 1 implementation + stabilization</summary>

- First implementation of the plugin skeleton, 5 commands, 5 skills, 1 subagent
- Fixed 6 consistency defects including linter over-validation and a numbering collision bug
- Added a Windows-native PowerShell linter

</details>

> How to read version numbers: `MAJOR.MINOR.PATCH` format, where a minor bump means a new feature was added and a patch bump means a fix with no new feature (loosely follows Semantic Versioning conventions, not strictly enforced).

---

<a id="troubleshooting"></a>

## 15. Troubleshooting

| Symptom | Cause | Fix |
|---------|-------|-----|
| `/business-counselor:*` commands not showing | Not restarted after install | **Fully quit and relaunch Claude Code** |
| `plugin list` shows no enabled | Missing register/install | Re-run `marketplace add sodam-ai/business-counselor` → `install ...@business-counselor-marketplace` |
| `claude: command not found` | Claude Code missing/path issue | Install from [claude.ai/download](https://claude.ai/download), restart |
| `git: command not found` | Git missing | Install [git-scm.com](https://git-scm.com/downloads) or use the [ZIP method (C)](#download) |
| Updated but new commands still missing | Only ran one of the two update commands, or didn't restart, or Claude Code's internal cache didn't refresh (this has happened in real usage) | Run both lines under [How to Update](#install) + a **full** restart (not just closing a window) + check in a **brand-new chat**. If it still doesn't show up, this may be a cache-sync issue — please report it at [GitHub Issues](https://github.com/sodam-ai/business-counselor/issues) |
| Evaluation takes 5–8 min | Deep analysis is naturally slow | Normal. Wait it out, or run it when you have time to spare |
| Result is just a short card | Default is card mode | Full: `/business-counselor:evaluate "..." full` or `/business-counselor:show <id>` |
| `show` says "not found" | You typed an id that doesn't exist (including this doc's example id) | Check your real id with `/business-counselor:list` first, then copy it in |
| Evaluated without a profile | Interview skipped | Uses general criteria. For tailored results, run `/business-counselor:start` first |
| A field I cleared with `edit` seems unchanged | You didn't confirm "yes," or you cancelled | Re-run `/business-counselor:edit` with a clearer request, and respond clearly to the confirmation prompt |
| I accidentally deleted my entire profile | The confirmation flow completed and it was really deleted | This cannot be undone. Start a fresh interview with `/business-counselor:start`. Your past idea evaluations are not deleted and remain intact |
| Errors like `uv: command not found` from another tool | **Unrelated to this plugin** | Ignore (another tool's notice) |

> For anything not listed here, type `/business-counselor:help` to check current usage, or file an issue at [GitHub Issues](https://github.com/sodam-ai/business-counselor/issues).

---

<a id="faq"></a>

## 16. FAQ

**Q. Is this tool paid?**
A. The plugin itself is free and open source (Apache-2.0). Whatever cost Claude Code itself requires follows Claude Code's own pricing; this plugin adds no separate charge.

**Q. Does my business idea or financial information leak out anywhere?**
A. No. As explained in [Security / Data Flow](#security), Phase 1·2 (the current version) has no code-level capability to transmit data externally on its own. What you type exists only in Claude Code's normal AI response process (same as any Claude Code conversation) and in local files on your machine.

**Q. Can I trust the AI's evaluation 100%?**
A. No. This tool provides a **reference opinion**, not a guarantee of business success. For anything requiring legal, investment, or tax judgment, always consult a qualified professional. See [Legal / Copyright / License / Commercial Use](#legal) for details.

**Q. Does the AI pick business ideas for me automatically?**
A. Yes. Use `/business-counselor:recommend` to get AI-picked ideas based on your profile (Phase 2, v0.6.0+). You can still bring your own idea with `/business-counselor:evaluate` — both paths are supported.

**Q. Can I use this without internet?**
A. No. Claude Code itself needs to talk to the AI model to generate any response, so an internet connection is required. That said, this plugin itself does not separately search external websites or transmit your data.

**Q. If I move to a different computer, does my data come with me?**
A. Not automatically. Your data lives in `~/Documents/business-counselor/`, so copy that folder yourself and paste it into the same location on the new machine to continue where you left off.

**Q. Can I recover a deleted profile or evaluation?**
A. This plugin has no recovery feature (no trash/undo). Full deletion via `/business-counselor:edit` goes through a confirmation step, but once confirmed, it cannot be undone. Back up the folder yourself beforehand if you want a safety net.

**Q. Is this tool legal advice or investment advice?**
A. No. As stated in [Legal / Copyright / License / Commercial Use](#legal), it is a reference-opinion tool and does not constitute investment advisory, business consulting, tax advisory, or legal advisory services.

**Q. Can I evaluate multiple ideas at once?**
A. Evaluations run one at a time, in sequence. Run `/business-counselor:evaluate` once per idea; each is saved as a separate file and all appear together under `/business-counselor:list`.

**Q. Can I use the evaluation results (the analysis text) elsewhere, including commercially?**
A. Yes. The analysis is your own material, generated from the idea you entered — this tool claims no ownership over that output. However, its accuracy is not guaranteed, so verify independently before relying on it for an important commercial decision. See [Legal / Copyright / License / Commercial Use](#legal) for details.

**Q. Can I use this plugin's source code itself in my own product?**
A. Yes — under the Apache License 2.0, you may use, modify, and distribute it, including commercially, subject to a few conditions (include a copy of the license, mark changed files, etc.). See [Legal / Copyright / License / Commercial Use](#legal) and the [`LICENSE`](./LICENSE) text.

**Q. Where do I report a bug or unexpected behavior?**
A. File an issue at the [GitHub repository](https://github.com/sodam-ai/business-counselor)'s Issues page.

---

<a id="legal"></a>

## 17. Legal / Copyright / License / Commercial Use

### 17.0 Plain-Language Summary (details in 17.1–17.6 below)

- ✅ **What you can do**: use the code as-is or modified in your own product, copy/fork it, redistribute it, sell it or run it as a paid service, and use its analysis output in business plans, teaching material, or client deliverables — all **allowed**, as long as you follow the Apache-2.0 conditions.
- 🔍 **What you must check yourself**: whether the analysis/recommendation output is actually accurate, whether it accidentally overlaps with an existing company/product name, and what Claude Code's own pricing/terms are — this project does not guarantee any of that for you, so **you** need to check.
- ⛔ **What you should not do (or is risky)**: presenting this tool's analysis as real investment, legal, or tax advice; using the "SoDam AI Studio" / "business-counselor" names as if they implied an official partnership or endorsement.

> The following is general information, not legal advice. For actual commercial use, redistribution, or legal decisions, consulting a qualified professional (e.g. a lawyer) is recommended.

### 17.1 License for this software (the plugin code)

This plugin (`business-counselor`) is distributed under the **Apache License 2.0**.

- **Copyright holder**: Copyright 2026 SoDam AI Studio
- **Full license text**: [`LICENSE`](./LICENSE) (standard Apache-2.0 text)
- **What's permitted** (summary — the license text governs):
  - Commercial use (bundling into a product, selling, running as a SaaS, etc.)
  - Modification
  - Distribution / redistribution
  - Patent license grant (including from contributors)
  - Private use
- **Conditions**:
  - You must include a copy of the license and the copyright notice when you distribute it.
  - Modified files must carry a notice stating that you changed them.
  - If a `NOTICE` file exists, its contents must be included when redistributing.
- **NOTICE file**: this repository does **not** include a separate `NOTICE` file. Apache-2.0 §4(d) requires
  passing one along only if the original work included one; this project is an original work from the start,
  not a fork/modification of another Apache-2.0 project, so we assessed that condition as not applicable
  (checked 2026-08-04). *This assessment is not a legal conclusion — if you plan to redistribute or use this
  commercially, please re-verify whether a NOTICE is needed, or consult legal counsel —
  [needs legal/expert review].*
- **What is NOT provided**:
  - **No warranty ("AS IS")**: the software is provided without any warranty, including merchantability or fitness for a particular purpose.
  - **Limitation of liability**: contributors are not liable for damages arising from use of the software, except as required by law.
  - **No trademark grant**: this license does not grant rights to use the "SoDam AI Studio" or "business-counselor" names/marks (customary attribution use is excepted).

### 17.2 About the output this tool produces (the analysis text)

- Evaluation results (§1–§5 analysis, the "At-a-Glance Summary" card, etc.) are **your own material, generated from the business idea you personally entered**. This project (SoDam AI Studio) claims no ownership over, and places no usage restriction on, that output.
- However, the output's **accuracy, completeness, and currency are not guaranteed.** Verify the facts independently before using it in a commercial decision, an investor pitch, or a business plan.
- Market-size figures or statistics in the output may be AI-generated estimates; figures without a clear source are designed to be labeled "(estimated, unverified)," but this labeling is not guaranteed to be perfect.
- **Duty to review AI-generated content**: this tool's output (§1–§5 analysis, Lean Canvas, recommended-idea
  titles/descriptions, etc.) is AI-generated content. **Before actually sharing it externally or using it
  commercially** — e.g. in a business plan, investor materials, or a client deliverable — please verify
  yourself: (1) that no real company/product/trademark name was accidentally included, (2) that it isn't
  suspiciously close to an existing business model, brand, or copyrighted work, and (3) that any statistics
  come from a genuinely reliable source. This project does not warrant that AI-generated output is free of
  third-party copyright or trademark infringement. [Needs legal/expert review — copyright ownership and
  infringement determinations for AI-generated content vary by jurisdiction and case law.]

### 17.3 Disclaimer of legal character (what this tool is NOT)

This tool does **NOT** constitute:

- **Investment advisory services** (Korean Financial Investment Services and Capital Markets Act, Article 6(5)) or **discretionary investment management** (same Act, Article 17)
- Business consulting services
- Tax advisory
- Legal advisory

**All analysis output is a reference opinion.** It does not recommend any specific security, financial product, or investment product, and does not guarantee business success or profit. Before making an important decision, consulting a qualified professional (lawyer, tax accountant, financial advisor, etc.) is recommended. All profit, loss, and legal responsibility arising from decisions made using this tool rest solely with the user; the tool's creator bears no responsibility.

### 17.4 Privacy / data

- See [Security / Data Flow](#security) for how data is handled.
- This tool does not separately collect, sell, or share personal data with third parties (local storage only).
- Interview questions do not include sensitive unique identifiers (e.g. national ID or bank account numbers), but be careful not to voluntarily type sensitive personal information into the free-text answer fields yourself.

### 17.5 Commercial use summary

| Item | Commercial use allowed? | Notes |
|------|:---:|-------|
| Embedding the plugin code, as-is or modified, into your own product/service | Yes | Subject to Apache-2.0 conditions (license notice, marking changes) |
| Copying/forking the code (including a GitHub Fork) | Yes | Explicitly permitted by Apache-2.0. Recommended to avoid naming your fork in a way that could be confused with the original project |
| Using this tool's business analysis output in a business plan or investor pitch | Yes | No accuracy guarantee — independent verification required (see "Duty to review AI-generated content" in §17.2) |
| Reselling this tool, or running it as a paid SaaS | Yes | Apache-2.0 does not prohibit resale or running it as a service. However, presenting it as if officially affiliated with or endorsed by "SoDam AI Studio"/"business-counselor" is not recommended |
| Using this tool (code or output) as teaching/course material | Yes | Subject to Apache-2.0 conditions (license notice). Recommended to disclose that output used as course material is AI-generated |
| Delivering this tool's analysis output to a company/client as a deliverable | Yes | Ownership of the output belongs to the user (§17.2). Since accuracy/completeness is not guaranteed, independent verification before delivery and disclosing to the client that it is "AI-generated, for reference" is recommended |
| Offering this tool's analysis as actual investment or legal advisory services | **Not recommended / risky** | See §17.3 — this may require separate licensing/qualification |

### 17.6 External service terms you must check separately

This plugin itself does not charge anything (see §2), but **using Claude Code / the Claude model itself is
governed by Anthropic's own terms of service, usage policy, and pricing.** This project (SoDam AI Studio)
does not guarantee or summarize Anthropic's terms on your behalf — you need to check the following directly
through Anthropic's official channels (the terms presented during Claude Code setup/login, or
[anthropic.com](https://www.anthropic.com)):

- Your Claude Code / Claude account's pricing plan and usage limits
- Claude's model Usage Policy — in particular, whether Anthropic places any conditions on commercially
  redistributing or reselling model output, if you plan to do that with this tool's results
- Data retention / training-use policy (this applies broadly to anything you type into Claude Code, is
  Anthropic's own policy, and is not something this plugin separately controls)

This plugin does not bundle any external media assets — images, fonts, icons, video, or audio (confirmed by
a full repository scan on 2026-08-04: zero files under `assets`/`public` or with image/font extensions). So,
as of the current version, there is no separate font/image license to check. If images or fonts are added in
the future, their licenses will need to be reviewed separately at that time.

---

<a id="appendix"></a>

## 18. Appendix (Glossary)

| Term | Meaning |
|------|---------|
| Claude Code | Anthropic's program for working with AI via a terminal/chat window. The "host" this plugin runs inside. |
| Plugin | An add-on that gives Claude Code a new capability. `business-counselor` is the name of this plugin. |
| Slash command | A command starting with `/`, like `/business-counselor:evaluate`, typed into the Claude Code chat window. |
| Marketplace | A registry concept for publishing/distributing plugins. Registered via `claude plugin marketplace add`. |
| Subagent | An internal AI execution unit dedicated to one task (here, idea analysis) with restricted tool permissions. |
| Profile (profile.md) | The file where your accumulated interview answers about yourself are stored. |
| Verdict | The final conclusion of an evaluation: one of go / iterate / no-go. |
| Lean Canvas | A well-known planning tool that summarizes a business model into 9 blocks (problem, customer, revenue structure, etc.). |
| Mom Test | An interview technique that avoids "questions your mom would always say yes to," instead validating real demand through past-behavior-based questions. |
| Pre-mortem | The opposite of a "post-mortem" (analyzing causes after the fact) — you assume the project has already failed and work backward to find the causes in advance. |
| Frontmatter | A standard way of writing structured metadata (title, date, version, etc.) at the top of a markdown file, wrapped in `---`. |

---

## License Summary

Apache License 2.0 · Copyright 2026 SoDam AI Studio · Full text: [LICENSE](./LICENSE) · Commercial-use terms: [§17](#legal).

---

🇰🇷 [한국어 README](./README.md) (primary) · 🖥 [HTML version](./README_EN.html) · Full change history: [CHANGELOG.md](./CHANGELOG.md) · Contact: [GitHub Issues](https://github.com/sodam-ai/business-counselor/issues)
