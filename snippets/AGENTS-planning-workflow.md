## Planning workflow

Use `docs/specifications/product.md` as the primary product input for planning; supplement it with approved ADRs and relevant repository documentation. Version planning artifacts in `docs/` using this structure as needed: `docs/specifications/`, `docs/architecture/overview.md`, `docs/architecture/adr/`, `docs/planning/roadmap.md`, `docs/planning/project-status.md`, `docs/planning/milestones/`, `docs/planning/tasks/`, and `docs/reviews/milestones/`. Create directories only when producing the first related artifact.

Sources of truth, highest precedence first:

1. Explicit current user request
2. `docs/specifications/product.md`
3. Applicable ADRs
4. Current milestone
5. Current task
6. Other approved repository documentation
7. `AGENTS.md` and repository conventions

Report significant conflicts instead of choosing silently. Use `CONTEXT.md`, when present, for domain language.

Planning delivery follows this order: `plan-roadmap` manages `docs/planning/roadmap.md` at strategic milestone level; `plan-milestone` details exactly one milestone; `create-tasks` decomposes an approved milestone into tasks; `implement-task` implements exactly one task; `close-milestone` verifies and closes the milestone. Keep responsibilities separate.

If `docs/planning/project-status.md` is needed and absent, use only these sections: Milestone corrente, Ultima milestone completata, Prossima milestone prevista, Task corrente, Blocchi aperti, Ultimo aggiornamento. Avoid duplicating roadmap, milestone, or task content.

For verification, use commands actually defined by the repository and proportionate to the change: targeted tests, integration tests, full suite, type-check, lint, build, migrations, and manual checks when acceptance criteria require them. Distinguish failures introduced by the change from pre-existing or environmental failures, and do not weaken valid tests to pass.
