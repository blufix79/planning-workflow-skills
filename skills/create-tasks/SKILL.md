---
name: create-tasks
description: Decompose an approved milestone, specification, or plan into small vertical executable tasks when the user asks to generate milestone tasks, prepare an implementation backlog, or review task granularity and dependencies.
---

# Create Tasks

Turn one sufficiently defined milestone into task files. Stop before implementation.

## Process

1. Read `docs/specifications/product.md`, nearest `AGENTS.md`, `CONTEXT.md` if present, applicable ADRs, the target milestone, and every linked supporting source.
2. Verify the milestone has enough objective, scope, dependencies, and completion criteria to produce executable tasks. Ask for approval-level clarification if not.
3. Inspect the code only as needed to make task boundaries realistic.
4. Draft a decomposition without writing files. Prefer vertical slices that cross the necessary layers, produce observable behaviour, include required tests/docs, and fit one agent session. Treat wide refactors as explicit exceptions and sequence them with expand-migrate-contract when appropriate.
5. Present each proposed task with title, produced result, dependencies, principal criteria, and granularity rationale. Ask for approval before writing files.
6. After approval, assign globally unique IDs by scanning all existing `docs/planning/tasks/TASK-*.md`; choose the next numeric IDs and never reuse old or existing IDs.
7. Create one file per task under `docs/planning/tasks/TASK-XXX-slug.md` from `assets/task-template.md`. Create `docs/planning/tasks/` only when writing the first task.
8. Update the milestone's `Task collegati` section with relative links, preserving existing links and avoiding duplicates.
9. Update `docs/planning/project-status.md` only if needed to reflect the task backlog/current task.
10. Finish with the ready task frontier: tasks whose `blocked_by` entries are all completed.

## Task contract

Use front matter with `id`, `title`, `status`, `milestone`, `blocked_by`, `spec_refs`, `created_at`, and `updated_at`. Allowed statuses: `draft`, `ready`, `in-progress`, `blocked`, `completed`, `cancelled`.

## Guardrails

- Do not implement code.
- Do not split by repository layer when the slice would not be independently verifiable.
- Do not duplicate task IDs, milestone links, or status sections on repeated runs.
- Use `YYYY-MM-DD` dates and relative links.
