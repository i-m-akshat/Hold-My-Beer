<skill_description>
🍻 Brewing the perfect architecture... — Converts approved spec to architecture nodes in the Project Model and exports blueprint.md.
</skill_description>

<context>
Load and follow: shared/CONSTITUTION.md
Load and follow: shared/DSL.md
Load and follow: shared/MODEL_SCHEMA.md
</context>

<instructions>

ROLE    = Architect
IN      = .holdmybeer/psm.json (domain nodes must have status == "approved")
OUT     = Enriched .holdmybeer/psm.json (architecture + implementation layer) + generated .holdmybeer/blueprint.md
FLAGS   = STRICT, COMPLETE, MD, TRACE
OP      = Q.ARCHITECTURE→ENRICH
FLAVOR  = 🍻 Brewing the perfect architecture...

REUSE LADDER (apply before proposing new artifacts):
1. Identify if existing codebase resolves the implementation.
2. Extend or parameterize an existing service or component.
3. Utilize stdlib/framework features.
4. Only then design new Entities, APIs, or Tasks.

PROCESS:
1. Load `Q.ARCHITECTURE` fragment from `.holdmybeer/psm.json`. Confirm domain nodes are approved.
2. Design the system interfaces and models for the approved Features:
   - Extract `API` nodes (represent endpoints, internal services, integrations).
   - Extract `Entity` nodes (represent data tables, models, value objects).
3. Generate structured implementation tasks:
   - Extract `Task` nodes. Assign `verify` verification test commands.
   - Define projected `Artifact` nodes (target source files) to be created or modified. Set `ownership = "generated"` by default.
   - Define projected `Test` nodes (target test files).
4. Establish relationships:
   - `Task` --[implements]--> `Feature`
   - `Task` --[contains]--> `Artifact`
   - `Task` --[contains]--> `Test`
   - `Artifact` --[uses]--> `Entity`
   - `API` --[uses]--> `Entity`
   - `API` --[implements]--> `Feature`
5. Save additions back to `psm.json`:
   - Write nodes to `architecture` and `implementation` namespaces.
   - Assign `confidence` objects containing score, reason, and source = "derived" to all new nodes.
   - Append delta log entry to `patches`.
6. Export domain, architecture, and task schema to a clean `.holdmybeer/blueprint.md`:
   - Summary of API endpoints, Database schema/Models, and Dependency ordering.
   - Phased checklist of implementation Steps (with file paths, ownership status, and test validation commands).

RULES:
- Every active Feature must trace to at least one Task (`implements`).
- Every Task must target at least one Artifact file path (`contains`).
- Task verification commands must be concrete and testable.

VALIDATE:
✓ psm.json is updated with new database Entities, API schemas, and Task sequences.
✓ Every new Entity, API, and Task has a unique, short stable slug ID.
✓ `patches` contains a log entry for the brew operation.
✓ Generated `.holdmybeer/blueprint.md` matches the Project Model data exactly.

</instructions>
