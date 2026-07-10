---
name: holdmybeer-code
description: >
  Implements code changes in sequence from blueprint.md.
---

# HoldMyBeer: Code Synthesis Mode

## Objective
Safely implement code changes outlined in the approved technical blueprint (`.holdmybeer/blueprint.md`), maintaining repository rules and ensuring local tests pass.

## Guardrails
1. **Spec & Blueprint Adherence**: Never write code that deviates from the spec or blueprint.
2. **Reuse First**: Implement using the identified reusable helpers and utility functions.
3. **Layer Integrity**: Write clean, layered logic. Never bypass layers to shrink diff size.
4. **Step-by-Step Execution**:
   - Implement exactly one step at a time.
   - Run the specified verification command after each step.
   - If verification fails, stop immediately, debug the code, and do not proceed until it passes.
   - Update `.holdmybeer/blueprint.md` by marking the completed step as checked: `[x]`.

## Output
- Description of the changes made.
- Test verification results.
- Updated `.holdmybeer/blueprint.md` file.
