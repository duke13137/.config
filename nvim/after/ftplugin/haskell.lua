if vim.g.vscode then
  return
end

local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()
local function def_opts(desc)
  return { noremap = true, silent = true, buffer = bufnr, desc = desc }
end

-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run, def_opts("Codelens"))
-- Evaluate all code snippets
vim.keymap.set("n", "<localleader>e", ht.lsp.buf_eval_all, def_opts("Eval test"))
-- Hoogle search for the type signature of the definition under the cursor
vim.keymap.set("n", "<localleader>s", ht.hoogle.hoogle_signature, def_opts("Hoogle search"))
-- Toggle a GHCi repl for the current package
vim.keymap.set("n", "<localleader>cr", ht.repl.toggle, def_opts("Repl project"))
-- Toggle a GHCi repl for the current buffer
vim.keymap.set("n", "<localleader>cf", function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, def_opts("Repl buffer"))
vim.keymap.set("n", "<localleader>cq", ht.repl.quit, def_opts("Repl quit"))

-- Detect nvim-dap launch configurations
-- (requires nvim-dap and haskell-debug-adapter)
ht.dap.discover_configurations(bufnr)

require("telescope").load_extension("ht")

vim.api.nvim_create_user_command("HlintApply", function()
  local bufname = vim.api.nvim_buf_get_name(0)
  local c = vim.api.nvim_win_get_cursor(0)
  vim.cmd(
    string.format("silent !hlint %s --refactor --refactor-options='--inplace --pos %s,%s' ", bufname, c[1], c[2] + 1)
  )
end, { nargs = 0 })

vim.api.nvim_create_user_command("HlintApplyAll", function()
  local bufname = vim.api.nvim_buf_get_name(0)
  vim.cmd(string.format("silent !hlint %s --refactor --refactor-options='--inplace' ", bufname))
end, { nargs = 0 })

local wk = require("which-key")
local keys = {
  h = "ghci :doc",
  i = "ghci :info",
  j = "ghci :instances",
  k = "ghci :kind",
  l = "ghci :load",
  r = "ghci :reload",
  R = "ghci :main",
  t = "ghci :type",
  T = "ghci :doctest",
}

wk.register(keys, { mode = "n", prefix = "<localleader>", silent = true })
wk.register(keys, { mode = "v", prefix = "<localleader>", silent = true })
