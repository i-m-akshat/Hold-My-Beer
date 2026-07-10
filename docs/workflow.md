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
| `holdmybeer-craft` | An epic, ticket, or feature request | A complete specification | — |
| `holdmybeer-audit` | A drafted specification | Findings + verdict | APPROVED / BLOCKED |
| `holdmybeer-design` | An approved specification | A phased implementation plan | — |
| `holdmybeer-stress` | The plan **and** its source spec | Findings + verdict | APPROVED / BLOCKED |
| `holdmybeer-code` | An approved plan + repo access | Code changes | — |
| `holdmybeer-ship` | Spec + plan + implementation | Findings + verdict | PASS / FAIL |

Note that `holdmybeer-stress` needs **both** the plan and the specification it
implements — its highest-priority check (does every requirement map to a
step) can't run against the plan alone.

## Example run

```
holdmybeer-init:
→ checks for .holdmybeer/.gsd and offers template initialization

holdmybeer-craft: Add a "save for later" feature to the checkout flow, as described in TICKET-482.md
→ produces SPEC-save-for-later.md (specify.md)


holdmybeer-audit: SPEC-save-for-later.md
→ returns findings + APPROVED (or BLOCKED with a list of blockers to resolve)

holdmybeer-design: SPEC-save-for-later.md
→ produces PLAN-save-for-later.md

holdmybeer-stress: PLAN-save-for-later.md SPEC-save-for-later.md
→ returns findings + APPROVED (or BLOCKED)

holdmybeer-code: PLAN-save-for-later.md
→ writes the code

holdmybeer-ship: SPEC-save-for-later.md PLAN-save-for-later.md src/checkout/
→ returns PASS (or FAIL with remaining issues)
```

## Platform notes

- **Claude Code**: each stage is both an auto-discoverable skill and a
  short slash command (`/holdmybeer-craft`, etc.) — use whichever fits; the
  command is just a convenience wrapper around the skill.
- **Gemini CLI**: each stage is a `.toml` command under
  `~/.gemini/commands/`, invoked the same way (`/holdmybeer-craft <input>`).
- **Codex CLI**: each stage is a skill under `~/.codex/skills/`, same
  `SKILL.md` format as Claude — Codex decides when to invoke it, or you
  can name it explicitly.
- **Cursor**: each stage is a description-matched rule under
  `.cursor/rules/` — reference it in chat or let Cursor auto-attach it
  when your request matches the rule's description. This is the least
  mature adapter (🚧) since Cursor rules aren't a direct request/response
  slash-command mechanism the way the others are.
