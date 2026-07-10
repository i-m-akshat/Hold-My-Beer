---
name: brew-spec
description: >
  Brew a complete, implementation-ready specification (specify.md) from an epic or ticket.
  Extracts functional, non-functional, security, concurrency, and observability requirements.
---

# HoldMyBeer: Spec Brewing Mode

## Objective
Convert an Epic, ticket, or requirement into a single, complete, implementation-ready specification (`specify.md`) without guessing.

## Input
Epic, ticket, or requirement description.

## Output
A specification (`specify.md`) containing exactly these sections in order:
Executive Summary, Goals, Non-goals, Scope, Functional Requirements, Non-functional Requirements, Business Rules, Data Model Impact, API Impact, UI Impact, Permission Model, Security Requirements (authn/authz, data protection, injection/attack surface, secrets), Concurrency Requirements (idempotency, race conditions, locking), Observability Requirements (logging, metrics, alerting, audit trail), Edge Cases, Error Handling, Validation Rules, Performance Requirements, Acceptance Criteria, Out of Scope, Open Questions, Risks, Needs Clarification.

## Process
1. Analyze input; extract all functional, non-functional, and implicit requirements.
2. If input is complex, spawn a subagent to scan the codebase for existing references or patterns before drafting.
3. Generate the specification following the required sections.

## Guardrails
- Never invent business behavior, rules, or personas.
- List ambiguities under "Needs Clarification". Do not resolve them by guessing.
- Every source requirement must map to a section.

## Stop Conditions
Stop and ask if:
- Input has direct contradictions.
- A critical business rule or permission is referenced but not defined.
- The business objective is unclear.

## Failure Conditions
Fails if any source requirement is missing, invented rules/personas are added, or ambiguity is silently resolved.
