-- stylua: ignore

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  {
    'saghen/blink.cmp',
    opts = {
      keymap = {
        -- "super-tab" keymap
        ['<Tab>'] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          'snippet_forward',
          'fallback'
        },
        -- "enter" keymap
        ['<CR>'] = { },
      },
      signature = { enabled = true }
    }
  },

  { "folke/noice.nvim", enabled = false },

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

  { "theHamsta/nvim-dap-virtual-text", pin = true, lazy = true },
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>dc",
        function()
          vim.fn.sign_define('DapStopped', {text='🛑', texthl='DapBreakpoint'})
          local dap = require('dap')
          dap.adapters.lldb = dap.adapters.codelldb
          if vim.fn.filereadable('.vscode/launch.json') then
            require('dap.ext.vscode').load_launchjs(nil, { lldb = { "c", "cpp"} })
          end
          dap.continue()
        end, desc = "Continue"
      },
    }
  },

  { "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
    },
    opts = {},
    config = function(_, opts)
      -- setup dap config by VsCode launch.json file
      -- require("dap.ext.vscode").load_launchjs()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },

  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
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
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
        exclude = { "c" },
      },
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
    "preservim/tagbar",
    keys = {
      {"<leader>ct", "<Cmd>TagbarToggle<CR>", desc = "Toggle Tagbar"}
    }
  },

  {
    "fonghou/tmuxjump.vim",
    init = function()
      vim.g.tmuxjump_telescope = true
    end,
    keys = {
      { "<leader>fj", "<Cmd>TmuxJumpFirst<CR>", desc = "TmuxJumpFirst" },
      { "<leader>fJ", "<Cmd>TmuxJumpFile<CR>", desc = "TmuxJumpFile" },
    },
  },

  {
    "mbbill/undotree",
    dependencies = {
      "tpope/vim-repeat",
    }
  },

  {
    "Mythos-404/xmake.nvim",
    branch = "v1",
    lazy = true,
    event = "BufReadPost xmake.lua",
    config = true,
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  }
}
