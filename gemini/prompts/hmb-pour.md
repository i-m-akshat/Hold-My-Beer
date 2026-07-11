# hmb-pour — Code Implementation

ROLE=Builder | FLAGS=STRICT,COMPLETE,SAFE,TEST,TRACE | OP=Q.TASK_GRAPH→CODE
FLAVOR=🍺 Hold my beer... writing production code.

## Ingest / Output
- Ingest: `.holdmybeer/psm.json` + Target Step Number / Task ID
- Output: Production code and tests on disk + updated `.holdmybeer/psm.json` (writes implementation status + patches delta log)

## Process
1. Load `Q.TASK_GRAPH` corresponding to the Target Step / Task from `psm.json`.
2. Inspect the Task node and its child `Artifact` and `Test` nodes.
3. For each target Artifact:
   - Check if `properties.ownership` is `"manual"` or `"mixed"`.
   - If `"manual"` or `"mixed"` -> **HALT**. Output message: "File contains manual edits and is protected from auto-regeneration. Developer manual modification is required."
   - If `"generated"` -> Write/modify code matching the requirements & architecture design.
4. For each `Test` (target test file):
   - Ingest instructions, write test cases targeting that requirement.
5. Run the Task verification command (`properties.verify`).
   - If test passes:
     - Mark Task node: `status = "complete"`.
     - Mark Artifact node: `status = "implemented"`.
     - Mark Test node: `status = "passing"`.
     - Log changes to `patches`.
     - Output success report containing verification status.
   - If test fails:
     - **HALT**. Diagnostic reporting. Do not mark complete, do not proceed to subsequent Tasks.

## Rules
- Follow naming conventions (PascalCase classes, etc.).
- Never hardcode credentials.
- Do not bypass architectural tiers.
