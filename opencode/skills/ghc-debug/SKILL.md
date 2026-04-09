---
name: ghc-debug
description: Haskell debugging via tmux GHCi pane + nvim mcp sync. Use when debugging Haskell, hitting breakpoints, inspecting bindings, or syncing editor to GHCi stop location.
---

# GHC Debug Skill

## Locate the GHCi tmux pane

```bash
tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index} #{pane_title} #{pane_current_command}'
# test and learn
tmux send-keys -t ghci ':help' Enter
```

Use that target (e.g. `ghci`, `main:0.1`) in all subsequent commands.

## Sync nvim to GHCi stop location

- Test nvim socket connection first

```bash
nvim-mcp --connect auto
```

- Jump nvim cursor line to breakpoint source location in ghci pane

```bash
###
[src/Todo.hs:(104,21)-(107,31)] *Test λ> :show context
--> tasty testRoute
  Stopped in Todo.getTodosPage, src/Todo.hs:(104,21)-(107,31)
[src/Todo.hs:(104,21)-(107,31)] *Test λ>

## Or

### Breakpoint Hit ###
(src/Todo.hs:157:3-13)

```

## Breakpoint workflow

- Prefer GHCi `:break` — no code changes needed.

```
:break [<mod>] <l> [<col>]  set a breakpoint at the specified location
:break <name>               set a breakpoint on the specified function
:show breaks           -- show all breakpoints
:reload                -- clear all breakpoints
```

- Fallback to source-level (comment/uncomment to toggle) in threaded code:

```haskell
-- Debug.Breakpoint (plugin loaded by .ghci, no import needed)
breakpoint      -- pause in pure code
breakpointM     -- pause in any monad (Handler, Session …)
breakpointIO    -- pause in IO stack

-- Debug.Trace (pure logging, never pauses — import manually)
trace "msg" x           -- print msg, return x
traceShow val x         -- print val, return x
traceShowId x           -- print x, return x
```

**Debug.Breakpoint** pauses and prints locals, then waits for Enter before resuming. Send it via tmux:

```bash
tmux send-keys -t ghci '' Enter    # press Enter to resume from breakpoint prompt
```

After stopping (either method):

```
:show context       -- where am I + call stack
:show bindings      -- all locals in scope
:print x            -- print x (safe, no forcing)
:sprint x           -- print x, _ for unevaluated thunks
:force x            -- fully evaluate x
:step               -- step one reduction
:steplocal          -- step within current function
:continue           -- resume
```

## Collect state at each breakpoint

At every stop, gather and format three things in order:

**1. Location + args**

```
:show context           -- file, line, function name
:show bindings          -- function arguments visible at entry
```

**2. Locals — force and pretty-print each binding**

```
:force x                -- evaluate, then GHCi pretty-prints
:print x                -- safe inspect if :force is too eager
```

Capture output with `tmux capture-pane -p -t ghci -S -100`, then format as:

```
[Module.function:line]
  arg1 = <value>
  arg2 = <value>
  localX = <value>
```

**3. Relevant DB table state**

```bash
tmux send-keys -t psql "select * from todos where id = <id>\g" Enter
tmux capture-pane -p -t psql -S -20
```

Format alongside the Haskell state so both are visible together:

```
DB todos: [{id:1, title:"Buy milk", completed:false}]
```

Repeat after `:step` / `:continue` to track how state evolves.
