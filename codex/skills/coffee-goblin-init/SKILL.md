---
name: coffee-goblin-init
description: >
  Check for existing SDD structures (.specify, .gsd, specify.md, constitution.md)
  and initialize standard templates if none exist.
---

# Coffee Goblin: Coffee Goblin Initialization Mode

## Objective
Detect existing Spec-Driven Development (SDD) structures (.specify, .gsd, specify.md, plan.md, etc.) and initialize a standard SDD folder/templates if none are found.

## Expected Input
Optional target directory path (defaults to current directory).

## Output
- Diagnostic report of existing SDD configuration (if found).
- Newly initialized standard SDD structure (if missing and approved/requested).

## Process
1. Scan the target directory for:
   - Spec Kit: `.specify/`, `constitution.md`, `specify.config.json`
   - GSD: `.gsd/`, `gsd.config.json`, `.gsd.json`
   - Generic/Coffee Goblin: `specify.md`, `plan.md`, `tasks.md`, `SPEC.md`, `PLAN.md`, `TASKS.md`
2. If any are found:
   - Output a list of found components.
   - Explain how they align with Spec Kit, GSD, or Coffee Goblin.
   - Stop and do not overwrite anything.
3. If none are found:
   - Ask the user (or confirm) if they want to initialize the project for SDD.
   - Create a `.specify/` folder with these template files:
     - `.specify/specify.md` (Spec template listing the 23 required sections)
     - `.specify/plan.md` (Phased roadmap template)
     - `.specify/tasks.md` (Actionable task list template)
     - `.specify/constitution.md` (Project rules/coding standards template)
   - Output a success message with instructions on how to use them.

## Guardrails
- Never overwrite existing files or folders.
- Use minimal footprint; do not install external binaries or node modules.
- Ensure all templates are language/framework agnostic.
