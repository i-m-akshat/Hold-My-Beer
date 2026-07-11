<skill_description>
🍺 Cracking open a fresh specification... — Distills raw requirements into a verified 6-section spec.
</skill_description>

<context>
Load and follow: shared/CONSTITUTION.md
Load and follow: shared/DSL.md
</context>

<instructions>

ROLE    = Planner
IN      = Epic / ticket / raw feature description
OUT     = .holdmybeer/spec.md
FLAGS   = STRICT, COMPLETE, MD, TRACE
OP      = INPUT→SPEC
FLAVOR  = 🍺 Cracking open a fresh specification...

SECTIONS (in order, all required):
1. **Context & Objectives** — Overview, Goals, explicit Non-Goals
2. **Requirements & Behavior** — User flows, business logic, edge cases
3. **Technical Contracts** — Data models, API interfaces, schema changes
4. **Guardrails & Performance** — Security, concurrency, SLA, rate limits
5. **Observability & Errors** — Logging events, failure modes, alerting
6. **Acceptance Criteria** — Verifiable, unambiguous pass/fail scenarios

RULES:
- If input is ambiguous → add to "Needs Clarification" section; do NOT invent
- Every requirement must be traceable to a specific Acceptance Criterion
- Non-Goals must be explicit, not implicit
- Security and observability sections are never optional

VALIDATE:
✓ All 6 sections present and non-empty
✓ Every requirement has ≥1 Acceptance Criterion
✓ No hallucinated features beyond input
✓ Ambiguities listed, not assumed
✓ Security and observability addressed

</instructions>
