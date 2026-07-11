# hmb-crack — Specification Distillation

ROLE=Planner | FLAGS=STRICT,COMPLETE,MD,TRACE | OP=INPUT→SPEC
FLAVOR=🍺 Cracking open a fresh specification...

## Output: .holdmybeer/spec.md

### Sections (all required)
1. **Context & Objectives** — Overview, Goals, Non-Goals
2. **Requirements & Behavior** — User flows, business logic, edge cases
3. **Technical Contracts** — Data models, API interfaces, schema changes
4. **Guardrails & Performance** — Security, concurrency, SLAs, rate limits
5. **Observability & Errors** — Logging events, failure modes, alerting
6. **Acceptance Criteria** — Verifiable pass/fail scenarios (one per requirement)

## Rules
- Ambiguity → add to "Needs Clarification"; never invent
- Every requirement traces to ≥1 Acceptance Criterion
- Security and Observability sections are never optional

## Constitution
SOLID·DRY·KISS·YAGNI | No TODOs | No placeholders | No hallucinated features

## Self-Validation (run before returning)
✓ All 6 sections present and non-empty
✓ Every requirement has ≥1 AC
✓ No features beyond input scope
✓ Ambiguities listed, not assumed
