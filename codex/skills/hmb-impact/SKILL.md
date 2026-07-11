<skill_description>
⚡ Calculating blast radius... — Analyzes the impact of a changed requirement, marks affected nodes as stale, and plans selective regeneration.
</skill_description>

<context>
Load and follow: shared/CONSTITUTION.md
Load and follow: shared/DSL.md
Load and follow: shared/MODEL_SCHEMA.md
</context>

<instructions>

ROLE    = Analyst
IN      = .holdmybeer/psm.json + Changed Node ID (slug) + Description of Change
OUT     = Impact analysis report + updated .holdmybeer/psm.json (affected nodes marked stale)
FLAGS   = STRICT, COMPLETE, SAFE, TRACE
OP      = Q.IMPACT(node)→REGEN
FLAVOR  = ⚡ Calculating blast radius...

PROCESS:
1. Load `Q.IMPACT(node-id)` query from `.holdmybeer/psm.json` starting at the specified Changed Node ID.
2. In `psm.json`, update the Changed Node:
   - Mark status: `properties.status = "stale"`.
   - Update node properties to document the new description of the change.
3. Traverse the outgoing relationships and trace dependencies:
   - Identify all downstream Features, Tasks, Artifacts, and Tests that depend on or are contained by the changed node (or its children).
   - This collected set of downstream elements forms the **Impact Set**.
4. For each node in the Impact Set:
   - Update status: `properties.status = "stale"`.
   - If node is an `Artifact` (code file) and `properties.ownership` is `"manual"` or `"mixed"` -> Flag as `status = "protected_block"` to separate it from auto-regeneration.
5. In `psm.json`:
   - Save all node status changes.
   - Append delta log entry to `patches` detailing modified node slugs.
6. Generate the user-facing Blast Radius & Impact Report:
   - Detail the changed requirements.
   - List affected Features and Tasks (marked stale).
   - List affected Artifact (code) files:
     - Group under **Auto-Regenerate** (those with `ownership == "generated"`).
     - Group under **MANUAL / MIXED (Human Review Required)** (those with `ownership == "manual"` or `ownership == "mixed"`. Note: This block identifies files where human review is required, preventing auto-override).
   - List affected Tests (marked stale).
7. Outline next steps for selective regeneration:
   - Instruct the user/system to run `/hmb-pour` targeting specifically the stale Task IDs to regenerate only the affected parts of the system while keeping the rest untouched.

RULES:
- Be highly conservative. If a dependency boundary is ambiguous, include it in the Impact Set to guarantee safety.
- Present the impact list in terms of actual Features, Tasks, Code Files, and Test Files. Hide all relationship/node terminology.

VALIDATE:
✓ Changed node ID exists and is updated in psm.json.
✓ All downstream dependent nodes are marked status = "stale" in psm.json.
✓ Protected artifact files are detected and flagged in the output report.
✓ `patches` contains a log entry with the version bump and modified lists.

</instructions>
