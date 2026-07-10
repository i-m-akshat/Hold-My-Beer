---
name: brew-plan
description: >
  Convert an approved spec (specify.md) into a phased technical plan (plan.md & tasks.md).
  Enforces reuse-first and minimal footprint.
---

# Coffee Goblin: Plan Brewing Mode

## Objective
Convert an approved specification (`specify.md`) into a phased technical plan (`plan.md`) and task list (`tasks.md`) with the smallest footprint.

## Input
Approved specification.

## Output
1. `plan.md`:
   - Phased Roadmap (Phases 1, 2, ...): Objective, files affected, dependencies, risks, testing.
   - Architectural decisions, reuse opportunities, tech debt, security/concurrency/observability additions.
2. `tasks.md`:
   - Actionable list of discrete, step-by-step coding tasks.

## Process
Before planning, study the repo (architecture, APIs, services, databases).
Follow the "Ladder" (stop at first rung that holds):
1. Does existing code satisfy this? Reuse it.
2. Can an existing component/service be extended? Extend it.
3. Is a new component required? Add only what spec requires.
4. Plan the new component at minimum footprint.

*Optimization*: For complex codebases, spawn a `research` subagent to check for existing components and reuse candidates, keeping the main context clean.

## Guardrails
- No architectural changes unless required by spec.
- No code in output—roadmap and tasks only.
- Every spec requirement must map to a phase, and vice versa.
