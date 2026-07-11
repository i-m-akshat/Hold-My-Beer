# Workflow

```
             Requirements / Changes
                     │
                   hmb              🍺 Opening a tab...
                     │
                 hmb-crack          🍺 Cracking open a fresh specification...
                     │
                 hmb-sniff          👃 Sniffing for bad hops...
                     │
                  hmb-brew          🍻 Brewing the perfect architecture...
                     │
                hmb-ferment         🧪 Fermenting under pressure...
                     │
                  hmb-pour          🍺 Hold my beer... (implements tasks)
                     │
               hmb-hangover         🤕 Checking tomorrow morning's hangover...
                     │
               [Change Injected]
                     │
                 hmb-impact         ⚡ Calculating blast radius...
                     │
                  hmb-pour          (regenerates only stale items)
                     │
                   Merge
```

HoldMyBeer v0.3 uses the **Project Semantic Model (PSM)** (`.holdmybeer/psm.json`) as the single source of truth. Markdown files (`spec.md`, `blueprint.md`) are generated as human-readable **exports** — they are not directly transformed. The PSM enables precise change management and incremental updates.

---

## Stage by Stage

| Command | Input | Output | Purpose / Verdict |
|---|---|---|---|
| `/hmb` | Target directory | `.holdmybeer/` workspace | Initializes `psm.json` scaffold & `constitution.md`. |
| `/hmb-crack` | Requirements text | `psm.json` + `spec.md` | Extracts domain requirements/features to PSM. |
| `/hmb-sniff` | `psm.json` | Approved status | Runs `V.REQ_HAS_FEATURE` and `V.REQ_HAS_AC`. |
| `/hmb-brew` | Approved `psm.json` | `psm.json` + `blueprint.md` | Designs APIs, database entities, and maps tasks/artifacts. |
| `/hmb-ferment` | `psm.json` | Approved status | Runs `V.FEATURE_HAS_TASK` and `V.TEST_COVERS_FEATURE`. |
| `/hmb-pour` | Task ID & `psm.json` | Code & tests + Task complete | Generates code step-by-step. Respects `protected` files. |
| `/hmb-hangover` | `psm.json` + Codebase | Trace matrix | Pre-merge compliance verification (V1-V8 validation). |
| `/hmb-impact` | Changed Node ID + Details | `psm.json` (stale states) | Blast radius analysis of changes; triggers selective regen. |

---

## Incremental Change Management (The Impact Engine)

The key differentiator of HoldMyBeer is how it handles requirements drift. If a requirement changes mid-project:

1. Identify the changed Requirement ID (e.g. `req-user-login-mfa`).
2. Run `/hmb-impact req-user-login-mfa "Now requires email OTP in addition to SMS"`.
3. The **Impact Engine** traverses the dependency graph and marks all downstream Features, Tasks, Artifacts (code files), and Tests as `stale`.
4. It checks for `protected` code files (manually edited files marked `"protected": true`). It keeps these intact and flags them for manual review rather than overwriting.
5. You run `/hmb-pour` only targeting the `stale` items to incrementally heal the codebase, leaving all other structures safe.

---

## Example Run

```bash
# 1. Initialize
/hmb
# Creates .holdmybeer/psm.json and constitution.md

# 2. Extract domain spec
/hmb-crack Add MFA support to login.
# Updates psm.json domain layer and exports spec.md

# 3. Validate domain
/hmb-sniff
# Exit: [APPROVED]

# 4. Phase architecture
/hmb-brew
# Richly populates API, Entity, Task, and Artifact nodes. Exports blueprint.md

# 5. Review architecture coverage
/hmb-ferment
# Exit: [APPROVED]

# 6. Execute step implementation
/hmb-pour task-implement-mfa-otp
# Implements code & test file and runs test verification.

# 7. Pre-merge compliance audit
/hmb-hangover
# Exit: [PASS]
```
