# Philosophy

HoldMyBeer v0.3 represents a major architectural paradigm shift: **from prompt-based code generation to a safe, model-driven change management workflow.**

---

## The Core Shifts

### 1. Markdown is Documentation. The Project Model is Reality.
Traditional AI coding agents operate on text files, constantly converting markdown (spec.md -> plan.md -> tasks.md) back and forth. This introduces context loss, hallucination, and massive token bloats. 
HoldMyBeer translates the project structure into an internal schema-enforced dependency graph: the **Project Model** stored at `.holdmybeer/psm.json`. Markdown files are only generated as user-facing human exports.

### 2. Safeguarding Manual Edits via Ownership Mappings
Unlike agentic builders that blindly overwrite developer progress, HoldMyBeer respects manual edits. Files (Artifacts) can be assigned `"ownership": "manual"` or `"ownership": "mixed"`. Once configured, the automated builder (`hmb-pour`) and the Impact Engine (`hmb-impact`) will preserve these files and flag them for human verification/merge rather than overwriting.

### 3. Change Management > Code Generation (The Impact Engine)
The value of HoldMyBeer is not in writing code from scratch, but in managing software evolution. When requirements change:
- You inject the change at a specific requirement node.
- The **Impact Engine** calculates the downstream blast radius and marks affected nodes *stale*.
- The builder regenerates *only* the stale, `"generated"` artifacts and tests, preserving the rest of the codebase untouched.

---

## Key Development Assumptions & Limitations

> [!WARNING]
> **No Reverse-Synchronization (Model Drift)**
> Custom edits made by developers directly inside the codebase are **not** back-imported or reverse-synchronized into the Project Model. The pipeline flow is one-way: `Requirements ──> Project Model ──> Codebase`.
> To prevent model drift, always modify requirements and architectural models inside the Project Model first before generating updates.

### Futures: Symbol-Level Granularity
This version executes overrides at the **file level**. In complex codebases, developers may customize some methods in a file while wanting others auto-generated. In subsequent improvements, the Artifact scope can expand to class/method symbols, enabling granular symbol-level ownership division.

---

## The 5 Engineering Laws of HoldMyBeer

1. **Don't guess**: If information is missing during extraction, assign low confidence. Low confidence blocks downstream steps, forcing clarity before code is written.
2. **Follow the Reuse Ladder**: Do not invent new structures if the stdlib or existing components solve the problem.
3. **Be Adversarial**: Sniffers, Ferments, and Handovers are designed to find reasons to reject work, not rubber-stamp it.
4. **Enforce Complete Traceability**: Every requirement must trace through features, tasks, and code classes directly to a test block.
5. **No Hallucinated Terminology**: The graph is an internal blueprint contract. The user-facing output must always present findings in plain English (features, files, tasks), shielding users from developer/graph-theory jargon.
