# Customization

HoldMyBeer ships generic and reusable on purpose — no skill or command is tied to a specific language, framework, or repository. These are the supported ways to customize it without breaking that.

---

## Specialty Stack Constraints
HoldMyBeer intentionally has no project- or language-specific rules in the code generator. Layer project-specific rules (e.g. library syntax patterns or framework preferences) inside your project's local `.holdmybeer/constitution.md` file. The skills will automatically read this overrides file and apply the guidelines.

---

## 1. Custom Semantic Nodes & Properties

If you need to represent extra semantic concepts in the Project Semantic Model (PSM) (e.g., storing security credentials metadata, routing configurations, or deployment tags):
1. Document the nodes and properties inside `shared/MODEL_SCHEMA.md`.
2. Add your properties inside the appropriate namespace (`domain`, `architecture`, `implementation`) in `.holdmybeer/psm.json`.
3. Update the relevant skills to write or parse these keys.

---

## 2. Adding Custom Verification Rules

To enforce code standards or architectural constraints (e.g., forcing all controllers to belong to a specific package):
1. Define a rule ID (e.g. `V.ALL_CONTROLLERS_IN_API`) and verify logic in `shared/MODEL_VALIDATION.md`.
2. Assign the validator check to either `hmb-ferment` (architecture check) or `hmb-hangover` (implementation/code check) within their respective skills blocks.
3. The model will run the rule automatically against the PSM node graph.

---

## 3. Adding a New Query Fragment

To extract specific parts of the project semantic graph (e.g., retrieving only entities with database mappings):
1. Define the query ID (e.g. `Q.DATABASE_MODELS`) and its node/edge traversal rules in `shared/MODEL_QUERIES.md`.
2. Tell your skills to load the query target in their `OP` definition and `IN` field.

---

## 4. Extending the Engineering Constitution

The shared constitution lives in `shared/CONSTITUTION.md`. Edits here propagate automatically to Claude and Codex skills (which reference it via `<context>` tags).
For Gemini and Cursor rule adapters, you will need to update the compressed/inlined schema configurations or run the platform installer scripts again.
