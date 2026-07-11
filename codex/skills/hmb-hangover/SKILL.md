---
name: hmb-hangover
description: 🤕 Checking tomorrow morning's hangover... — Runs the full validation suite (V1-V9) on the complete Project Model implementation. Use this skill for the final pre-merge compliance audit of the codebase and PSM.
---

<skill_description>
🤕 Checking tomorrow morning's hangover... — Runs the full validation suite (V1-V9) on the complete Project Model implementation.
</skill_description>

<context>
Load and follow: shared/CONSTITUTION.md
Load and follow: shared/DSL.md
Load and follow: shared/MODEL_SCHEMA.md
Load and follow: shared/MODEL_VALIDATION.md
</context>

<instructions>

ROLE    = Auditor
IN      = .holdmybeer/psm.json + codebase
OUT     = Complete compliance audit report + updated .holdmybeer/psm.json
FLAGS   = STRICT, COMPLETE, SAFE, TEST, TRACE
OP      = Q.COVERAGE→AUDIT
FLAVOR  = 🤕 Checking tomorrow morning's hangover...

PROCESS:
1. Ingest `Q.COVERAGE` graph fragment from `.holdmybeer/psm.json`.
2. Inspect the filesystem, verify the existence and execution of all Artifacts and Tests.
3. Apply the full validation ruleset from `shared/MODEL_VALIDATION.md`:
   - `V.REQ_HAS_FEATURE`
   - `V.REQ_HAS_AC`: Ingest Requirement nodes properties. Verify that `acceptance_criteria` is defined as a non-empty list of validation conditions.
   - `V.TEST_COVERS_FEATURE`
   - `V.FEATURE_HAS_TASK`
   - `V.TASK_HAS_ARTIFACT`
   - `V.ARTIFACT_HAS_TEST`: Ensure every Artifact unless `ownership == "manual"` is targeted by at least one Test node. (Manual files are exempt from forced auto-test coverage auditing).
   - `V.NO_ORPHAN_NODES`
   - `V.NO_STALE_NODES`
   - `V.FEATURE_HAS_API`: Backend/API project configuration check.
4. If ANY validation rules (V1-V6 or V8-V9) fail:
   - Identify violations and write warning/error properties to the respective nodes.
   - Append audit delta entry to `patches`.
   - Exit with a **`[FAIL]`** verdict listing all outstanding issues.
5. If validation rule V7 (orphans) fails, report warnings, but do not fail the audit unless other rules are violated.
6. If all validation rules pass:
   - Mark Project Model status `status = "approved"` under `meta`.
   - Update nodes status to: `status = "tested"`.
   - Append audit delta entry to `patches`.
   - Output a clean Traceability Table mapping: Requirement ──> Feature ──> Task ──> Artifact ──> Test.
   - Exit with a **`[PASS]`** verdict.

RULES:
- Maintain strict discipline. Do not hand-wave missing test files or skipped task records.
- Frame the analysis report in terms of codebase files, feature test results, and requirement checklists. Do not output raw graph theory node/relationship terminology.

VALIDATE:
✓ All 9 validation checks from shared/MODEL_VALIDATION.md were executed and detailed in the report.
✓ Every non-manual code artifact is mapped to a passing test suite.
✓ Output ends with a clear **`[PASS]`** or **`[FAIL]`** verdict.

</instructions>
