---
name: plan-milestone
description: Plan exactly one roadmap milestone with rolling-wave planning when the user asks to plan the current or next milestone, turn a roadmap item into an operational milestone, prepare a milestone for task breakdown, or reassess a milestone that has not started.
---

# Plan Milestone

Plan one milestone. Stop before task creation unless the user explicitly asks to continue with `create-tasks`.

## Process

1. Read `docs/specifications/product.md` as the primary product input, then nearest `AGENTS.md`, `CONTEXT.md` if present, applicable ADRs under `docs/architecture/adr/`, and architecture overview if present.
2. Gather planning inputs when present: `docs/planning/roadmap.md`, `docs/planning/project-status.md`, supporting requirements, earlier milestones, earlier milestone reviews, and incomplete or blocked tasks.
3. Identify exactly one milestone to plan. If the milestone cannot be identified or a missing product/domain/architecture decision would materially change it, ask one targeted question.
4. Compare roadmap, project status, and the real code state where relevant. Record mismatches as risks, assumptions, or open questions instead of silently changing scope.
5. Define the milestone: objective, demonstrable outcome, context, scope, out of scope, dependencies, assumptions, risks, functional and non-functional requirements, applicable ADRs, completion criteria, and verification strategy.
6. Create or update `docs/planning/milestones/MXX-slug.md` from `assets/milestone-template.md`. Create `docs/planning/milestones/` only when writing the artifact. Preserve manual content not directly managed by this planning pass.
7. Use front matter with `id`, `title`, `status`, `depends_on`, `created_at`, and `updated_at`. Allowed statuses: `draft`, `planned`, `in-progress`, `blocked`, `completed`, `cancelled`.
8. Update `docs/planning/project-status.md` only to record the planned/current milestone. If the file does not exist and must be updated, create the minimal format from `AGENTS.md`.
9. Finish by naming unresolved decisions, risks, and the next handoff to `create-tasks`.

## Guardrails

- Do not implement code.
- Do not create the full task set unless explicitly requested.
- Do not invent requirements or architectural decisions.
- Use `YYYY-MM-DD` dates and relative links.
- Keep repeated runs idempotent: update the existing milestone, links, and status entries instead of duplicating them.
