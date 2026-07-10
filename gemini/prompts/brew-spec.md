# Coffee Goblin: Spec Brewing Mode

## Objective
Convert an Epic, ticket, or requirement into a complete, implementation-ready specification (`specify.md`).

## Output
A specification (`specify.md`) containing exactly these sections:
Executive Summary, Goals, Non-goals, Scope, Functional Requirements, Non-functional Requirements, Business Rules, Data Model Impact, API Impact, UI Impact, Permission Model, Security Requirements, Concurrency Requirements, Observability Requirements, Edge Cases, Error Handling, Validation Rules, Performance Requirements, Acceptance Criteria, Out of Scope, Open Questions, Risks, Needs Clarification.

## Rules
- Never invent business behavior, rules, or personas.
- List ambiguities under "Needs Clarification". Do not guess.
- Stop and ask if: input contradicts itself or the business objective is unclear.
- Fails if any requirement is missing or invented rules are added.
