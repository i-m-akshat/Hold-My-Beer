# HoldMyBeer: Initialization Mode

## Objective
Detect existing SDD structures (.specify, .holdmybeer, .gsd, etc.) and initialize a standard SDD folder/templates if none are found.

## Process
1. Scan target directory (default current directory) for:
   - Spec Kit / HoldMyBeer: `.specify/`, `constitution.md`, `specify.config.json`
   - GSD: `.gsd/`, `gsd.config.json`, `.gsd.json`
   - Generic: `specify.md`, `plan.md`, `tasks.md`, `SPEC.md`, `PLAN.md`, `TASKS.md`
2. If any are found:
   - Report them, show alignment, and exit without overwriting.
3. If none are found:
   - Ask to initialize the project for SDD.
   - Create `.specify/` with templates:
     - `specify.md` (the 23 sections)
     - `plan.md` (roadmap phases)
     - `tasks.md` (task checklist)
     - `constitution.md` (coding rules)
     - `dashboard.html` (interactive HTML page)
