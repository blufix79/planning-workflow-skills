# Operating guide

> Keep this guide aligned with the [Italian version](guida-operativa.it.md).

This guide describes the human workflow for the planning skills. The skills in this package are standalone: they require an approved product specification at `docs/specifications/product.md`, not other skills.

## Before you start

Open your agent from the repository root. To invoke a skill predictably, name it at the beginning of the request:

```text
$skill-name request, files to read, constraints, and expected outcome
```

Each invocation has one bounded objective. In particular, `implement-task` always works on exactly one task.

## Prepare `product.md`

`docs/specifications/product.md` is the primary source for this package's skills. It should describe at least the goal, users, functional and non-functional requirements, constraints, out-of-scope items, acceptance criteria, risks, and open decisions.

### Option: normalize a source document

When the starting point is a DOCX, PDF, or other unstructured document, use a document-processing skill available in your environment, or a human review, to produce and approve `docs/specifications/product.md`. For example, if `$documents` is installed:

```text
$documents Read docs/sources/project-description.docx completely and transform it into docs/specifications/product.md. Do not create a roadmap, milestones, tasks, or code. Before saving, show gaps, contradictions, interpretations, and the proposed structure.
```

`$documents` is optional and is **not** included in or required by this package.

### Option: Matt Pocock's skills

[Matt Pocock's skills](https://github.com/mattpocock/skills) are optional. They can help clarify the domain, stress-test requirements, and research open decisions before `product.md` is approved; they are not required to run the workflow below.

Examples, when installed:

```text
$domain-modeling Analyze docs/specifications/product.md and clarify domain terms, entities, and rules.

$grill-with-docs Review docs/specifications/product.md and identify ambiguities, contradictions, and unverifiable requirements.

$research Research only the open decision <topic>; present evidence and trade-offs without modifying the specification.
```

## Workflow

| Phase | Skill | Main artifact | Human gate |
| --- | --- | --- | --- |
| 1 | `plan-roadmap` | `docs/planning/roadmap.md` | MVP, milestones, order, and dependencies |
| 2 | `plan-milestone` | `docs/planning/milestones/MXX-slug.md` | scope, criteria, and verification |
| 3 | `create-tasks` | `docs/planning/tasks/TASK-XXX-slug.md` | task list, granularity, and dependencies |
| 4 | `implement-task` | code and updated task | verification and outcome |
| 5 | `close-milestone` | `docs/reviews/milestones/MXX-review.md` | only `PASSED` closes the milestone |

### 1. Roadmap

```text
$plan-roadmap Create the roadmap from docs/specifications/product.md, CONTEXT.md, architecture, ADRs, and the repository's real state. Separate MVP and post-MVP; show me a draft before writing. Do not create detailed milestone files or tasks.
```

### 2. One milestone

```text
$plan-milestone Plan M01. Read the roadmap, project status, docs/specifications/product.md, CONTEXT.md, architecture, and applicable ADRs. Define scope, out of scope, risks, applicable requirements, demonstrable result, completion criteria, and verification strategy. Do not create tasks or code.
```

### 3. Milestone tasks

```text
$create-tasks Decompose M01 into tasks executable in one session. First show observable outcome, dependencies, criteria, and the rationale for granularity. Write files only after my approval. Do not implement.
```

### 4. One task

```text
$implement-task Implement docs/planning/tasks/TASK-001-slug.md. Work only on this task, verify blockers and sources of truth, then run applicable checks. Do not mark it completed if a criterion or mandatory check fails.
```

To select the next ready task:

```text
$implement-task Execute the next single ready task for M01 whose blockers are completed.
```

### 5. Close the milestone

```text
$close-milestone Verify M01 against the real outcome, objective, criteria, docs/specifications/product.md, applicable requirements, and ADRs. Create the review report. If blockers exist, propose corrective tasks without creating them before my approval.
```

## After the review

- `PASSED`: plan the next milestone with `plan-milestone`.
- Scope, order, or dependencies changed: return to `plan-roadmap` and approve the revision.
- `FAILED` or `BLOCKED`: approve corrective tasks, create them with `create-tasks`, and implement them one at a time.

## Essential rules

- Do not request roadmap, milestone, tasks, and implementation in one invocation.
- Do not generate tasks for distant milestones.
- Do not implement multiple tasks together.
- Completed task statuses alone do not prove that a milestone is complete.
- Surface conflicts with scope, requirements, or ADRs; do not resolve them silently.
- Shell commands install or inspect files; invoke skills in your agent's chat.
