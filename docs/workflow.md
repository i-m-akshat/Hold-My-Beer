# Workflow

```
   Workspace / Project Root
         │
    holdmybeer-init (Diagnostics & Initialization)
         │
        Epic
         │
    brew-spec        (HoldMyBeer: Spec Brewing)
         │
    sniff-spec        (HoldMyBeer: Spec Sniffing)
         │
    brew-plan         (HoldMyBeer: Plan Brewing)
         │
   stress-plan        (HoldMyBeer: Plan Stress-Testing)
         │
     hack-it          (HoldMyBeer: Implementation)
         │
     ship-it          (HoldMyBeer: Final Review)
         │
       Merge
```

Each stage's output is the next stage's input. A **BLOCKED** or **FAIL**
verdict from any review stage (`sniff-spec`, `stress-plan`, `ship-it`)
means go back one stage and fix the artifact there — not skip forward with
open issues.

## Stage by stage

| Stage | Input | Output | Verdict |
|---|---|---|---|
| `holdmybeer-init` | Optional target path | Diagnostics report or initialized `.specify/` templates | — |
| `brew-spec` | An epic, ticket, or feature request | A complete specification | — |
| `sniff-spec` | A drafted specification | Findings + verdict | APPROVED / BLOCKED |
| `brew-plan` | An approved specification | A phased implementation plan | — |
| `stress-plan` | The plan **and** its source spec | Findings + verdict | APPROVED / BLOCKED |
| `hack-it` | An approved plan + repo access | Code changes | — |
| `ship-it` | Spec + plan + implementation | Findings + verdict | PASS / FAIL |

Note that `stress-plan` needs **both** the plan and the specification it
implements — its highest-priority check (does every requirement map to a
step) can't run against the plan alone.

## Example run

```
holdmybeer-init:
→ checks for .specify/.gsd and offers template initialization

brew-spec: Add a "save for later" feature to the checkout flow, as described in TICKET-482.md
→ produces SPEC-save-for-later.md (specify.md)


sniff-spec: SPEC-save-for-later.md
→ returns findings + APPROVED (or BLOCKED with a list of blockers to resolve)

brew-plan: SPEC-save-for-later.md
→ produces PLAN-save-for-later.md

stress-plan: PLAN-save-for-later.md SPEC-save-for-later.md
→ returns findings + APPROVED (or BLOCKED)

hack-it: PLAN-save-for-later.md
→ writes the code

ship-it: SPEC-save-for-later.md PLAN-save-for-later.md src/checkout/
→ returns PASS (or FAIL with remaining issues)
```

## Platform notes

- **Claude Code**: each stage is both an auto-discoverable skill and a
  short slash command (`/brew-spec`, etc.) — use whichever fits; the
  command is just a convenience wrapper around the skill.
- **Gemini CLI**: each stage is a `.toml` command under
  `~/.gemini/commands/`, invoked the same way (`/brew-spec <input>`).
- **Codex CLI**: each stage is a skill under `~/.codex/skills/`, same
  `SKILL.md` format as Claude — Codex decides when to invoke it, or you
  can name it explicitly.
- **Cursor**: each stage is a description-matched rule under
  `.cursor/rules/` — reference it in chat or let Cursor auto-attach it
  when your request matches the rule's description. This is the least
  mature adapter (🚧) since Cursor rules aren't a direct request/response
  slash-command mechanism the way the others are.
