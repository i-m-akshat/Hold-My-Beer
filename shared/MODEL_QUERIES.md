# Project Model Fragment Queries (v1.0)

To keep LLM token usage low and focus reasoning, skills query and load only relevant subsets (fragments) of the Project Model. This document defines the 5 named fragment queries.

---

## 1. Domain Query (`Q.DOMAIN`)

Loads the entire problem space (requirements & features) to analyze scope, user flows, and gaps.

### Nodes Loaded
- All nodes in the `domain` namespace:
  - `Requirement`
  - `Feature`
  - `Entity` (if domain specific)
- All relationships matching:
  - `Feature` --[implements]--> `Requirement`
  - `Feature` --[depends_on]--> `Feature`
  - `Requirement` --[depends_on]--> `Requirement`

### Used By
- `hmb-crack` (to reference existing domain before adding)
- `hmb-sniff` (to perform spec validation)

---

## 2. Architecture Query (`Q.ARCHITECTURE`)

Loads the domain space alongside API and structural design decisions to plan implementation artifacts.

### Nodes Loaded
- All `domain` nodes
- All `architecture` nodes:
  - `API`
  - `Entity` (schema specific)
- Relationships:
  - `API` --[uses]--> `Entity`
  - `API` --[implements]--> `Feature` (if applicable)

### Used By
- `hmb-brew` (to convert requirements into architecture and tasks)

---

## 3. Task Graph Query (`Q.TASK_GRAPH(feature-id?)`)

Returns the implementation roadmap, optionally filtered to a single feature scope to keep code generation contexts clean.

### Nodes Loaded
- All `implementation` nodes:
  - `Task`
  - `Artifact`
  - `Test`
- If `feature-id` is provided:
  - Filter to nodes linked via relationship chain to `feature-id`
- Relationships:
  - `Task` --[implements]--> `Feature`
  - `Task` --[contains]--> `Artifact`
  - `Task` --[contains]--> `Test`
  - `Task` --[depends_on]--> `Task`

### Used By
- `hmb-pour` (to execute code generation for the active task without context leak)

---

## 4. Coverage Query (`Q.COVERAGE`)

Retrieves the complete traceability chain to verify if there are any gaps from raw requirement down to class, method, or test suite.

### Nodes Loaded
- All nodes across `domain`, `architecture`, and `implementation` regions.
- All relationships of all types.

### Used By
- `hmb-ferment` (to stress-test planning requirements)
- `hmb-hangover` (to verify implementation coverage metrics and orphans)

---

## 5. Impact Query (`Q.IMPACT(node-id)`)

Computes the dependency blast radius of a changed node. Traverses the relationship graph recursively to collect downstream items.

### Traversal Logic
1. Start at `node-id`.
2. Follow outgoing relationships where `from == current-node` recursively.
3. Follow incoming relationships where `to == current-node` if the relationship represents a dependency relation (e.g. `contains` or `implements` dependencies where parent changes affect children).
4. Collect all visited Nodes into the **Impact Set**.
5. Identify any `Artifact` node in the set where `properties.ownership` is `"manual"` or `"mixed"`.

### Used By
- `hmb-impact` (calculates what is stale and needs regen)
