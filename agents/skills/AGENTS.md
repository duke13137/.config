---
name: write-a-skill
description: Create or improve local agent skills with concise trigger metadata, progressive disclosure, and only necessary bundled resources. Use when the user asks to create, write, build, update, improve, or refine a skill in this skills directory.
---

# Writing Local Skills

## Operating Principles

- Keep skills small. Put only the instructions another agent needs to do the job.
- Prefer editing an existing skill over creating a duplicate.
- Keep `SKILL.md` under 100 lines when practical.
- Put detailed API notes, gotchas, and long examples in one-level reference files linked from `SKILL.md`.
- Do not add README, changelog, installation guide, or other auxiliary docs.
- Use current primary sources for external APIs or tools; link sources in the skill when they help future lookup.

## Process

1. Inspect the existing skill folder before editing.
2. Clarify requirements only when the task cannot be inferred from the user request and local context.
3. Draft or revise the minimum useful files:
   - `SKILL.md` for triggers, quick start, core workflow, and reference links.
   - `REFERENCE.md` only when details would bloat `SKILL.md`.
   - `scripts/` only for deterministic repeated operations.
4. Validate frontmatter, folder/name match, references, and obvious stale claims.
5. Summarize changed files and any validation gaps.

## Skill Structure

```text
skill-name/
├── SKILL.md       # Required
├── REFERENCE.md   # Optional, one-level deep detail
└── scripts/       # Optional deterministic helpers
```

Avoid `EXAMPLES.md` unless examples are genuinely large enough to justify a separate file.

## SKILL.md Template

```md
---
name: skill-name
description: Does one concrete capability. Use when the user mentions specific triggers, tools, files, or workflows.
---

# Skill Name

## Quick Start

[Small working example or first command to run]

## Workflow

1. [Concrete first step]
2. [Concrete next step]
3. [Verification or cleanup step]

## Lookup

- [REFERENCE.md](REFERENCE.md) for [specific details]
- Primary docs: https://example.com/
```

## Description Rules

The `description` is the trigger surface shown before `SKILL.md` is loaded.

- Use third person.
- Keep it under 1024 characters.
- First sentence: what the skill does.
- Second sentence: `Use when ...` with concrete triggers.
- Include important tool names, file names, package names, and user phrases.
- Do not put trigger guidance only in the body; the body is loaded too late for discovery.

## Reference Files

Use `REFERENCE.md` when:

- `SKILL.md` would exceed roughly 100 lines.
- The skill needs API examples, migration notes, gotchas, or longer workflows.
- Details are useful only after the skill has already triggered.

Keep references one level deep from `SKILL.md`. Add a short contents list when a reference file grows beyond 100 lines.

## Scripts

Add scripts only when they improve reliability:

- validation, formatting, migration, code generation, or repeated parsing
- operations with sharp edge cases
- logic that would otherwise be re-generated often

Prefer Babashka for local skill helper scripts when Clojure is a good fit; refer to [babashka/SKILL.md](babashka/SKILL.md) for `bb`, `bb.edn`, task, dependency, and CLI argument patterns.

Test any new or changed script with a representative command.

## Validation Checklist

- [ ] Folder name matches `name`.
- [ ] `name` is lowercase hyphen-case.
- [ ] `description` includes `Use when`.
- [ ] Frontmatter has only `name` and `description`.
- [ ] `SKILL.md` is concise and points to references only when needed.
- [ ] References are one level deep and linked from `SKILL.md`.
- [ ] Claims that may change are linked to current primary sources.
- [ ] No unused placeholder files or auxiliary docs were added.
