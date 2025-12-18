if vim.g.vscode then
  return
end

local vo = vim.opt_local
vo.tabstop = 4
vo.shiftwidth = 4
vo.softtabstop = 4

local wk = require("which-key")
wk.add({
  { "<localleader>c", group = "connect" },
  { "<localleader>e", group = "eval" },
  { "<localleader>l", group = "log" },
  { "<localleader>r", group = "ipython" },
})

local function options(desc)
  return { buffer = true, noremap = true, silent = true, desc = desc }
end

local map = vim.keymap.set

map("n", ",rc", ":Repl %clear<CR>", options("clear"))
map("n", ",ri", ":Repl %pinfo <C-r>=expand('<cexpr>')<CR><CR>", options("info"))
map("n", ",rl", ":Repl %load_ext autoreload<CR> | :Repl %autoreload 2 -p<CR>", options("autoreload on"))
map("n", ",ro", ":Repl %autoreload off<CR>", options("autoreload off"))
map("n", ",rr", ":Repl %run -e -i <C-r>=expand('%:p')<CR><CR>", options("run"))
map("n", ",rR", ":Repl %reset -f<CR>", options("reset"))
map("n", ",rt", ":Repl !pytest --no-header -lv --doctest-modules <C-r>=expand('%:p')<CR><CR>", options("pytest"))
