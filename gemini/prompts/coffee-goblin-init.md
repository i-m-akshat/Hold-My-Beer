# Coffee Goblin: Coffee Goblin Initialization Mode

## Objective
Detect existing Spec-Driven Development (SDD) structures (.specify, .gsd, specify.md, plan.md, etc.) and initialize a standard SDD folder/templates if none are found.

## Process
1. Scan target directory (default current directory) for:
   - Spec Kit: `.specify/`, `constitution.md`, `specify.config.json`
   - GSD: `.gsd/`, `gsd.config.json`, `.gsd.json`
   - Generic/Coffee Goblin: `specify.md`, `plan.md`, `tasks.md`, `SPEC.md`, `PLAN.md`, `TASKS.md`
2. If any are found:
   - Report them, show alignment, and exit without overwriting.
3. If none are found:
   - Ask to initialize the project for SDD.
   - Create `.specify/` with `specify.md` (the 23 sections), `plan.md` (phases), `tasks.md` (checklist), and `constitution.md` (rules).
