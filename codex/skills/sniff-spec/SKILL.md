---
name: sniff-spec
description: >
  Adversarially review a specification (specify.md) to find gaps, ambiguities, and blockers.
  Runs 17 independent passes covering logic, security, concurrency, and edge cases.
---

# HoldMyBeer: Spec Sniffing Mode

## Objective
Adversarially review a drafted specification (`specify.md`) to find all gaps, ambiguities, and blockers. Goal: BREAK the spec.

## Input
A drafted specification file (e.g. `specify.md`).

## Output
Findings (Severity, Location, Description, Why it matters, Fix) + explicit **APPROVED** or **BLOCKED** verdict.

## Process & passes
Run 17 independent passes (each pass ignores prior findings):
1. Business logic
2. Acceptance criteria
3. Architecture
4. Database
5. API
6. UI
7. Permissions (authn/authz)
8. Security (validation, injection, secrets)
9. Performance
10. Concurrency (locking, race conditions)
11. Persistence
12. Error handling
13. Edge cases
14. Migration
15. Testing
16. Observability (logging, metrics, alert)
17. Future compatibility

Repeat cycle until no new findings are found, capped at 3 cycles.
*Optimization*: To minimize token usage and keep context clean, spawn a subagent to run passes 1-17 and compile findings, returning only the final verdict and list of issues to the main agent.

## Guardrails
- Do not rewrite or improve the spec—only report issues.
- Never assume a pass is exhaustive.
- Verdict is **BLOCKED** if any blocker remains.
