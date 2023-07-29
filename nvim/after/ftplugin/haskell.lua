if vim.g.vscode then
  return
end

local ht = require("haskell-tools")
local def_opts = { noremap = true, silent = true }
ht.start_or_attach {
  hls = {
    default_settings = {
      haskell = { -- haskell-language-server options
        -- Setting this to true could have a performance impact on large mono repos.
        checkProject = false,
        formattingProvider = "fourmolu",
        plugin = {
          hlint = { globalOn = false },
          retrie = { globalOn = false },
          splice = { globalOn = false },
        },
      },
    },
    on_attach = function(client, bufnr)
      local opts = vim.tbl_extend("keep", def_opts, { buffer = bufnr })
      -- haskell-language-server relies heavily on codeLenses,
      -- so auto-refresh (see advanced configuration) is enabled by default
      vim.keymap.set("n", "<space>cb", vim.lsp.codelens.run, vim.tbl_extend("keep", opts, { desc = "Code Lens" }))
      vim.keymap.set("n", "<space>ce", ht.lsp.buf_eval_all, vim.tbl_extend("keep", opts, { desc = "Eval code" }))
      vim.keymap.set("n", "<space>sh", ht.hoogle.hoogle_signature, vim.tbl_extend("keep", opts, { desc = "Hoogle" }))
    end,
  },
  tools = {
    repl = {
      -- 'builtin': Use the simple builtin repl
      -- 'toggleterm': Use akinsho/toggleterm.nvim
      handler = "builtin",
      -- Can be overriden to either `true` or `false`.
      -- The default behaviour depends on the handler.
      auto_focus = nil,
      -- Which backend to prefer if both stack and cabal files are present
      prefer = vim.fn.executable("stack") and "stack" or "cabal",
      builtin = {
        create_repl_window = function(view)
          -- create_repl_split | create_repl_vsplit | create_repl_tabnew | create_repl_cur_win
          return view.create_repl_split { size = vim.o.lines / 3 }
        end,
      },
    },
  },
}

-- set buffer = bufnr in ftplugin/haskell.lua
local bufnr = vim.api.nvim_get_current_buf()
-- Detect nvim-dap launch configurations
-- (requires nvim-dap and haskell-debug-adapter)
ht.dap.discover_configurations(bufnr)

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
