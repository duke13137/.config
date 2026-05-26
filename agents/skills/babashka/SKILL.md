---
name: babashka
description: Use Babashka to write, run, and debug fast-starting Clojure scripts and command-line tasks. Use when the user mentions Babashka, bb, bb.edn, Clojure scripting, shell automation in Clojure, or asks whether a script should use Babashka versus JVM Clojure.
---

# Clojure Babashka

## Quick Start

Use `bb` for Clojure scripts that should start quickly, run from the command line, or automate local tasks.

```bash
bb -e '(+ 1 2 3)'
bb -x clojure.core/prn --hello there
bb task-name
```

Check `bb.edn` first when a project has one. Prefer existing tasks, deps, paths, and namespaces over ad hoc invocations.

## Workflow

1. Inspect `bb.edn` for tasks, `bb print-deps` for dependencies.
2. Run existing tasks with `bb <task>` when available.
3. For one-off checks, use `bb -e '<expr>'` (use shell heredoc for inline scripting).
4. For [`bb -x `](https://book.babashka.org/#cli) scripts, keep namespaces and requires explicit.

## Deps

- Use `bb print-deps` from built-in libraries plus `bb.edn`. Do NOT add new dependency without asking.

- Use https://cljdoc.org/ for API docs for libraries shown in `bb print-deps`, including Babashka built-ins and libraries added in `bb.edn`.

## CLI Arguments

Use built-in `babashka.cli` when a script or task needs Unix-style options, positional args, coercion, help text, or validation.

```clojure
(require '[babashka.cli :as cli])

(def opts
  (cli/parse-opts *command-line-args*
                  {:coerce {:port :long
                            :verbose :boolean}
                   :alias {:p :port
                           :v :verbose}
                   :args->opts [:file]}))
```

- Use `parse-opts` when the command mainly has named options.
- Use `parse-args` when positional arguments must remain distinct from options.
- Add `:coerce` to disambiguate booleans, numbers, keywords, and repeated values.
- Add `:alias` for short flags such as `-p` mapping to `--port`.
- Use `:args->opts` to fold positional args into named options.
- Add polish with `:spec`, `:restrict`, `:require`, `:validate`, `:desc`, and formatted help when building user-facing CLIs.
- Support `--` as the boundary between options and trailing positional args when parsing would otherwise be ambiguous.

## Tasks

Use `:tasks` in `bb.edn` for project commands, similar to `make`, `just`, `npm scripts`, or aliases.

```clojure
{:tasks
 {clean {:doc "Remove build output"
         :task (shell "rm" "-rf" "target")}
  test  {:depends [clean]
         :task (shell "clojure" "-M:test")}}}
```

- Run tasks with `bb <task>` or `bb run <task>`.
- List discoverable tasks with `bb tasks`; add `:doc` for useful output.
- Use `:init` for shared helpers and constants.
- Use map tasks for `:doc`, `:requires`, `:extra-paths`, `:extra-deps`, `:depends`, `:enter`, `:leave`, and `:task`.
- Use built-in helpers such as `shell`, `run`, `clojure`, and `current-task`.
- Remember `shell` executes a program directly; use `bash -c` or another shell explicitly for shell syntax like globs and pipes.

## References

- Usage: https://book.babashka.org/#usage
- Tasks: https://book.babashka.org/#tasks
