---
name: close-milestone
description: Verify and close one milestone when the user asks to review a milestone, close it, run a final milestone check, or decide whether the project can proceed to the next milestone.
---

# Close Milestone

Review the whole milestone and close it only when its completion criteria are truly satisfied.

## Process

1. Read `docs/specifications/product.md`, nearest `AGENTS.md`, `CONTEXT.md` if present, milestone, linked tasks, linked supporting requirements, applicable ADRs, previous reviews, roadmap, and project status.
2. Verify linked tasks are not incomplete, blocked, unjustifiably cancelled, or marked completed without verification evidence. Do not treat `completed` task status alone as proof.
3. Compare real behaviour with the milestone objective, demonstrable outcome, completion criteria, functional and non-functional requirements, and architectural decisions.
4. Run applicable aggregate checks defined by the repository: tests, integration, type-check, lint, build, migrations, security/authorization, accessibility, performance, and end-to-end/manual demonstration when required.
5. Review the milestone diff against `product.md`, supporting requirements, repository standards, architecture, scope, and regression risk.
6. Classify findings as blocking, non-blocking, accepted technical debt, or future work outside the milestone.
7. For blocking issues, leave the milestone open and propose corrective tasks separately; create them only after approval.
8. Create or update `docs/reviews/milestones/MXX-review.md` from `assets/milestone-review-template.md`. Create the directory only when writing the report.
9. Set milestone `status: completed` and `completed_at` only when all criteria are satisfied. Update `updated_at`.
10. Update `docs/planning/project-status.md`. Update `docs/planning/roadmap.md` only when findings materially affect future milestones.
11. Finish with final outcome `PASSED`, `FAILED`, or `BLOCKED`, plus the next recommended handoff. Do not plan the next milestone in detail.

## Guardrails

- Do not implement substantial fixes silently during review.
- Do not close cancelled or incomplete task work without rationale.
- Keep report and status updates idempotent.
- Use `YYYY-MM-DD` dates and relative links.
