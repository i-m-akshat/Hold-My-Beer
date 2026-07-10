---
name: holdmybeer-init
description: >
  Check for existing SDD structures and initialize HoldMyBeer templates and a beautiful HTML dashboard.
---

# HoldMyBeer: Initialization Mode

## Objective
Detect existing SDD structures (.specify, .holdmybeer, .gsd, etc.) and initialize a premium HoldMyBeer SDD workspace if none are found.

## Expected Input
Optional target directory path (defaults to current directory).

## Output
- Diagnostic report of existing SDD configuration (if found).
- A newly initialized `.specify/` folder with templates (`specify.md`, `plan.md`, `tasks.md`, `constitution.md`, and a premium interactive `dashboard.html`).
- A highly polished terminal interface with ANSI colors, ASCII logo, and clear instructions.

## Process
1. Scan target directory for:
   - Spec Kit / HoldMyBeer: `.specify/`, `constitution.md`, `specify.config.json`
   - GSD: `.gsd/`, gsd config files
   - Generic: `specify.md`, `plan.md`, `tasks.md`, `SPEC.md`, `PLAN.md`
2. If any exist:
   - Output a list of found components.
   - Explain how they align with SDD.
   - Stop and do not overwrite.
3. If none exist:
   - Confirm and initialize a `.specify/` directory.
   - Create these files:
     - `.specify/specify.md`: Spec template (the 23 sections: Executive Summary, Goals, Non-goals, Scope, Functional, Non-functional, Business Rules, Data Model, API, UI, Permissions, Security, Concurrency, Observability, Edge Cases, Error Handling, Validation, Performance, Acceptance Criteria, Out of Scope, Open Questions, Risks, Needs Clarification).
     - `.specify/plan.md`: Roadmap phases (Phases 1, 2, ... with objective, files affected, dependencies, risks, testing) + highlights.
     - `.specify/tasks.md`: Task checklist.
     - `.specify/constitution.md`: Coding standards, layered architecture rules, security, concurrency, testing, and observability guidelines.
     - `.specify/dashboard.html`: A premium local HTML dashboard (dark mode, glassmorphic card layouts,Outfit font, gold/purple gradients, tab switching for files, copy-to-clipboard command shortcuts, and an interactive SDD pipeline progress visualizer).
   - Display a beautiful success message in the terminal:
     - Print the ASCII logo "HoldMyBeer" in bold gold.
     - Detail the created files.
     - Guide the user to open `dashboard.html` in their browser.

## Guardrails
- Never overwrite existing files.
- Ensure all templates are language/framework agnostic.
- Ensure `dashboard.html` uses purely local frontend resources (CSS/JS embedded, fonts from Google Fonts CDN) so it opens instantly via `file://`.
