# Workflow

```
   Workspace / Project Root
         │
    holdmybeer-init (Diagnostics & Initialization)
         │
        Epic
         │
    holdmybeer-craft        (HoldMyBeer: Spec Brewing)
         │
    holdmybeer-audit        (HoldMyBeer: Spec Sniffing)
         │
    holdmybeer-design         (HoldMyBeer: Plan Brewing)
         │
   holdmybeer-stress        (HoldMyBeer: Plan Stress-Testing)
         │
     holdmybeer-code          (HoldMyBeer: Implementation)
         │
     holdmybeer-ship          (HoldMyBeer: Final Review)
         │
       Merge
```

Each stage's output is the next stage's input. A **BLOCKED** or **FAIL**
verdict from any review stage (`holdmybeer-audit`, `holdmybeer-stress`, `holdmybeer-ship`)
means go back one stage and fix the artifact there — not skip forward with
open issues.

## Stage by stage

| Stage | Input | Output | Verdict |
|---|---|---|---|
| `holdmybeer-init` | Optional target path | Diagnostics report or initialized `.holdmybeer/` templates | — |
| `holdmybeer-spec` | An epic, ticket, or feature request | A complete specification (`spec.md`) | APPROVED / BLOCKED |
| `holdmybeer-plan` | An approved specification | A phased roadmap and tasks checklist (`blueprint.md`) | APPROVED / BLOCKED |
| `holdmybeer-code` | An approved blueprint + repo access | Code changes | — |
| `holdmybeer-review` | Spec + blueprint + implementation | Findings + verdict | PASS / FAIL |

---

## Example run

```
holdmybeer-init:
→ checks for .holdmybeer/.gsd and offers template initialization

holdmybeer-spec: Add a "save for later" feature to the checkout flow, as described in TICKET-482.md
→ produces spec.md after self-audit validation (verdict: APPROVED)

holdmybeer-plan: .holdmybeer/spec.md
→ produces blueprint.md after stress-test validation (verdict: APPROVED)

holdmybeer-code: .holdmybeer/blueprint.md
→ writes the code step-by-step running verification commands

holdmybeer-review: .holdmybeer/spec.md .holdmybeer/blueprint.md
→ returns PASS (or FAIL with remaining issues)
```

## Platform notes

- **Claude Code**: each stage is both an auto-discoverable skill and a
  short slash command (`/holdmybeer-spec`, etc.) — use whichever fits; the
  command is just a convenience wrapper around the skill.
- **Gemini CLI**: each stage is a `.toml` command under
  `~/.gemini/commands/`, invoked the same way (`/holdmybeer-spec <input>`).
- **Codex CLI**: each stage is a skill under `~/.codex/skills/`, same
  `SKILL.md` format as Claude — Codex decides when to invoke it, or you
  can name it explicitly.
- **Cursor**: each stage is a description-matched rule under
  `.cursor/rules/` — reference it in chat or let Cursor auto-attach it
  when your request matches the rule's description.

