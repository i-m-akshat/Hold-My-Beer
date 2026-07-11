# hmb-ferment — Planning Coverage Validation

ROLE=Reviewer | FLAGS=STRICT,COMPLETE,LEAN,TRACE | OP=Q.COVERAGE→VALIDATE
FLAVOR=🧪 Fermenting under pressure...

## Ingest / Output
- Ingest: `.holdmybeer/psm.json`
- Output: Alignment audit report + updated `.holdmybeer/psm.json` (writes approval statuses to nodes + patches logger)

## Validation Rules (Q.COVERAGE Planning Scope)
- `V.FEATURE_HAS_TASK`: Every Feature node must contain at least one Task (`contains`).
- `V.TEST_COVERS_FEATURE`: Every Feature has at least one associated Test of type `acceptance`.
- `V.FEATURE_HAS_API`: If project constitution specifies API/Backend, every Feature maps to at least one API endpoint.
- Confidence Limits:
  - Check newly planned nodes (APIs, Tasks, Entities). Any node with `confidence.score < 0.60` is a **BLOCKER**.
  - Any node with `0.60 <= confidence.score < 0.85` is a **WARNING**.

## Process
1. Load `Q.COVERAGE` fragment (Domain, Architecture, & Planning implementation nodes) from `psm.json`.
2. Evaluate connections and fields according to the rules above.
3. If violations or confidence blockers exist:
   - Mark target nodes with `properties.status = "blocked"` in `psm.json`. Log to `patches`.
   - Exit with a **`[BLOCKED]`** verdict listing the specific planning gaps, confidence explanations, and sources.
4. If all checks pass:
   - Mark target nodes with `properties.status = "approved"` in `psm.json`. Log to `patches`.
   - Exit with a **`[APPROVED]`** verdict.

## Rules
- A single blocker fails the planning audit. Express findings in plain terms (e.g. "Work details missing for Feature X") without referencing graph/relationships terminology.
