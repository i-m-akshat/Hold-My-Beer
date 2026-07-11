# hmb-crack — Requirements Extraction

ROLE=Planner | FLAGS=STRICT,COMPLETE,MD,TRACE | OP=INPUT→PSM.domain
FLAVOR=🍺 Cracking open a fresh specification...

## Ingest / Output
- Ingest: Raw requirements input + `.holdmybeer/psm.json`
- Output: Updated `.holdmybeer/psm.json` (writes `domain` namespace) + Generated `.holdmybeer/spec.md` (Markdown summary)

## Project Model brief
- Structure: `{ "meta": {}, "domain": {}, "architecture": {}, "implementation": {}, "relationships": [], "patches": [] }`
- Nodes: ID (stable, short, action-focused human-slug, e.g. `req-login-mfa`, `feat-sms-mfa`), type, label (descriptive text), confidence, properties, meta.
- Domain Node Types:
  - `Requirement` { properties: { status: "proposed|approved|stale", priority, source } }
  - `Feature` { properties: { status: "proposed|approved|stale", actor, acceptance_criteria: ["list of criteria"] } }
- Relationships: `{ from, to, rel: "implements" }` (Feature implements Requirement)

## Confidence Object Format
```json
"confidence": {
  "score": 0.95,
  "reason": "Explicit details provided for authentication requirements.",
  "source": "user | derived | inferred | generated"
}
```

## Process
1. Parse raw input requirements.
2. Ingest current `.holdmybeer/psm.json`.
3. Extract `Requirement` and `Feature` nodes. Assign `confidence` objects and short stable slug IDs. Keep long text inside `label`. Extrapolate `actor` and `acceptance_criteria` list.
4. Establish implements relationships from Features to Requirements.
5. Save changes to `psm.json` (domain layer) and append entry to `patches`.
6. Export domain data to `.holdmybeer/spec.md` (Context, Requirements, Feature tables with IDs, acceptance criteria, and warning sections for confidence.score < 0.60).

## Rules
- Never invent features outside input scope.
- Ambiguities must be extracted with confidence.score < 0.60 to represent gaps (warn instead of halting).

## Self-Validation
✓ psm.json domain contains only Requirement and Feature nodes.
✓ Every Feature implements at least one Requirement.
✓ Every Requirement contains a non-empty acceptance_criteria array.
✓ Every node has a confidence object with score, reason, and source.
✓ `.holdmybeer/spec.md` matches the updated Project Model.
