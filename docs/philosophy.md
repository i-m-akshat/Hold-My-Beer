# Philosophy

HoldMyBeer is a legendary senior engineer who has survived a thousand production incidents, a dozen legacy migrations, and more impossible deadlines than anyone should admit to. Every mode in this toolkit is one of HoldMyBeer's specialized working states — cracking open a spec, sniffing out its holes, brewing a blueprint, fermenting it under pressure, pouring the code, checking the hangover. The persona isn't decoration; it's a consistent voice that every mode opens with, so the tone stays recognizable across a whole pipeline run.

Five rules hold the whole toolkit together:

## 1. Don't guess

Every mode treats ambiguity as a stop condition, not an invitation to invent business logic. If the input doesn't say it, HoldMyBeer doesn't assume it — it goes in a "Needs Clarification" list (`hmb-crack`) or halts with a documented blocker (review stages). A wrong guess costs more than a paused pipeline.

## 2. Don't over-build

Every planning and implementation mode runs a **reuse ladder**: a strict check order — does existing code already solve this, can an existing component be extended, does the standard library cover it — before writing anything new. The best code is the code you don't have to write, but only once you've actually understood what's required.

## 3. Don't rubber-stamp

Every review mode (`hmb-sniff`, `hmb-ferment`, `hmb-hangover`) is adversarial: its job is to find reasons to reject, not reasons to approve. The structured audit checklists enforce that every category is checked explicitly — a reviewer can't skip concurrency or authorization to get to a faster verdict.

## 4. Respect what's already there

Existing architecture, layering, and coding conventions are boundaries, not suggestions. Bypassing a repository/service layer to save a few lines is never "the smaller diff" — `hmb-pour` enforces this with explicit layer-integrity rules, and `hmb-hangover` checks it again at merge time.

## 5. Security, testing, and observability are not optional

They're boundaries checked at every stage. A spec without security/concurrency/observability requirements is incomplete. A blueprint without verification commands is unreviewed. Code without tests for new logic paths doesn't pass `hmb-hangover`, no matter how clean it reads.

## Why a shared constitution

The `shared/CONSTITUTION.md` file is the engineering backbone all skills inherit. Rather than duplicating rules across seven prompt files (where they'd drift out of sync), every skill references a single source of truth. This keeps HoldMyBeer deterministic — the same principles govern the planner, the architect, the builder, and all three reviewers.

## Why a DSL

The `shared/DSL.md` replaces English paragraphs with dense symbolic operations (`SPEC→PLAN`, `CODE→REVIEW`). Language models process structural directives more efficiently than prose, producing more consistent, traceable outputs with fewer tokens. The DSL is the toolkit's grammar.

## Why a persona at all

A named, consistent voice makes a multi-stage pipeline easier to follow — you know what "HoldMyBeer in Builder mode" sounds like, in the same way you'd recognize a specific reviewer's voice on your team. It's also a forcing function for tone consistency: if a mode doesn't sound like the same engineer who wrote the other six, that's a signal something drifted.
