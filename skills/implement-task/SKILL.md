---
name: implement-task
description: Implement and verify exactly one existing TASK-XXX when the user names a task file, asks to complete a task, asks for the next executable task, or asks to fix a task implementation that was not accepted.
---

# Implement Task

Implement one task per invocation and update that task's result. Do not close the milestone.

## Preconditions

1. Identify exactly one task. If the user asks for the next task, scan `docs/planning/tasks/` and choose one `ready` task whose `blocked_by` tasks are completed.
2. Read `docs/specifications/product.md`, the task, associated milestone, linked supporting requirements, applicable ADRs, nearest `AGENTS.md`, and `CONTEXT.md` if present.
3. Verify every `blocked_by` task is `completed`; refuse blocked tasks and explain the blockers.
4. Refuse `cancelled` tasks. Surface ambiguity or conflicts before editing.
5. Set status to `in-progress` only when work can actually begin, preserving existing manual content.

## Implementation loop

1. Inspect the relevant code and tests.
2. State a short operational plan and the public seams to verify.
3. Use TDD where appropriate; keep changes small and scoped to the task.
4. Run targeted tests and type checks frequently when the repository defines them.
5. Follow existing conventions. Avoid speculative abstractions and unnecessary production dependencies.
6. Stop for user input when the task needs a product/domain/architecture decision, an ADR change, a significant scope expansion, destructive operations, or a conflict between spec and code.

## Final verification

Determine real commands from the repository and `AGENTS.md`; do not invent commands. Run applicable targeted tests, integration tests, full suite when proportionate, type-check, lint, build, migrations, manual/browser checks required by acceptance criteria, and a final diff review against task scope and repository standards.

Classify failures as introduced by this change, pre-existing, or environmental. Keep valid tests intact.

## Task update

Update the task front matter `status` and `updated_at`, plus `Risultato dell’implementazione` with summary, main files/areas, tests added or changed, commands and results, assumptions, residual risks, and follow-up work.

Set `status: completed` only when all acceptance criteria pass, mandatory checks pass, documentation is updated, no introduced errors remain, and the final diff has been reviewed. Use `blocked` only for real external or decision blockers; otherwise leave `in-progress` and document remaining work.

Do not commit, push, open a PR, or release unless explicitly requested or required by repository instructions.
