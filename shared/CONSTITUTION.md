# 🍺 HoldMyBeer Engineering Constitution

All HoldMyBeer skills inherit this constitution. It is the single source of truth for engineering standards.

---

## Flags

| Flag | Meaning |
|---|---|
| `STRICT` | Zero tolerance for ambiguity. Halt and ask if input is unclear. |
| `TRACE` | Every output must trace back to a spec requirement or plan step. |
| `LEAN` | No unnecessary abstractions, patterns, or code. Simplest correct solution wins. |
| `COMPLETE` | Output must cover 100% of input requirements. No partial deliveries. |
| `SAFE` | Validate inputs, parameterize queries, protect secrets, never expose credentials. |
| `MD` | Output as structured Markdown with headers, tables, and checklists. |
| `TEST` | Every new logic path must have a corresponding test. Design for testability. |
| `IDEMPOTENT` | Running the same operation twice must produce the same result. Never overwrite without confirmation. |

---

## Architecture Principles

```
SOLID · DRY · KISS · YAGNI · Separation of Concerns
Dependency Injection · High Cohesion · Low Coupling
Composition over Inheritance · Clean Architecture
```

**Anti-patterns (never introduce):**
- God classes
- Service locators
- Tight coupling to transport layers
- Circular dependencies
- Shared mutable state without synchronization

---

## Code Quality

```
Readable    > Clever
Maintainable > Short
Simple      > Complex
Explicit    > Implicit
```

**Banned:**
- `// TODO` or `// FIXME` — finish it or document why not
- Placeholder implementations — every function body is production-ready
- Dead code — delete it, don't comment it out
- Speculative features — build what the spec says, nothing more
- Magic numbers — extract to named constants
- Swallowed exceptions — handle, wrap, or propagate

---

## Naming

| Element | Convention | Example |
|---|---|---|
| Classes | Noun, singular, PascalCase | `OrderService`, `UserRepository` |
| Methods | Verb phrase, camelCase/PascalCase | `calculateTotal`, `FindById` |
| Booleans | `Is`/`Can`/`Has`/`Should` prefix | `IsEnabled`, `CanDelete`, `HasPermission` |
| Collections | Plural | `orders`, `activeUsers` |
| Constants | UPPER_SNAKE or PascalCase | `MAX_RETRY_COUNT` |

**Banned names:** `Manager`, `Helper`, `Utility`, `Stuff`, `Temp`, `Obj`, `Data`, `Info`, `Foo`, `Bar`, `Baz`

---

## Methods

- Single responsibility
- Max 1 level of nesting preferred, 2 max
- Return early on guard clauses
- No side effects unless explicitly documented
- Pure functions where possible

## Classes

- One responsibility
- Minimal constructor dependencies (≤5)
- Accept dependencies via injection, never construct them
- No God classes (>300 LOC is a smell)

---

## Error Handling

- Fail fast at boundaries
- Meaningful exception types with context
- Never catch-and-ignore
- Graceful degradation for non-critical paths
- Log errors with correlation context

---

## Security

- Validate all external input at trust boundaries
- Parameterize all queries (zero string concatenation for SQL)
- Secrets via environment/vault only — never in code or config files
- Least privilege for all service accounts
- Sanitize output to prevent injection (XSS, SSTI)

---

## Performance

- Avoid N+1 queries
- Batch I/O operations
- No premature optimization — profile first
- Never sacrifice readability for micro-optimization
- Cache expensive computations with explicit invalidation

---

## Testing

- Unit test every public method with non-trivial logic
- Mock external dependencies at boundaries
- Include edge cases: null, empty, boundary values, concurrent access
- Tests are documentation — name them `Should_ExpectedBehavior_When_Condition`
- No test interdependencies

---

## Documentation

- Document **WHY**, never **WHAT**
- Document public API contracts
- Keep comments current or delete them
- README per module if non-obvious

---

## Decision Priority

When multiple implementations are valid, choose in this order:

```
1. Correctness
2. Readability
3. Maintainability
4. Reusability
5. Simplicity
6. Testability
7. Performance
```

---

## Over-Engineering Guard

Do NOT introduce unless solving a measured, real problem:

```
Factories · Repositories · Interfaces · Builders
Mediators · Decorators · Adapters · Abstract Services
```

**The simplest maintainable solution always wins.**

---

## Self-Validation Checklist

Before returning ANY output, internally verify:

```
✓ Requirement coverage — every input requirement has a traced output
✓ No hallucinated features — nothing added beyond what was asked
✓ No missing functionality — nothing omitted from what was asked
✓ SOLID compliance
✓ DRY — no duplicated logic
✓ KISS — simplest correct approach
✓ YAGNI — nothing speculative
✓ Naming conventions followed
✓ Dependency injection used (no service locators, no `new` in business logic)
✓ Reusability — extracted shared logic
✓ Maintainability — future developer can understand in <5 min
✓ Readability — no clever tricks
✓ Testability — all logic is testable in isolation
✓ Production readiness — no TODOs, no placeholders, no stubs
```

**If any check fails, improve the output before returning it.**
