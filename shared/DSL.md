# 🍺 HoldMyBeer DSL Dictionary (v0.3)

Symbolic operations and terms used across all HoldMyBeer skills. This DSL replaces wordy English instructions in prompt configurations.

---

## 1. Schema Layers

| Section | Target | Role |
|---|---|---|
| `domain` | Problem space | Requirements, Features, Entities |
| `architecture` | Structural blueprint | APIs, Entities (schema) |
| `implementation` | Execution artifacts | Tasks, Artifacts, Tests |

---

## 2. Pipeline Operations

| Operation | Meaning |
|---|---|
| `INIT→WORKSPACE` | Scan for workspace files; create `.holdmybeer/psm.json` & empty templates if absent. |
| `INPUT→PSM.domain` | Parse raw requirements, extract features & requirements, store in `domain`. |
| `Q.DOMAIN→VALIDATE` | Run `V.REQ_HAS_FEATURE` & `V.REQ_HAS_AC`; output APPROVED or BLOCKED. |
| `Q.ARCHITECTURE→ENRICH` | Add API & Entity definitions to `architecture`; map Tasks. |
| `Q.COVERAGE→VALIDATE` | Run `V.FEATURE_HAS_TASK` & `V.TEST_COVERS_FEATURE` to check planning gaps. |
| `Q.TASK_GRAPH→CODE` | Implement active task's files (Artifacts); update `implementation`. |
| `Q.COVERAGE→AUDIT` | Run full validation rules (V.1 - V.8); verify complete test coverage and no orphans. |
| `Q.IMPACT(node)→REGEN` | Compute dependency blast radius; mark affected nodes `stale`; regenerate non-protected targets. |

---

## 3. Gate Verdicts

- **`[APPROVED]`**: Pass validation checks. Proceed to next stage.
- **`[BLOCKED]`**: Fail validation checks. Fix upstream, re-run command.
- **`[PASS]`**: Final audit complete with zero blockers. Ready to merge.
- **`[FAIL]`**: Final audit failed. Blocker issue list generated.

---

## 4. Roles

- **`Bartender`**: Workspace initialization and scaffold manager.
- **`Planner`**: Semantic requirement extractor.
- **`Reviewer`**: Adversarial domain and planning auditor.
- **`Architect`**: API and workflow schema designer.
- **`Builder`**: Micro-contextual file implementer.
- **`Auditor`**: Post-build integration and coverage validator.
- **`Analyst`**: Blast-radius evaluator (Impact Engine).

---

## 5. Flags (Inherited from CONSTITUTION.md)

`STRICT` · `TRACE` · `LEAN` · `COMPLETE` · `SAFE` · `MD` · `TEST` · `IDEMPOTENT`
