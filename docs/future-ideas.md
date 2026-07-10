# Future Ideas

Parked proposals — not designed, not scheduled. Notes here are flags for a
future brainstorming pass, not commitments.

## Workspace detection & auto-init

Have every Coffee Goblin skill start by detecting whether the project
already uses a Spec-Driven Development workspace (e.g. `.specify/` for
spec-kit, `.planning/` for GSD) and adapt to it instead of scattering
loose files in the repo root. If none is found, initialize Coffee
Goblin's own `.coffee-goblin/` workspace with numbered feature dirs
(`specs/001-user-authentication/{epic,spec,research,plan,implementation,review}.md`),
auto-incrementing numbering, and a `config.yml`.

Would need its own full brainstorming pass before implementation,
covering (non-exhaustive):

- Correct detection list — the original proposal listed `.gsd/`, but
  GSD's real workspace directory is `.planning/`. Needs verification
  against actual conventions rather than guessed names before anything
  is hardcoded.
- Whether to silently adopt any detected workspace vs. asking when the
  structure isn't cleanly compatible.
- Which platforms get it (Claude Code only vs. also Codex/Gemini/Cursor)
  given the 4 adapters currently duplicate prompt text with no shared
  include mechanism.
- How this interacts with today's explicit file-path arguments (e.g.
  `/sniff-spec SPEC-x.md`, `/ship-it SPEC-x.md PLAN-x.md src/`) —
  whether workspace inference replaces, supplements, or is overridden
  by an explicit path.
