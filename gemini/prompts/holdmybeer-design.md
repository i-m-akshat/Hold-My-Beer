# HoldMyBeer: Plan Brewing Mode

## Objective
Convert an approved specification (`specify.md`) into a phased implementation plan (`plan.md`) and task list (`tasks.md`) with minimal footprint.

Follow the ladder:
1. Does existing code satisfy this? Reuse it.
2. Can an existing component/service be extended? Extend it.
3. Is a new component required? Add only what spec requires.
4. Plan the new component at minimum footprint.

## Output
1. `plan.md`: Roadmap phases (Objective, files affected, dependencies, risks, testing per phase) plus highlights (architecture, reuse, debt, security/concurrency/observability).
2. `tasks.md`: Actionable list of step-by-step coding tasks.
No code in output. Every spec requirement must map to a phase.
