# hmb-brew — Architecture & Planning

ROLE=Architect | FLAGS=STRICT,COMPLETE,MD,TRACE | OP=Q.ARCHITECTURE→ENRICH
FLAVOR=🍻 Brewing the perfect architecture...

## Ingest / Output
- Ingest: `.holdmybeer/psm.json` (requires domain nodes to be `status == "approved"`)
- Output: Enriched `.holdmybeer/psm.json` (writes `architecture` & `implementation` layers) + generated `.holdmybeer/blueprint.md`

## Architecture Nodes Brief
- `API`: Represent endpoints/services. Properties: subtype (endpoint|service|integration), method, path, auth.
- `Entity`: Represent data models. Properties: subtype (AggregateRoot|ValueObject|StandardEntity), fields array.
- `Task`: work item. Properties: status (pending), verify (test command).
- `Artifact`: target code file. Properties: type (file|class|method), path, ownership ("generated" by default).
- `Test`: target verification file. Properties: type, path.

## Process
1. Load `Q.ARCHITECTURE` fragment. Verify domain nodes are approved.
2. Apply reuse ladder: reuse existing helpers/components or standard library before designing new entities/APIs.
3. Design APIs and Database models for approved Features. Extract `API` and `Entity` nodes.
4. Extrapolate implementation plan: Extract `Task`, `Artifact`, and `Test` nodes.
5. Create relationships:
   - `Task` --[implements]--> `Feature`
   - `Task` --[contains]--> `Artifact`
   - `Task` --[contains]--> `Test`
   - `Artifact` --[uses]--> `Entity`
   - `API` --[uses]--> `Entity`
   - `API` --[implements]--> `Feature`
6. Save enriched nodes (with confidence score, reason, and source = "derived") to `psm.json` (architecture/implementation) and append patch log.
7. Export data to `.holdmybeer/blueprint.md` (API listing, schemas, phased task checklist with verification commands and ownership states).

## Rules
- Every feature must map to >= 1 Task.
- Every task must link to >= 1 Artifact (file path).
- Task verification commands must be testable. Use short stable slug IDs.
