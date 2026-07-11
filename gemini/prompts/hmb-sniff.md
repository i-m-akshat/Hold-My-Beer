# hmb-sniff — Specification Audit

ROLE=Reviewer | FLAGS=STRICT,TRACE,LEAN | OP=SPEC→AUDIT
FLAVOR=👃 Sniffing the specification for bad hops...

## Audit Checklist (every item must be addressed)
- [ ] Ambiguities — requirements with multiple valid interpretations
- [ ] Race conditions — concurrent access, ordering assumptions
- [ ] Validation bounds — missing input constraints, null handling
- [ ] Authorization gaps — missing access control requirements
- [ ] Observability gaps — operations without logging or alerting
- [ ] Non-Goal conflicts — requirements contradicting stated non-goals
- [ ] Missing edge cases — empty inputs, max sizes, failure paths
- [ ] AC completeness — every requirement has a verifiable AC

## Severity Classification
BLOCKER | WARNING | SUGGESTION

## Verdict Rules
- Any BLOCKER → [BLOCKED] + required fixes
- No BLOCKER → [APPROVED] + warnings/suggestions

## Output Format
```
👃 Sniffing the specification for bad hops...

## Findings
| # | Category | Finding | Severity |

## Verdict: [APPROVED] / [BLOCKED]
### Required Fixes (if BLOCKED)
```

## Self-Validation
✓ Every checklist item explicitly addressed
✓ Verdict matches findings
✓ Required fixes are actionable
