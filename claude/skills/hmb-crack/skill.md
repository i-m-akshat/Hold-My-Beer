---
name: hmb-crack
description: 🍳 Cracking eggs... — Extracts and converts requirement text to structured PSM format. Use this skill to parse raw specifications or requirements and transform them into structured node definitions.
---

<skill_description>
🍺 Cracking open a fresh specification... — Extracts semantic requirements & features into the Project Model and exports spec.md.
</skill_description>

<context>
Load and follow: shared/CONSTITUTION.md
Load and follow: shared/DSL.md
Load and follow: shared/MODEL_SCHEMA.md
</context>

<instructions>

ROLE    = Planner
IN      = Raw requirements input + .holdmybeer/psm.json
OUT     = Updated .holdmybeer/psm.json (domain layer) + generated .holdmybeer/spec.md
FLAGS   = STRICT, COMPLETE, MD, TRACE
OP      = INPUT→PSM.domain
FLAVOR  = 🍺 Cracking open a fresh specification...

PROCESS:
1. Parse raw input requirements.
2. Ingest current `.holdmybeer/psm.json`.
3. Extract `Requirement` and `Feature` nodes:
   - Generate short, stable, action-focused human slug IDs (e.g. `req-login-mfa`, `feat-sms-verification`) so they remain unchanged if requirement text shifts. Put detailed text descriptions in the `label` property.
   - Extract `feature.properties.actor` and `requirement.properties.acceptance_criteria` (array of strings).
   - Assign a `confidence` object:
     ```json
     "confidence": {
       "score": 0.0 to 1.0,
       "reason": "Clear explanation of the score based on input clarity and completeness",
       "source": "user | derived | inferred | generated"
     }
     ```
4. Establish `Feature` --[implements]--> `Requirement` relationships.
5. Save changes to `psm.json`:
   - Upsert nodes to `domain`.
   - Append new entry to `patches` list.
6. Export the updated domain data to `.holdmybeer/spec.md`:
   - Include a clean Markdown summary of Context, Requirements, and Features.
   - List slug IDs, status, confidence data, acceptance criteria, and explanation for transparency.
   - Include a Troubleshooting / Needs Clarification section for any node with `confidence.score < 0.60` (warn instead of halting).

RULES:
- Do not invent requirements or features not implied by the input text.
- If a requirement is ambiguous, extract it with a `confidence.score < 0.60`.
- Non-goals must be explicitly listed in the exported spec.md under Context.

VALIDATE:
✓ psm.json domain contains updated `domain` namespace with new Requirement and Feature nodes.
✓ Every Feature implements at least one Requirement in the relationships array.
✓ Every Feature contains at least one acceptance criteria string.
✓ Every node has a valid confidence object containing score, reason, and source.
✓ Generated `.holdmybeer/spec.md` is updated and synchronized.

</instructions>
