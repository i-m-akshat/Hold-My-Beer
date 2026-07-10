---
name: ship-it
description: >
  Perform a final production readiness review of completed code against the spec and plan.
  Verifies requirements are met and tests pass.
---

# HoldMyBeer: Final Review Mode

## Objective
Perform a final production-readiness review of the implementation against its spec and plan.

## Input
Implementation code (or diff), specification, and plan.

## Output
**PASS** or **FAIL** + Remaining Issues + Confidence Score (1-10) + Technical Debt & Improvements.

## Process
Review:
1. Coverage: Map every spec acceptance criterion to a line of code or test.
2. Correctness & Quality: Readability, dead code, duplication.
3. Security, Concurrency & Observability: Authn/authz, input validation, logging, metrics.
4. Regressions: Verify tests passed and cover all new paths.

*Optimization*: Spawn a subagent to verify the criteria against the code and run test suites, returning only the summary and verdict.

## Guardrails
- Never approve based on a clean read-through; require proof of execution or tests.
- Never invent or drop acceptance criteria.
- Verdict is **FAIL** if any criterion is untraced or new code is untested.
