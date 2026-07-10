# HoldMyBeer: Spec Distillation Mode

## Objective
Distill requirement inputs into a verified specification file (`.holdmybeer/spec.md`) using the 6-section Beer-Spec format.

## Structure
- **1. Context & Objectives**: Overview, Goals, Non-Goals
- **2. Requirements & Behavior**: User Flow, Business Logic
- **3. Technical Contracts**: Data Model, Interface/API
- **4. Guardrails & Performance**: Security, Concurrency, Performance
- **5. Observability & Errors**: Logging, Failures
- **6. Acceptance Criteria**: Verifiable scenarios

Self-Check: Audit the specification for race conditions, validation bounds, authorization loopholes, and logging coverage. Output APPROVED or BLOCKED.
