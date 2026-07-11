# HoldMyBeer Engine Architecture

This document outlines the pipeline organization and change management system of HoldMyBeer.

---

## 1. Core Pipeline Flow

HoldMyBeer maps natural language specifications into a structured dependency graphs rather than using raw prompts to write files:

```
[Requirements] (Jira, Text, Epic)
      │
      ▼  (/hmb-crack)
[Project Model] (domain layer) ──> Validator (hmb-sniff check)
      │
      ▼  (/hmb-brew)
[Project Model] (enriched architecture/tasks) ──> Validator (hmb-ferment check)
      │
      ▼  (/hmb-pour)
[Active Task Code Generator]
      │
      ▼
[Production Code + Tests] ──> Pre-Merge Validator (hmb-hangover audit)
```

---

## 2. Change Management Pipeline (The Impact Engine)

When business requirements change mid-project:

```
[Requirement Evolution Details]
             │
             ▼
    [changed node ID]
             │
             ▼  (/hmb-impact)
    [Impact Engine Traversal]
             │
   ┌─────────┴─────────┐
   ▼                   ▼
 [Stale Nodes]    [Human Owned (Manual/Mixed)]
   │                   │
   ▼  (/hmb-pour)      ▼
(Auto-Regenerate)   (Block & Flag for Developer Review)
```

---

## 3. Structural Components

1. **Project Model (`psm.json`)**: The single source of truth. Contains three isolated namespaces (`domain`, `architecture`, `implementation`) linked by `relationships`.
2. **Reviewers / Validators**: Enforce complete trace mapping. E.g., verifying that every Feature belongs to a specific Task (`V.FEATURE_HAS_TASK`) and that every Requirement lists explicit Acceptance Criteria (`V.REQ_HAS_AC`).
3. **Generators**: Safe file modifiers that execute logic on task targets. Respect node `ownership` fields to avoid overwriting developer customizations.

---

## 4. Key Limitations

> [!IMPORTANT]
> **One-Way Synchronization (Model Drift)**
>
> Manual changes written directly into source files by developers are **not** reverse-synchronized back into the Project Model. Avoid altering model API or schema assumptions directly inside the codebase without updating the Project Model first; otherwise, subsequent updates will result in model drift. Ensure ownership properties are set to `"manual"` on custom files to protect them from downstream regeneration.
