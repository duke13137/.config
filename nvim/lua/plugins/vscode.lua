if not vim.g.vscode then
  return {}
end

local vscode = require("vscode")
vim.notify = vscode.notify

local enabled = {
  "LazyVim",
  "lazy.nvim",
  "mini.ai",
  "mini.pairs",
  "mini.surround",
  "nvim-treesitter",
  "nvim-treesitter-sexp",
  "nvim-treesitter-textobjects",
  "snacks.nvim",
  "ts-comments.nvim",
  "vim-repeat",
}

local Config = require("lazy.core.config")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

-- Add some vscode specific keymaps
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymapsDefaults",
  callback = function()
    -- VSCode-specific keymaps for search and navigation
    vim.keymap.set("n", "<leader><space>", function()
      vscode.action("workbench.action.quickOpen")
    end)
    vim.keymap.set("n", "<leader>/", function()
      vscode.action("workbench.action.findInFiles")
    end)
    vim.keymap.set("n", "<leader>ss", function()
      vscode.action("workbench.action.gotoSymbol")
    end)

    -- Keep undo/redo lists in sync with VsCode
    vim.keymap.set("n", "u", function()
      vscode.call("undo")
    end)
    vim.keymap.set("n", "<C-r>", function()
      vscode.call("redo")
    end)
  end,
})

return {
  {
    "LazyVim/LazyVim",
    config = function(_, opts)
      opts = opts or {}
      -- disable the colorscheme
      opts.colorscheme = function() end
      require("lazyvim").setup(opts)
    end,
  },
  {
    "folke/flash.nvim",
    vscode = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = { enable = false } },
  },
  {
    "PaterJason/nvim-treesitter-sexp",
    vscode = true,
    opts = {
      keymaps = {
        motions = {
          prev_top_level = "][",
          next_top_level = "[]",
        },
      },
    },
  },
  {
    "harrygallagher4/nvim-parinfer-rust",
    dependencies = { "eraserhd/parinfer-rust", build = "cargo build --release", vscode = true },
    vscode = true,
  },
}
