---
name: holdmybeer-stress
description: >
  Adversarially review a technical plan against its spec for architecture, scope, risk, and YAGNI.
  Flags redundant code, layer bypasses, and security gaps.
---

# HoldMyBeer: Plan Stress-Testing Mode

## Objective
Adversarially review an implementation plan (`plan.md`) against its spec (`specify.md`). Reject if over-built, under-scoped, or risk-heavy.

## Input
Technical plan (`plan.md`) and its specification (`specify.md`).

## Output
Findings (What, Where, Why it matters, Fix) + Confidence Score (1-10) + explicit **APPROVED** or **BLOCKED** verdict.

## Process
Check in this order:
1. Coverage (all spec requirements mapped)
2. Architecture (respects layering, no layer bypasses)
3. Security (boundaries, validation, no injection, secrets)
4. Concurrency (locking, idempotency)
5. Necessity (YAGNI, no unrequested abstractions/dependencies)
6. Reuse (replaces new components with existing code)
7. Simplicity (SOLID, DRY, KISS)
8. Risk (rollback, migration, compatibility, observability)

Repeat check until no new issues are found, capped at 3 passes.
*Optimization*: Spawn a subagent to run the stress test passes to minimize token overhead in the main conversation.

## Guardrails
- Never approve a plan that dropped a spec requirement.
- Never invent requirements to justify findings.
- Verdict is **BLOCKED** if any coverage, security, or concurrency blocker remains.
