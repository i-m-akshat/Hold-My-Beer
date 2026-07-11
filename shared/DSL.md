# 🍺 HoldMyBeer DSL Dictionary

Symbolic operations used across all HoldMyBeer skills. Use these instead of prose.

---

## Pipeline Operations

| Operation | Meaning |
|---|---|
| `INIT→WORKSPACE` | Scan for existing SDD structures; initialize if absent |
| `INPUT→SPEC` | Distill raw requirements into a verified specification |
| `SPEC→AUDIT` | Adversarially review specification for gaps and risks |
| `SPEC→PLAN` | Convert approved specification into phased implementation plan |
| `PLAN→AUDIT` | Stress-test plan for architectural risk and missing work |
| `PLAN→CODE` | Implement plan steps as production code |
| `CODE→REVIEW` | Audit implementation against spec and plan |
| `REVIEW→FIX` | Apply fixes from review findings |
| `SPEC→TESTS` | Derive test cases from specification |

---

## Gate Verdicts

| Verdict | Meaning |
|---|---|
| `[APPROVED]` | Gate passed. Proceed to next stage. |
| `[BLOCKED]` | Gate failed. Fix artifact upstream, re-run this gate. |
| `[PASS]` | Final review passed. Safe to merge. |
| `[FAIL]` | Final review failed. Issues list attached. |

---

## Roles

| Role | Responsibility |
|---|---|
| `Bartender` | Workspace initialization and environment setup |
| `Planner` | Requirement distillation and specification authoring |
| `Reviewer` | Adversarial review, gap analysis, risk identification |
| `Architect` | System design, implementation planning, phased decomposition |
| `Builder` | Production code implementation following approved plans |
| `Auditor` | Final pre-merge quality and compliance verification |

---

## Flags (reference → CONSTITUTION.md)

```
STRICT · TRACE · LEAN · COMPLETE · SAFE · MD · TEST · IDEMPOTENT
```

---

## Skill Skeleton

Every skill follows this exact structure:

```
ROLE    = <from Roles table>
IN      = <input files or artifacts>
OUT     = <output files or artifacts>
FLAGS   = <comma-separated flags>
OP      = <from Pipeline Operations>
FLAVOR  = <beer theme message>
SECTIONS = <ordered output structure>
RULES   = <skill-specific constraints>
VALIDATE = <self-check items beyond constitution>
```
