---
name: plan-roadmap
description: Create, review, and maintain docs/planning/roadmap.md when the user asks to create a project roadmap, turn specifications or requirements into ordered milestones, separate MVP from post-MVP, revise future milestones, replan after scope/requirement/architecture changes, or check roadmap coherence with real project state; do not use for detailed single-milestone planning, task creation, code implementation, or milestone closure.
---

# Plan Roadmap

Create or update the strategic roadmap. Keep milestone details high level and hand off detailed milestone planning to `plan-milestone`, task breakdown to `create-tasks`, implementation to `implement-task`, and milestone closure to `close-milestone`.

## Process

1. Read `docs/specifications/product.md` as the primary planning input. Then read nearest `AGENTS.md`, `CONTEXT.md` if present, supporting functional/non-functional requirements, architecture overview, applicable ADRs, existing `docs/planning/roadmap.md`, `docs/planning/project-status.md`, planned milestone files, milestone reviews, incomplete or blocked tasks, and the real code state when the repository already has implementation. If `docs/specifications/product.md` is missing or materially insufficient, ask for it before creating a roadmap.
2. Determine the mode: new roadmap, roadmap revision, replanning after change, or consistency check against project state.
3. Extract the product goal, users, produced value, MVP boundary, post-MVP candidates, out-of-scope items, major requirements, cross-cutting non-functional requirements, constraints, external dependencies, architectural decisions, risks, open decisions, and current project state.
4. Check plannability: ambiguous requirements, contradictions, unconfirmed assumptions, missing decisions that materially affect MVP/order/architecture/dependencies/outcome, oversized scope, unresolved dependencies, misplaced MVP items, and research/prototype needs. Ask only when the answer materially changes the roadmap; otherwise record assumptions and proceed.
5. Draft milestones before writing. Each milestone must describe a demonstrable result, not a technical layer. For each milestone include ID, title, status, objective, demonstrable outcome, dependencies, main contents, specific out-of-scope items, principal risks, and concise completion criteria.
6. Apply rolling-wave planning: current or next milestone gets moderate detail; near milestones get objective, result, dependencies, and main criteria; distant milestones stay concise. Do not define files, classes, endpoints, tables, dates, durations, or effort unless explicitly requested.
7. Separate `MVP`, `Post-MVP`, and `Fuori ambito`. Keep useful-but-not-validating features in post-MVP with a brief rationale.
8. Represent dependencies with stable milestone IDs. Preserve existing IDs; do not renumber without explicit authorization. If inserting between existing milestones, preserve references with an ID such as `M02A` or a new stable ID plus explicit logical order. Detect circular dependencies and ask for a decision.
9. Present a concise draft with milestones, demonstrable results, dependencies, MVP boundary, post-MVP items, and main open decisions. Ask confirmation before creating the first roadmap, changing MVP scope, adding/removing/reordering milestones, changing dependencies that affect current work, or modifying an `in-progress` milestone.
10. After approval, create `docs/planning/` if needed and create or update `docs/planning/roadmap.md` from `assets/roadmap-template.md`. Preserve manual content, existing IDs, revision history, and relative links. Avoid duplicate sections; update `updated_at`.
11. Update `docs/planning/project-status.md` only when needed to reflect the approved roadmap. If absent, use the minimal format in `AGENTS.md`.
12. Finish with what changed, why, affected milestones, impact on current work, impact on MVP/post-MVP, and whether the next handoff is `plan-milestone`.

## Guardrails

- Do not create milestone detail files, task files, or milestone review files.
- Do not implement code or modify application files.
- Do not mark a milestone `completed`; that belongs to `close-milestone`.
- Do not silently redefine an `in-progress` milestone or architecture decision.
- Do not promote post-MVP scope into MVP without approval.
- Keep repeated runs idempotent and use `YYYY-MM-DD` dates with relative links.

## Milestone statuses

Use `draft`, `planned`, `in-progress`, `blocked`, `completed`, and `cancelled`. `completed` must reflect closure by `close-milestone`, not roadmap editing.
