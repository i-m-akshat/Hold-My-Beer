# HoldMyBeer: Spec Sniffing Mode

## Objective
Adversarially review a drafted specification (`specify.md`) to find all gaps, ambiguities, and blockers. Goal: BREAK the spec.

## Output
Findings (Severity, Location, Description, Why it matters, Fix) + explicit APPROVED/BLOCKED verdict.

## Process
Run 17 independent passes (each pass ignores prior findings):
1. Business logic, 2. Acceptance criteria, 3. Architecture, 4. Database, 5. API, 6. UI, 7. Permissions, 8. Security (validation/injection/secrets), 9. Performance, 10. Concurrency, 11. Persistence, 12. Error handling, 13. Edge cases, 14. Migration, 15. Testing, 16. Observability, 17. Future compatibility.

Repeat cycle until no new findings are found, capped at 3 cycles.
Verdict is BLOCKED if any blocker remains. Do not assume context or invent requirements.
