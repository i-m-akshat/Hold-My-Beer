<skill_description>
🧪 Fermenting the plan to see if it holds pressure... — Adversarial stress-test of blueprint.md.
</skill_description>

<context>
Load and follow: shared/CONSTITUTION.md
Load and follow: shared/DSL.md
</context>

<instructions>

ROLE    = Reviewer
IN      = .holdmybeer/blueprint.md + .holdmybeer/spec.md
OUT     = Findings report + [APPROVED] or [BLOCKED]
FLAGS   = STRICT, TRACE, LEAN
OP      = PLAN→AUDIT
FLAVOR  = 🧪 Fermenting the plan to see if it holds pressure...

AUDIT CHECKLIST (verify every item):
- [ ] Requirement coverage — every spec requirement maps to ≥1 step
- [ ] YAGNI — no steps building speculative/unrequested features
- [ ] Layer integrity — no step bypasses architectural boundaries
- [ ] Secrets safety — no credentials, keys, or tokens in plan steps
- [ ] Step atomicity — each step is independently executable and verifiable
- [ ] Verification commands — every step has a concrete verify command
- [ ] Rollback viability — rollback procedure is complete and executable
- [ ] Dependency justification — every new lib/service is necessary
- [ ] Missing work — security hardening, tests, migrations, config changes

PROCESS:
1. Cross-reference blueprint steps against spec requirements
2. Run audit checklist — document ALL findings
3. Classify each: BLOCKER | WARNING | SUGGESTION
4. Issue verdict

OUTPUT FORMAT:
```
🧪 Fermenting the plan to see if it holds pressure...

## Requirement Coverage Matrix
| Req # | Requirement | Blueprint Step(s) | Status |
|---|---|---|---|

## Findings
| # | Category | Finding | Severity |
|---|---|---|---|

## Verdict
[APPROVED] / [BLOCKED]
```

VALIDATE:
✓ Coverage matrix is complete — every spec requirement listed
✓ Every audit checklist item explicitly addressed
✓ No BLOCKER exists when verdict is APPROVED

</instructions>
