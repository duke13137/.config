if vim.g.vscode then
  return
end

local wk = require("which-key")
wk.add({
  mode = { "n", "v" },
  { "<localleader>C", desc = "ghci clear" },
  { "<localleader>L", desc = "ghci load" },
  { "<localleader>d", desc = "ghci doc" },
  { "<localleader>h", desc = "hoogle" },
  { "<localleader>i", desc = "ghci info" },
  { "<localleader>k", desc = "ghci kind" },
  { "<localleader>l", desc = "ghci reload" },
  { "<localleader>m", desc = "ghci main" },
  { "<localleader>t", desc = "ghci type" },
})

local luasnip = require("luasnip")
local haskell_snippets = require("haskell-snippets").all
luasnip.add_snippets("haskell", haskell_snippets, { key = "haskell" })

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
