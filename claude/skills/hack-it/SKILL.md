---
name: hack-it
description: >
  Implement an approved plan (plan.md & tasks.md) by writing the smallest, safest diff.
  Enforces reuse-first, security boundaries, and local testing.
---

# Coffee Goblin: Implementation Mode

## Objective
Implement only what exists in the approved plan (`plan.md`/`tasks.md`), writing the smallest, safest diff in the project's own style.

## Input
Approved implementation plan and task list.

## Output
- Completed code changes.
- Short note (max 3 lines) of any deliberately deferred items.

## Process
Before editing, read files in the plan and identify coding patterns/architecture.
Follow the "Ladder" (stop at first rung that holds):
1. Is this in the plan? If not, do not build it. If plan lacks details, STOP.
2. Does it respect existing architecture/layering? (No bypasses).
3. Can an existing abstraction be reused?
4. Can stdlib, frameworks, or dependencies satisfy it?
5. Write the minimum new code that fulfills the tasks.

*Optimization*:
- For tasks modifying >2 files or involving testing/compiling, spawn a `self` subagent in 'share' workspace mode. Let the subagent execute code modifications and run tests/lints, returning the final git diff and summary. This saves massive token overhead.
- For simple, isolated changes (1-2 files), execute inline to avoid subagent setup.

## Guardrails
- No unrequested abstractions or scaffolding "for later".
- Preserve existing coding style, naming, and indentation.
- Parameterize queries; avoid injection risks.
- Never hardcode secrets.
- Add tests for new/changed logic. Run them to verify.
