-- stylua: ignore

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  { "folke/noice.nvim", enabled = false },

  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  {
    "folke/which-key.nvim",
    opts = {
      -- delay = 500,
      preset = 'helix',
      win = { no_overlap = true }
    },
  },

  -- change surround mappings
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        replace = "gsr",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        update_n_lines = "gsn",
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        haskell = { "stylishhaskell" },
        sh = { "shellcheck" },
      },
      formatters = {
        stylishhaskell = {
          command = "stylish-haskell", args = { "-i" },
        }
      }
    }
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "clojure",
        "fennel",
        "haskell",
      })
    end,
  },

  {
    'saghen/blink.cmp',
    opts = {
      keymap = {
        preset = "super-tab",
      },
      signature = { enabled = false }
    }
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false }
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "codelldb",
        "debugpy",
        "delve",
        "gopls",
        "emmet-language-server",
        "json-lsp",
        "lua-language-server",
        "pyright",
        "ruff",
        "ruff-lsp",
        "shellcheck",
        "shfmt",
        "stylua",
        "taplo",
      },
    },
  },

  {
    "mbbill/undotree",
    dependencies = {
      "tpope/vim-repeat",
    },
  },

}
