---
name: holdmybeer-plan
description: >
  Converts an approved spec.md into a phased engineering roadmap (blueprint.md).
---

# HoldMyBeer: Blueprint Design Mode

## Objective
Convert an approved specification (`.holdmybeer/spec.md`) into a step-by-step technical implementation plan (`.holdmybeer/blueprint.md`) that maximizes reuse and guarantees safety.

## Process
1. **Assess Spec & Codebase**: Read the spec and inspect the affected directories/files.
2. **Reuse Inventory**: Search for existing functions, helper classes, and libraries that can fulfill the requirements. Avoid writing new code if existing logic can be extended.
3. **Design Blueprint**: Write `.holdmybeer/blueprint.md` containing:
   - **1. Architectural Alignment**: Reused components and modified layers.
   - **2. Phased Steps**: Atomic, step-by-step checklist. Each step must define:
     - Clear objective
     - Specific files to edit
     - Verification command (test command or check script)
   - **3. Rollback & Deployment**: Global verification commands and revert procedures.
4. **Stress Test (Self-Check)**: Run a stress-test review on the plan:
   - **YAGNI Check**: Flag unnecessary features.
   - **Layer Integrity**: Ensure no architectural layers are bypassed to shorten the diff.
   - **Security**: Verify all parameters are sanitized and secrets are externalized.
   - If gaps are found, log them and mark the plan as **BLOCKED**. Otherwise, mark it **APPROVED**.

## Output Format
- Verification Report detailing plan safety and the final **APPROVED** or **BLOCKED** verdict.
- If **APPROVED**, the finalized `.holdmybeer/blueprint.md` file.
