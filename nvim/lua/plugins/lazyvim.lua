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
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false }
    },
  },

  {
    'saghen/blink.cmp',
    opts = {
      keymap = {
        preset = "default",
      },
      completion = {
        ghost_text = { enabled = false },
      },
      signature = { enabled = true }
    }
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        haskell = { "stylishhaskell" },
      },
      formatters = {
        stylishhaskell = {
          command = "stylish-haskell",
          args = { "-i" },
        },
      },
    },
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "nvim-dap-ui",
        opts = {
          layouts = {
            {
              position = "top",
              size = 0.3,
              elements = {
                { id = "scopes", size = 0.6 },
                { id = "stacks", size = 0.4 },
              },
            },
            {
              position = "bottom",
              size = 0.3,
              elements = {
                { id = "repl", size = 0.6 },
                { id = "console", size = 0.4},
              },
            }
          },
        },
      },
    },
  },

  {
    "jonboh/nvim-dap-rr", dependencies = {"nvim-dap", "telescope.nvim"},
    config = function()
      local dap = require('dap')
      local rr = require('nvim-dap-rr')
      table.insert(dap.configurations.c, rr.get_config())
    end
  },

  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
    },
    lazy = true,
    cmd = "Neogit",
    keys = { { "<leader>G", "<cmd>Neogit<cr>", desc = "Neogit" } },
  },

  {
    "preservim/tagbar",
    keys = { { "<leader>ct", "<cmd>TagbarToggle<cr>", desc = "Toggle Tagbar" } },
  },

  {
    "mbbill/undotree",
    dependencies = { "tpope/vim-repeat" },
  },

}
