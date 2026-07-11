# Workflow

```
        Epic / Ticket
             │
           hmb              🍺 Opening a tab...
             │
         hmb-crack          🍺 Cracking open a fresh specification...
             │
         hmb-sniff          👃 Sniffing the specification for bad hops...
             │
          hmb-brew          🍻 Brewing the perfect architecture...
             │
        hmb-ferment         🧪 Fermenting the plan to see if it holds pressure...
             │
          hmb-pour          🍺 Hold my beer... writing production code.
             │
       hmb-hangover         🤕 Checking tomorrow morning's hangover...
             │
           Merge
```

Each stage's output is the next stage's input. A **[BLOCKED]** or **[FAIL]** verdict from any review stage means go back one stage and fix the artifact — not skip forward with open issues.

## Stage by Stage

| Stage | Input | Output | Verdict |
|---|---|---|---|
| `hmb` | Target directory | `.holdmybeer/` workspace | — |
| `hmb-crack` | Epic / ticket / requirements | `.holdmybeer/spec.md` | — |
| `hmb-sniff` | `spec.md` | Findings report | [APPROVED] / [BLOCKED] |
| `hmb-brew` | Approved `spec.md` | `.holdmybeer/blueprint.md` | — |
| `hmb-ferment` | `blueprint.md` + `spec.md` | Findings report + coverage matrix | [APPROVED] / [BLOCKED] |
| `hmb-pour` | Approved `blueprint.md` | Production code + updated blueprint | — |
| `hmb-hangover` | `spec.md` + `blueprint.md` + implementation | AC trace + findings | [PASS] / [FAIL] |

**Note:** `hmb-ferment` needs **both** the blueprint and the spec — its requirement coverage matrix can't run against the plan alone.

## Example Run

```
/hmb
🍺 Opening a tab...
→ creates .holdmybeer/ workspace

/hmb-crack Add a "save for later" feature to the checkout flow (TICKET-482)
🍺 Cracking open a fresh specification...
→ produces .holdmybeer/spec.md

/hmb-sniff .holdmybeer/spec.md
👃 Sniffing the specification for bad hops...
→ findings + [APPROVED] (or [BLOCKED] with required fixes)

/hmb-brew .holdmybeer/spec.md
🍻 Brewing the perfect architecture...
→ produces .holdmybeer/blueprint.md

/hmb-ferment .holdmybeer/blueprint.md .holdmybeer/spec.md
🧪 Fermenting the plan to see if it holds pressure...
→ requirement coverage matrix + [APPROVED] (or [BLOCKED])

/hmb-pour .holdmybeer/blueprint.md
🍺 Hold my beer... writing production code.
→ writes production code, marks steps [x] as completed

/hmb-hangover .holdmybeer/spec.md .holdmybeer/blueprint.md src/checkout/
🤕 Checking tomorrow morning's hangover...
→ AC trace + [PASS] (or [FAIL] with issues list)
```

## Platform Notes

- **Claude Code**: Each stage is both an auto-discoverable SKILL.md and a thin slash command wrapper (`/hmb-crack`, etc.). Skills inherit from `shared/CONSTITUTION.md` and `shared/DSL.md`.
- **Gemini CLI**: Each stage is a self-contained `.toml` file under `~/.gemini/commands/` with the constitution inlined. Invoked explicitly by name.
- **Codex CLI**: Identical SKILL.md format as Claude — Codex decides when to invoke, or reference by name.
- **Cursor**: Description-matched `.mdc` rules under `.cursor/rules/` — reference in chat or let Cursor auto-attach. The least mature adapter (🚧) since Cursor rules aren't a direct slash-command mechanism.

## Shared Foundation

All skills inherit from:
- `shared/CONSTITUTION.md` — Engineering principles, code quality rules, naming, self-validation checklist
- `shared/DSL.md` — Symbolic pipeline operations, role definitions, flag dictionary
