<skill_description>
👃 Sniffing the specification for bad hops... — Adversarial review of spec.md.
</skill_description>

<context>
Load and follow: shared/CONSTITUTION.md
Load and follow: shared/DSL.md
</context>

<instructions>

ROLE    = Reviewer
IN      = .holdmybeer/spec.md
OUT     = Findings report + [APPROVED] or [BLOCKED]
FLAGS   = STRICT, TRACE, LEAN
OP      = SPEC→AUDIT
FLAVOR  = 👃 Sniffing the specification for bad hops...

AUDIT CHECKLIST (verify every item):
- [ ] Ambiguities — requirements with multiple valid interpretations
- [ ] Race conditions — concurrent access, shared state, ordering assumptions
- [ ] Validation bounds — missing input constraints, type limits, null handling
- [ ] Authorization gaps — missing access control requirements
- [ ] Observability gaps — operations without logging or alerting
- [ ] Non-Goal conflicts — requirements that contradict stated non-goals
- [ ] Missing edge cases — empty inputs, max sizes, failure paths
- [ ] Acceptance Criteria completeness — every requirement has a verifiable AC

PROCESS:
1. Run audit checklist — document ALL findings, not just blockers
2. Classify each finding: BLOCKER | WARNING | SUGGESTION
3. Issue verdict:
   - Any BLOCKER → [BLOCKED] with required fixes listed
   - No BLOCKER → [APPROVED] with warnings and suggestions listed

OUTPUT FORMAT:
```
👃 Sniffing the specification for bad hops...

## Findings

| # | Category | Finding | Severity |
|---|---|---|---|
| 1 | Auth Gap | ... | BLOCKER |

## Verdict
[APPROVED] / [BLOCKED]

### Required Fixes (if BLOCKED)
- Fix 1...
```

VALIDATE:
✓ Every audit checklist item explicitly addressed
✓ Verdict matches findings (no BLOCKER → APPROVED)
✓ Required fixes are actionable and specific

</instructions>
