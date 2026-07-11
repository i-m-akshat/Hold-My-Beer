# Project Model Validation Rules (v1.0)

This document defines the validation checks applied to the Project Model by the review and audit skills (`hmb-sniff`, `hmb-ferment`, `hmb-hangover`).

---

## The 9 Core Rules

### 1. `V.REQ_HAS_FEATURE`
- **Check**: Every `Requirement` node must have at least one incoming `implements` relationship from a `Feature` node.
- **Verification**: `relationships.some(r => r.to == req.id && r.rel == "implements" && nodes[r.from].type == "Feature")`
- **Violation Severity**: **BLOCKER**. Raw requirement is unaddressed in the system design.

### 2. `V.REQ_HAS_AC`
- **Check**: Every `Requirement` node must contain at least one acceptance criteria definition.
- **Verification**: `req.properties.acceptance_criteria && req.properties.acceptance_criteria.length > 0`
- **Violation Severity**: **BLOCKER**. Requirement lacks explicit verification metrics and is ambiguous.

### 3. `V.TEST_COVERS_FEATURE`
- **Check**: Every `Feature` has at least one associated `Test` node where `test.properties.type == "acceptance"`.
- **Verification**: For each `Feature` node, there is a `Test` node linked to it (or to its requirements) with subtype `acceptance` via a `tests` relationship.
- **Violation Severity**: **BLOCKER**. Feature lacks a verifiable end-to-end acceptance test.

### 4. `V.FEATURE_HAS_TASK`
- **Check**: Every `Feature` node must contain at least one implementation `Task`.
- **Verification**: `relationships.some(r => r.from == feat.id && r.rel == "contains" && nodes[r.to].type == "Task")`
- **Violation Severity**: **BLOCKER**. Work plan has no concrete actions to execute the feature.

### 5. `V.TASK_HAS_ARTIFACT`
- **Check**: Every `Task` node must point to at least one implementation target `Artifact`.
- **Verification**: `relationships.some(r => r.from == task.id && r.rel == "contains" && nodes[r.to].type == "Artifact")`
- **Violation Severity**: **BLOCKER**. Task is declared but has no file or class outputs mapped to it.

### 6. `V.ARTIFACT_HAS_TEST`
- **Check**: Every `Artifact` node where `ownership` is `"generated"` or `"mixed"` must be targeted by at least one `Test` node via a `tests` relationship.
- **Verification**: For all `Artifact` nodes: if `ownership != "manual"` → must have incoming/outgoing test relationship.
- **Violation Severity**: **BLOCKER**. Unprotected production code is untested. (Artifacts owned manually by humans are exempt from automated test coverage checks).

### 7. `V.NO_ORPHAN_NODES`
- **Check**: There must be no nodes in any layer (`domain`, `architecture`, `implementation`) that have zero relationships linked to them.
- **Verification**: For every node check that at least one relationship in `relationships` has `r.from == node.id || r.to == node.id`.
- **Violation Severity**: **WARNING**. Represents dead code, abandoned specs, or unlinked infrastructure.

### 8. `V.NO_STALE_NODES`
- **Check**: There must be no nodes with `properties.status == "stale"`.
- **Verification**: Ensure no node exists with stale status in any layer.
- **Violation Severity**: **BLOCKER**. Graph is out of sync; the Impact Engine calculated a change blast radius, but some affected elements have not been successfully regenerated/updated.

### 9. `V.FEATURE_HAS_API`
- **Check**: If `.holdmybeer/constitution.md` specifies the project stack as a Backend or API service, every `Feature` node must have an associated `API` node.
- **Verification**: For each `Feature` node, there is an incoming or outgoing relationship linking it to an `API` node.
- **Violation Severity**: **BLOCKER** (if API project). Backend features must expose or map to concrete API interfaces or services.
