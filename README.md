# Planning workflow skills

[English](README.md) · [Italiano](README.it.md)

A standalone skill package for incremental planning and implementation. Its primary input is `docs/specifications/product.md` in the target repository; requirements, ADRs, and technical documentation supplement it when present.

1. `plan-roadmap` — manages the strategic roadmap in `docs/planning/roadmap.md`.
2. `plan-milestone` — plans exactly one milestone in detail.
3. `create-tasks` — decomposes an approved milestone into executable tasks.
4. `implement-task` — implements and verifies one `TASK-XXX`.
5. `close-milestone` — verifies and closes one milestone.

The skills do not require third-party skills. They can be used on their own from an approved `docs/specifications/product.md`. Matt Pocock's skills are optional: they may help produce or refine `product.md`, but are not part of this package's operational workflow.

## Contents

```text
skills/
  plan-roadmap/
  plan-milestone/
  create-tasks/
  implement-task/
  close-milestone/
scripts/
  install.sh
  merge-agents-snippet.sh
  validate.sh
docs/
  operating-guide.en.md
  guida-operativa.it.md
snippets/
  AGENTS-planning-workflow.md
```

## Install with `npx skills`

Publish this directory in a GitHub repository, for example:

```text
https://github.com/blufix79/planning-workflow-skills
```

From the target project repository:

```bash
npx skills@latest add blufix79/planning-workflow-skills --skill '*' -y
```

The command installs all five skills into the project, normally under:

```text
.agents/skills/
```

To install only selected skills:

```bash
npx skills@latest add blufix79/planning-workflow-skills \
  --skill plan-roadmap plan-milestone create-tasks implement-task close-milestone -y
```

Add `-g` to install globally instead of in one project.

`scripts/install.sh` remains available for offline installations or a local checkout, but is unnecessary for the normal GitHub workflow. It can also merge the repository instructions in one explicit step:

```bash
./scripts/install.sh /path/to/target-repo --merge-agents
```

After installation with `npx skills`, merge `snippets/AGENTS-planning-workflow.md` into the target project's `AGENTS.md` if the workflow is not already documented. To automate that merge from a local checkout, run:

```bash
./scripts/merge-agents-snippet.sh /path/to/target-repo
```

The merge is idempotent: it updates the managed marker block when present, replaces an existing `## Planning workflow` section when present, or appends the managed block otherwise.

For the human workflow and invocation examples, see the guides: [English](docs/operating-guide.en.md) · [Italiano](docs/guida-operativa.it.md). Preparing `docs/specifications/product.md` with `$documents` and using Matt Pocock's skills are explicitly optional.

## Validation

```bash
./scripts/validate.sh
```

The validator checks that each skill has `SKILL.md`, front matter containing only `name` and `description`, a name matching its directory, and the required assets.

## Updates

To update installed skills:

```bash
npx skills@latest update
```

For offline distribution, create an archive with:

```bash
npm run pack:tar
```

## Dependencies

There are no dependencies on other skills. The target repository must contain a sufficiently defined `docs/specifications/product.md` before starting `plan-roadmap`.

Matt Pocock's skills are optional and can be installed separately when you want to use them to produce or improve `product.md`.

## License

[MIT](LICENSE).