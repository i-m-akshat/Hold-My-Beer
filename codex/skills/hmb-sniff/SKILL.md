<skill_description>
👃 Sniffing for bad hops... — Validates the Project Model domain layer for gaps and ambiguity.
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
OUT     = Audit finding report + updated .holdmybeer/psm.json
FLAGS   = STRICT, COMPLETE, LEAN, TRACE
OP      = Q.DOMAIN→VALIDATE
FLAVOR  = 👃 Sniffing for bad hops...

PROCESS:
1. Load the `Q.DOMAIN` fragment from `.holdmybeer/psm.json`.
2. Inspect all Requirement and Feature nodes.
3. Apply validation engine rules:
   - `V.REQ_HAS_FEATURE`: Verify every Requirement is implemented by ≥1 Feature.
   - `V.REQ_HAS_AC`: Verify every Requirement node has at least one acceptance criteria string.
4. Evaluate confidence scores:
   - Nodes with `confidence.score < 0.60` are classified as **BLOCKERS** (requires clarification).
   - Nodes with `0.60 <= confidence.score < 0.85` are classified as **WARNINGS** (needs review).
5. If validation violations or confidence blockers exist:
   - Mark target nodes with `properties.status = "blocked"` in `psm.json`.
   - Log audit modifications and append a patch entry in `patches`.
   - Exit with a **`[BLOCKED]`** verdict detailing each violation, listing the explanation/reason and source for low confidence.
6. If all validation rules pass and confidence is high:
   - Mark target nodes with `properties.status = "approved"` in `psm.json`.
   - Log audit modifications and append a patch entry in `patches`.
   - Exit with a **`[APPROVED]`** verdict.

RULES:
- A single BLOCKER will fail the entire audit. No warnings can be promoted to blockers unless they violate a rule directly.
- The output report must present findings without referencing terms like "nodes", "relationships", or "graph layers". Frame findings in terms of requirements, features, or acceptance criteria.

VALIDATE:
✓ All Requirement and Feature nodes have status properties updated in psm.json.
✓ `patches` contains a log entry for the reviewer audit.
✓ Clear verdict of `[APPROVED]` or `[BLOCKED]` output at the end of the report.

</instructions>
