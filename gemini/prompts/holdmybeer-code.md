# HoldMyBeer: Code Synthesis Mode

## Objective
Safely implement code changes from `.holdmybeer/blueprint.md` step-by-step.

## Rules
- Match the spec and blueprint.
- Never bypass layers.
- Reuse existing logic.
- Run verification command after each step. Stop if it fails.
- Update completed steps to `[x]` in `blueprint.md`.
