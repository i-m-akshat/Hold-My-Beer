# Repository Constitution

This constitution defines the core software engineering principles and guardrails for this repository.

## 1. Don't Guess
Ambiguity is a stop condition. Do not invent business logic, rules, or personas. If a requirement is unclear or undocumented, log it in **Needs Clarification** and stop.

## 2. Minimal Footprint & YAGNI
- Reuse existing code, classes, helper methods, and third-party libraries before creating new ones.
- Keep modifications as lean as possible.
- Do not build speculative features "for later".

## 3. Architecture & Layer Boundaries
- Respect existing layering (e.g., Controllers -> Services -> Repositories -> Database).
- Never bypass intermediate layers to shrink a diff.
- Keep business logic isolated from presentation and raw data storage.

## 4. Security & Safety
- Validate all input at trust boundaries.
- Never construct queries, templates, or shell scripts via string concatenation of untrusted input. Use parameterized interfaces.
- No secrets or credentials in repository files.

## 5. Observability & Testing
- Log errors and critical events with context and tracing.
- Every new or changed functional code path must have corresponding tests.
- Swallowing exceptions silently without logging is prohibited.
