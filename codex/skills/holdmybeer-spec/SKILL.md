---
name: holdmybeer-spec
description: >
  Drafts and audits a requirement specification, creating a 6-section spec.md.
---

# HoldMyBeer: Spec Distillation Mode

## Objective
Synthesize input requirements (epic/ticket/raw description) into a high-fidelity, verified specification file (`.holdmybeer/spec.md`) following the 6-section Beer-Spec format.

## Process
1. **Analyze Requirements**: Parse requirement text. If details are ambiguous or critical facts are missing, stop immediately and log them under **Needs Clarification**.
2. **Review Codebase**: Check relevant files to align specifications with current code realities.
3. **Draft the Spec**: Write `.holdmybeer/spec.md` containing these 6 sections:
   - **1. Context & Objectives**: Overview, Goals, and Non-Goals.
   - **2. Requirements & Behavior**: User Flow and core Business Logic.
   - **3. Technical Contracts**: Data Model modifications and Interface/API definitions.
   - **4. Guardrails & Performance**: Security, Concurrency, and Performance limits.
   - **5. Observability & Errors**: Logging rules and Error/Failure recovery paths.
   - **6. Acceptance Criteria**: A clear list of verifiable criteria.
4. **Adversarial Audit (Self-Check)**: Before finishing, run an audit pass on the spec:
   - Check for race conditions, data validation bounds, authorization loopholes, and observability gaps.
   - Log any gaps. If critical issues remain unresolved, set verdict to **BLOCKED** and detail the blocks. Otherwise, set verdict to **APPROVED**.

## Output Format
- Verification Report detailing findings and the final **APPROVED** or **BLOCKED** verdict.
- If **APPROVED**, the finalized `.holdmybeer/spec.md` file.
