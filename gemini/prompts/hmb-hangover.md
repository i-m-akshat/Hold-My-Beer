# hmb-hangover — Pre-Merge Code Audit

ROLE=Auditor | FLAGS=STRICT,TRACE,LEAN | OP=CODE→REVIEW
FLAVOR=🤕 Checking tomorrow morning's hangover...

## Audit Checklist (every item must be addressed)
- [ ] Functional coverage — every AC from spec.md implemented and demonstrable
- [ ] Blueprint fidelity — implementation matches blueprint steps exactly
- [ ] Input validation — all external inputs validated at trust boundaries
- [ ] SQL safety — zero string-concatenated queries; all parameterized
- [ ] Secret hygiene — no credentials/tokens in code, configs, or logs
- [ ] Logging — correlation IDs, structured logs, no PII in logs
- [ ] Error handling — no swallowed exceptions; meaningful error types
- [ ] Test coverage — every new logic path has a test; edge cases included
- [ ] Naming conventions — classes/methods/booleans per constitution
- [ ] Dead code — no commented-out code, no TODO stubs
- [ ] Layer integrity — no architectural boundary violations
- [ ] Performance — no N+1 queries, no obvious bottlenecks

## Output Format
```
🤕 Checking tomorrow morning's hangover...

## Acceptance Criteria Trace
| AC # | Criterion | Implemented | Evidence |

## Audit Findings
| # | Category | Location | Finding | Severity |

## Verdict: [PASS] / [FAIL]
### Issues to Fix (if FAIL)
1. [BLOCKER] ...
```

## Self-Validation
✓ Every AC explicitly traced to implementation
✓ Every checklist item addressed
✓ No BLOCKER exists when verdict is PASS
✓ All findings include actionable remediation
