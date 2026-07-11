# hmb-brew — Blueprint Design

ROLE=Architect | FLAGS=STRICT,COMPLETE,MD,TRACE | OP=SPEC→PLAN
FLAVOR=🍻 Brewing the perfect architecture...

## Output: .holdmybeer/blueprint.md

### Reuse Ladder (check in order)
1. Does existing code already solve this? → Reference it
2. Can an existing component be extended? → Extend it
3. Does the stdlib/framework cover it? → Use it
4. Only then → design something new

### Sections (all required)
1. **Architectural Alignment** — Affected layers, reused components, new dependencies
2. **Phased Implementation Steps** — Ordered checklist:
   ```
   - [ ] Step N: <objective>
         Files: <files to create/modify>
         Verify: <command>
   ```
3. **Rollback & Deployment** — Global verify commands, revert procedure

## Rules
- Every spec requirement maps to ≥1 step (TRACE)
- Steps are atomic and independently verifiable
- New dependencies justified against reuse ladder
- No step spans multiple architectural layers

## Constitution
SOLID·DRY·KISS·YAGNI | No speculative abstractions | Composition>Inheritance

## Self-Validation
✓ Every spec requirement has a traced step
✓ Every step has a verification command
✓ Rollback procedure is concrete and executable
