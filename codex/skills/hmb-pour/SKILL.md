---
name: hmb-pour
description: 🍺 Hold my beer... writing production code. — Implements code artifacts mapped to active tasks in the Project Model. Use this skill to generate implementation for a task, obeying ownership shields.
---

<skill_description>
🍺 Hold my beer... writing production code. — Implements code artifacts mapped to active tasks in the Project Model.
</skill_description>

<context>
Load and follow: shared/CONSTITUTION.md
Load and follow: shared/DSL.md
Load and follow: shared/MODEL_SCHEMA.md
</context>

<instructions>

ROLE    = Builder
IN      = .holdmybeer/psm.json + Target Step Number / Task ID
OUT     = Production code and tests + updated .holdmybeer/psm.json
FLAGS   = STRICT, COMPLETE, SAFE, TEST, TRACE
OP      = Q.TASK_GRAPH→CODE
FLAVOR  = 🍺 Hold my beer... writing production code.

IMPLEMENTATION PROTOCOL:
1. Load `Q.TASK_GRAPH` associated with the active Target Step Number or Task ID from `psm.json`.
2. Inspect the Task node and its containing `Artifact` and `Test` target nodes.
3. For each `Artifact` (target file path):
   - Check the `properties.ownership` value in `psm.json`.
   - If `ownership == "manual"` or `ownership == "mixed"` → **HALT**. Output message: "File contains manual edits and is protected from auto-regeneration. Developer manual modification is required."
   - If `ownership == "generated"` → Safely implement or modify the file matching the architecture.
4. For each `Test` (target test path):
   - Implement the test case mapping the acceptance criteria.
5. Verification cycle:
   - Execute the target Task's verification command (`properties.verify`).
   - If the verification passes:
     - Mark Task node: `status = "complete"`.
     - Mark Artifact node: `status = "implemented"`.
     - Mark Test node: `status = "passing"`.
     - Append delta log entry to `patches`.
     - Output step implementation diff and verification success report.
   - If the verification fails:
     - **HALT**. Report the compiler-like diagnostics and request manual fix. Do not proceed to subsequent Tasks.

CODE RULES:
- Naming rules (PascalCase class, camelCase method, collections plural) must be followed.
- Secrets must never be hardcoded.
- Existing code/helpers must be reused following the reuse ladder.

VALIDATE:
✓ Code & Tests are written to target paths on disk.
✓ Target Task, Artifact, and Test nodes are marked complete/implemented/passing in psm.json.
✓ `patches` contains a log entry for the pour operation.
✓ Verification command ran and passed before finishing.

</instructions>
