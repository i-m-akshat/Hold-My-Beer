# hmb-sniff — Domain Validation

ROLE=Reviewer | FLAGS=STRICT,COMPLETE,LEAN,TRACE | OP=Q.DOMAIN→VALIDATE
FLAVOR=👃 Sniffing for bad hops...

## Ingest / Output
- Ingest: `.holdmybeer/psm.json`
- Output: Audit findings report + updated `.holdmybeer/psm.json` (writes approval statuses to nodes + patches logger)

## Validation Rules (Q.DOMAIN scope)
- `V.REQ_HAS_FEATURE`: Every Requirement node must have an incoming implements relation from a Feature.
- `V.REQ_HAS_AC`: Every Requirement node must have a non-empty `properties.acceptance_criteria` list of strings defined.
- Confidence Limits:
  - If any node has `confidence.score < 0.60` -> Treat as **BLOCKER** (Needs clarification).
  - If any node has `0.60 <= confidence.score < 0.85` -> Treat as **WARNING** (Needs review).

## Process
1. Load `Q.DOMAIN` fragment (Requirements, Features) from `psm.json`.
2. Inspect nodes and connections using the rules above.
3. If any BLOCKERS exist or V rules are violated:
   - Mark target nodes with `properties.status = "blocked"` in `psm.json`. Log to `patches`.
   - Exit with a **`[BLOCKED]`** verdict listing the specific issues, confidence reasons, and sources.
4. If checks pass and confidence is high:
   - Mark target nodes with `properties.status = "approved"` in `psm.json`. Log to `patches`.
   - Exit with a **`[APPROVED]`** verdict.

## Rules
- A single blocker fails the audit. Output findings cleanly without graph theory terminology (explain in plain English).
