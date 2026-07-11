---
name: hmb-ferment
description: 🧪 Fermenting under pressure... — Verifies the planning coverage chain and architecture feasibility before implementation. Use this skill to validate that every Feature traces to a Task and that test coverage is planned.
---

<skill_description>
🧪 Fermenting under pressure... — Verifies the planning coverage chain and architecture feasibility before implementation.
</skill_description>

<context>
Load and follow: shared/CONSTITUTION.md
Load and follow: shared/DSL.md
Load and follow: shared/MODEL_SCHEMA.md
Load and follow: shared/MODEL_VALIDATION.md
</context>

<instructions>

ROLE    = Reviewer
IN      = .holdmybeer/psm.json
OUT     = Alignment audit report + updated .holdmybeer/psm.json
FLAGS   = STRICT, COMPLETE, LEAN, TRACE
OP      = Q.COVERAGE→VALIDATE
FLAVOR  = 🧪 Fermenting under pressure...

PROCESS:
1. Load the `Q.COVERAGE` fragment from `.holdmybeer/psm.json`.
2. Inspect all architecture nodes (API, Entity) and implementation nodes (Task, Artifact, Test).
3. Apply validation rules:
   - `V.FEATURE_HAS_TASK`: Ensure every Feature contains at least one Task (`contains`).
   - `V.TEST_COVERS_FEATURE`: Ensure every Feature has at least one associated Test of type `acceptance` (`tests`).
   - `V.FEATURE_HAS_API`: If project type is Backend/API in `.holdmybeer/constitution.md`, verify Feature maps to an API node.
4. Validate confidence levels of newly added architecture and implementation nodes:
   - Nodes with `confidence.score < 0.60` are classified as **BLOCKERS** (actionable design clarification required).
   - Nodes with `0.60 <= confidence.score < 0.85` are classified as **WARNINGS** (needs review / refinement).
5. If validation violations or confidence blockers exist:
   - Mark target nodes with `properties.status = "blocked"` in `psm.json`.
   - Log audit modifications and append a patch entry in `patches`.
   - Exit with a **`[BLOCKED]`** verdict detailing the alignment gaps or design issues (including explanations and sources for low confidence).
6. If all validation rules pass:
   - Mark target nodes with `properties.status = "approved"` in `psm.json`.
   - Log audit modifications and append a patch entry in `patches`.
   - Exit with a **`[APPROVED]`** verdict.

RULES:
- A single BLOCKER will fail the entire planning audit.
- Do not reference graph architecture terminology structure (nodes, relationships, relationships array) in the user report. Present metrics as "Task coverage ratio" or "Acceptance test alignment".

VALIDATE:
✓ All reviewed architecture and implementation nodes have status properties updated in psm.json.
✓ `patches` contains a log entry for the reviewer audit.
✓ Clear verdict of `[APPROVED]` or `[BLOCKED]` output at the end of the report.

</instructions>
