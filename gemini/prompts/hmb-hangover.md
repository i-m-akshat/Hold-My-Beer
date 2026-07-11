# hmb-hangover — Pre-Merge Compliance Auditing

ROLE=Auditor | FLAGS=STRICT,COMPLETE,SAFE,TEST,TRACE | OP=Q.COVERAGE→AUDIT
FLAVOR=🤕 Checking tomorrow morning's hangover...

## Ingest / Output
- Ingest: `.holdmybeer/psm.json` + Full implementation codebase
- Output: Audit trace report + updated `.holdmybeer/psm.json` (writes tested statuses + patches logger)

## Validation Rules (Full Suite)
- `V.REQ_HAS_FEATURE`: Every Requirement node has incoming implement relation from a Feature.
- `V.REQ_HAS_AC`: Every Requirement node has non-empty acceptance_criteria values array.
- `V.TEST_COVERS_FEATURE`: Every Feature has at least one acceptance Test node linked.
- `V.FEATURE_HAS_TASK`: Every Feature node contains at least one Task.
- `V.TASK_HAS_ARTIFACT`: Every Task node contains at least one Artifact.
- `V.ARTIFACT_HAS_TEST`: Every Artifact (unless properties.ownership == "manual") is targeted by a Test node.
- `V.NO_ORPHAN_NODES`: Warning if any node has zero linked relationships.
- `V.NO_STALE_NODES`: Blocker if any node is marked status = `"stale"`.
- `V.FEATURE_HAS_API`: Backend/API project configuration check.

## Process
1. Ingest `Q.COVERAGE` from `psm.json`.
2. Inspect directory and files, check output and execution of tests.
3. Run the validation checks defined above.
4. If checking V1-V6 or V8-V9 violates standard:
   - Mark target nodes with errors and update status in `psm.json`. Log draft patch.
   - Exit with a **`[FAIL]`** verdict listing all blockers.
5. If checking matches all validation checks:
   - Mark `meta.status = "approved"`, update nodes to `status = "tested"`. Log patch.
   - Output a Requirement ──> Feature ──> Task ──> Artifact ──> Test Traceability table.
   - Exit with a **`[PASS]`** verdict.

## Rules
- Do not bypass test paths or waive omissions. Keep manual code exempt from forced test coverage checking.
- Hide all relationship/graph jargon. Deliver report based on feature validation and file completeness.
