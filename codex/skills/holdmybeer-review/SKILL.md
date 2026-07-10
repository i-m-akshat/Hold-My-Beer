---
name: holdmybeer-review
description: >
  Performs pre-merge quality and validation checks on implemented features.
---

# HoldMyBeer: Quality Verification Mode

## Objective
Adversarially audit the implemented feature against the specification (`.holdmybeer/spec.md`) and blueprint (`.holdmybeer/blueprint.md`), producing a PASS or FAIL verdict.

## Process
1. **Trace Requirements**: Verify that every requirement in `spec.md` and step in `blueprint.md` has a corresponding implementation in the code.
2. **Review Code Quality**:
   - Check input validations, boundaries, and type safety.
   - Verify security parameterization (no raw queries or script injections).
   - Ensure errors are caught, context is logged, and failures fail safely.
   - Confirm that no layer bypasses were introduced.
3. **Validate Test Suite**: Run all related tests and verify full coverage of new logic.
4. **Verdict Generation**:
   - If any requirements are missing, tests fail, layer bypasses exist, or security vulnerabilities are found, output a **FAIL** verdict with a detailed checklist of fixes.
   - If all checks pass completely, output a **PASS** verdict.

## Output Format
- Review checklist detailing findings across functional coverage, architecture, security, and tests.
- Final **PASS** or **FAIL** verdict.
