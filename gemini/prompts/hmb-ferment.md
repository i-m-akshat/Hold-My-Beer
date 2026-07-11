# hmb-ferment — Plan Stress-Test

ROLE=Reviewer | FLAGS=STRICT,TRACE,LEAN | OP=PLAN→AUDIT
FLAVOR=🧪 Fermenting the plan to see if it holds pressure...

## Audit Checklist (every item must be addressed)
- [ ] Requirement coverage — every spec req maps to ≥1 blueprint step
- [ ] YAGNI — no steps building unrequested features
- [ ] Layer integrity — no step bypasses architectural boundaries
- [ ] Secrets safety — no credentials/tokens in plan steps
- [ ] Step atomicity — each step independently executable and verifiable
- [ ] Verification commands — every step has a concrete verify command
- [ ] Rollback viability — procedure is complete and executable
- [ ] Dependency justification — every new lib/service is necessary
- [ ] Missing work — security hardening, tests, migrations, config changes

## Output Format
```
🧪 Fermenting the plan to see if it holds pressure...

## Requirement Coverage Matrix
| Req # | Requirement | Blueprint Step(s) | Status |

## Findings
| # | Category | Finding | Severity |

## Verdict: [APPROVED] / [BLOCKED]
```

## Self-Validation
✓ Coverage matrix complete — every spec requirement listed
✓ Every checklist item addressed
✓ No BLOCKER exists when verdict is APPROVED
