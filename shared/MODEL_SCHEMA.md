# Project Model Schema (v1.0)

This document defines the schema, types, properties, and constraints of the Project Model. The Project Model is stored as a single JSON file at `.holdmybeer/psm.json`.

---

## 1. Structure

The Project Model is partitioned into distinct semantic layers. This avoids flat list complexity and keeps domain, design, and execution concerns isolated.

```json
{
  "meta": {
    "version": "1",
    "project": "project-slug",
    "created": "ISO-8601-Timestamp",
    "updated": "ISO-8601-Timestamp",
    "model_schema": "1.0"
  },
  "domain": {
    "<slug-id>": { "Node" }
  },
  "architecture": {
    "<slug-id>": { "Node" }
  },
  "implementation": {
    "<slug-id>": { "Node" }
  },
  "relationships": [
    { "Relationship" }
  ],
  "patches": [
    { "Patch" }
  ]
}
```

---

## 2. Identifier Slugs

Avoid auto-incrementing integers (e.g., `req-1`, `req-2`) to prevent git merge conflicts. Use stable, descriptive human-readable slugs. 
Keep slug IDs short and action-focused (e.g., `req-save-cart` instead of `req-user-can-reset-or-save-their-cart-on-checkout-flow`) so they remain steady even if wording or requirement texts evolve. Store the descriptive text in the node's `label`.

- **Requirements**: `req-<description-slug>` (e.g., `req-checkout`, `req-mfa`)
- **Features**: `feat-<capability-slug>` (e.g., `feat-mfa-sms`, `feat-cart-save`)
- **Entities**: `entity-<model-slug>` (e.g., `entity-user`, `entity-cart`)
- **APIs**: `api-<resource-action-slug>` (e.g., `api-cart-save`, `api-session-get`)
- **Tasks**: `task-<action-slug>` (e.g., `task-mfa-db`, `task-cart-table`)
- **Artifacts**: `artifact-<file-or-symbol-slug>` (e.g., `artifact-cart-ctrl`, `artifact-user-val`)
- **Tests**: `test-<verifying-target-slug>` (e.g., `test-mfa-flow`, `test-user-model`)

---

## 3. Node Schema & Properties

Every node features a confidence object indicating the certainty and provenance of the information.

### Generic Node Representation
```json
{
  "id": "slug-id",
  "type": "Requirement | Feature | Entity | API | Task | Artifact | Test",
  "label": "Human readable name or description",
  "confidence": {
    "score": 0.95,
    "reason": "Requirement explicitly stated in epic ticket with clear validation instructions.",
    "source": "user | derived | inferred | generated"
  },
  "properties": {
    "status": "proposed | approved | implemented | tested | stale",
    "notes": "Optional developer notes",
    "...": "Type-specific properties"
  },
  "meta": {
    "created_by": "skill-name",
    "updated_by": "skill-name",
    "updated_at": "ISO-8601-Timestamp"
  }
}
```

### Type-Specific Properties

#### 1. Domain Layer (`domain`)
- **`Requirement`**
  - `status`: `"proposed" | "approved" | "stale" | "deprecated"`
  - `priority`: `"high" | "medium" | "low"`
  - `source`: `"ticket-abc" | "email-abc" | "manual"`
  - `acceptance_criteria`: Array of strings (e.g., `["User session ends immediately upon click logout", "Cookies destroyed"]`)
- **`Feature`**
  - `status`: `"proposed" | "approved" | "stale"`
  - `actor`: `"Authenticated User" | "Guest" | "System Admin" | etc.`
- **`Entity`**
  - `status`: `"proposed" | "approved" | "stale"`
  - `subtype`: `"AggregateRoot" | "ValueObject" | "StandardEntity"`
  - `fields`: Array of `{ "name": "string", "type": "string", "nullable": true/false }`

#### 2. Architecture Layer (`architecture`)
- **`API`**
  - `status`: `"proposed" | "approved" | "stale"`
  - `subtype`: `"endpoint" | "service" | "integration"`
  - `method`: `"GET" | "POST" | "PUT" | "DELETE" | null`
  - `path`: `/relative/url` (if endpoint)
  - `auth`: `"required" | "anonymous" | "admin" | null`

#### 3. Implementation Layer (`implementation`)
- **`Task`**
  - `status`: `"pending" | "in-progress" | "complete" | "stale"`
  - `verify`: `"exact verification test command to run"`
- **`Artifact`**
  - `status`: `"pending" | "implemented" | "stale"`
  - `type`: `"file" | "class" | "method"`
  - `path`: `relative/path/to/source.file`
  - `ownership`: `"generated" | "manual" | "mixed" | "conflicted"` (if `"manual"`, `"mixed"`, or `"conflicted"`, `hmb-impact` blocks automatic regeneration and flags the artifact for developer merge/review)
- **`Test`**
  - `status`: `"pending" | "passing" | "failing"`
  - `type`: `"unit" | "integration" | "acceptance"`
  - `path`: `relative/path/to/test.file`
  - `command`: `"command to execute just this test case"`

*Future Roadmap Note on Granularity: While this v1 model supports file-level ownership, the schema structure enables scaling to symbol-specific nodes (e.g., mapping class methods directly as Artifact sub-nodes) to solve fine-grained mixed-source updates in later versions.*

---

## 4. Relationships Schema

Relationships connect nodes across all three layers.

```json
{
  "from": "source-node-slug",
  "to": "target-node-slug",
  "rel": "depends_on | contains | implements | uses | tests"
}
```

### Relationship Types

- **`depends_on`**: Sub-requirements, sequential features, or sequential tasks.
- **`contains`**: Parent-child grouping (e.g. Feature contains Task, Task contains Artifact).
- **`implements`**: Bridging implementation/design to requirement (e.g. Task implements Feature, Feature implements Requirement, API implements Feature).
- **`uses`**: Architectural dependencies (e.g. Artifact/Code uses Entity, Controller uses API).
- **`tests`**: Validation coupling (e.g. Test tests Requirement, Test tests Feature).

---

## 5. Patches Schema

Track changes incrementally. Every skill that alters the Project Model appends a delta entry to the `patches` list.

```json
{
  "version": 2,
  "parent": 1,
  "timestamp": "ISO-8601-Timestamp",
  "written_by": "hmb-brew",
  "added": [
    "api-post-cart-save",
    "task-implement-cart-save"
  ],
  "removed": [],
  "modified": [
    "feat-cart-save-btn"
  ]
}
```
