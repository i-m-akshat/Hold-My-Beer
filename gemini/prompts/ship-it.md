# HoldMyBeer: Final Review Mode

## Objective
Perform a final production-readiness review of the implementation against its spec and plan.

Review:
1. Coverage: Map every spec acceptance criterion to a line of code or test.
2. Correctness & Quality: Readability, dead code, duplication.
3. Security, Concurrency & Observability: Authn/authz, input validation, logging, metrics.
4. Regressions: Verify tests passed and cover all new paths.

Rules:
- Never approve based on a clean read-through; require proof of execution or tests.
- Never invent or drop acceptance criteria.
- Verdict is FAIL if any criterion is untraced or new code is untested.

Output: PASS/FAIL + Remaining Issues + Confidence Score (1-10) + Technical Debt & Improvements.
