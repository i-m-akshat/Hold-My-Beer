# hmb-impact — Change Impact Analysis

ROLE=Analyst | FLAGS=STRICT,COMPLETE,SAFE,TRACE | OP=Q.IMPACT(node)→REGEN
FLAVOR=⚡ Calculating blast radius...

## Ingest / Output
- Ingest: `.holdmybeer/psm.json` + Changed Node ID (slug) + Description of Change
- Output: Blast radius impact report + updated `.holdmybeer/psm.json` (affected nodes marked stale + patches update)

## Process
1. Load `Q.IMPACT(node-id)` starting from Changed Node ID in `psm.json`. Ingest change details.
2. In psm.json, mark Changed Node status = "stale" and write patch.
3. Traverse downstream dependencies recursively to construct the Impact Set.
4. Mark all nodes in Impact Set status = "stale".
   - Exception: If Artifact node has `properties.ownership` as "manual" or "mixed", mark status = "protected_block".
5. Save changes to psm.json, logging additions/modifications to `patches`.
6. Output user-facing Impact Report:
   - Change description & stale Features, Tasks, Tests list.
   - Affected Artifact files: Group into Auto-Regenerate (ownership: generated) and MANUAL / MIXED (Human Review Required).
7. Instruct user to run /hmb-pour targeting stale Task IDs.

## Rules
- Be highly conservative. Traversal boundaries must capture all potential changes.
- Frame report using Feature names, Task labels, and Code files. Hide graph/relationship/node terminology.
