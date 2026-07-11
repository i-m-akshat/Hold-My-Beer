# HoldMyBeer for Gemini CLI

> **Change one requirement. Only the affected code regenerates. Your handwritten code stays untouched.**

HoldMyBeer is a Specification-Driven Development toolkit for Gemini CLI. It turns natural language requirements into structured specifications, implementation plans, production-ready code, and selective updates. 

Unlike traditional AI workflows, HoldMyBeer keeps an internal understanding of your project so requirement changes regenerate only affected artifacts instead of rewriting everything.

---

## Why HoldMyBeer?

```
Traditional AI Workflows:
Requirement changes ──> Regenerate everything ──> Overwrites manual edits & custom code

HoldMyBeer Workflows:
Requirement changes ──> Analyze impact ──> Regenerate only affected files ──> Preserve manual edits
```

---

## Core Workflow

```
Requirements
     │
     ▼
/hmb          (Initialize project workspace)
     │
     ▼
/hmb-crack    (Extract project requirements)
     │
     ▼
/hmb-sniff    (Validate specification quality)
     │
     ▼
/hmb-brew     (Generate system architecture)
     │
     ▼
/hmb-ferment  (Validate implementation plan)
     │
     ▼
/hmb-pour     (Generate implementation files)
     │
     ▼
/hmb-hangover (Run final project review)
```

---

## Flagship Feature: Change Management & Selective Regeneration (`/hmb-impact`)

If a requirement changes mid-project:
1. Run `/hmb-impact <requirement-id> "Description of update"`
2. The engine calculates the change impact blast radius:
   ```
   > /hmb-impact req-login-mfa "Login now requires email fallback"

   Calculating blast radius...
   
   Affected Code (Stale):
   ✓ auth_controller.js
   ✓ mfa_validator.js
   ✓ login_tests.js

   Preserved Code (Untouched):
   ✓ orders_controller.js
   ✓ payment_gateway.js
   ✓ cart_reducer.js

   Summary: 3 files flagged for regeneration. 132 custom developer files preserved.
   ```
3. Run `/hmb-pour` targeting specifically the stale tasks to update only the affected code, leaving your manual customizations safe.

---

## Commands Reference

| Command | Action | Description |
|---|---|---|
| `/hmb` | Initialize project | Prepares the workspace skeleton and repository rule definitions. |
| `/hmb-crack` | Extract requirements | Processes ticket text or descriptions to distill core requirements. |
| `/hmb-sniff` | Validate specification | Reviews requirements for missing edge cases or ambiguity. |
| `/hmb-brew` | Generate architecture | Plans models, APIs, and execution task sequences. |
| `/hmb-ferment` | Validate layout | Reviews the architecture blueprints for planning coverage. |
| `/hmb-pour` | Generate implementation | Implements code changes and runs verification tests. |
| `/hmb-hangover` | Run final project review | Audits complete codebase trace compliance before merging. |
| `/hmb-impact` | Analyze requirement changes | Traverses the impact blast radius of requirement changes. |

---

## Setup & Platform Specifics

### Installation
```bash
# Target Gemini CLI explicitly in the installer
./install.sh --platform gemini
# Or in PowerShell:
.\install.ps1 -Platform gemini
```

*For platform architecture details, TOML configuration layouts, and known differences from other clients, refer to the [Gemini Platform Guide](../docs/platforms/gemini.md).*
