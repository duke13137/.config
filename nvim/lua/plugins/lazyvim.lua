-- stylua: ignore

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  { "folke/noice.nvim", enabled = false },
  { "rcarriga/nvim-dap-ui", pin = true, lazy = true },
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

  {
    "L3MON4D3/LuaSnip",
    keys = function() return {} end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "PaterJason/cmp-conjure",
    },
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "conjure" },
      }))
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<CR>"] = cmp.config.disable,
      ["<Tab>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      ["<C-n>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-p>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      })
    end
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function(_, opts)
      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        nls.builtins.formatting.stylua,
        nls.builtins.code_actions.gitsigns,
        nls.builtins.code_actions.shellcheck,
        nls.builtins.formatting.shfmt,
        nls.builtins.diagnostics.deadnix,
        nls.builtins.formatting.nixfmt,
        nls.builtins.formatting.cabal_fmt,
        nls.builtins.formatting.fourmolu,
        require('plugins.haskell').ghcid(),
        -- require('plugins.haskell').hlint(),
      })
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

  -- change surround mappings
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    },
  },

  -- add telescope-fzf-native and change layout
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        layout_strategy = "flex",
        layout_config = {
          width = 0.95,
          height = 0.85,
          preview_cutoff = 20,
          prompt_position = "top",
          horizontal = {
            preview_width = function(_, cols, _)
              if cols > 200 then
                return math.floor(cols * 0.4)
              else
                return math.floor(cols * 0.6)
              end
            end,
          },
          vertical = { width = 0.9, height = 0.95, preview_height = 0.5 },
          flex = { horizontal = { preview_width = 0.9 } },
        },
        winblend = 0,
      },
    },
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
        "nix",
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "codelldb",
        "clojure-lsp",
        "debugpy",
        "delve",
        "gopls",
        "emmet-language-server",
        "json-lsp",
        "lua-language-server",
        "pyright",
        "ruff",
        "ruff-lsp",
        "rust-analyzer",
        "shellcheck",
        "shfmt",
        "stylua",
        "taplo",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
    },
  },

  {
    "junegunn/fzf.vim",
    keys = {
      { "gt", ":Tags <C-r><C-w><CR>", desc = "Tags" },
    },
    dependencies = { "junegunn/fzf" },
  },

  {
    "preservim/tagbar",
    keys = {
      {"<leader>ut", "<Cmd>TagbarToggle<CR>", desc = "Toggle Tagbar"}
    }
  },

  {
    "fonghou/tmuxjump.vim",
    init = function()
      vim.g.tmuxjump_telescope = true
    end,
    keys = {
      { "[f", "<Cmd>TmuxJumpFirst<CR>", desc = "TmuxJumpFirst" },
      { "[F", "<Cmd>TmuxJumpFile<CR>", desc = "TmuxJumpFile" },
    },
  },

  {
    "mbbill/undotree",
    dependencies = {
      "tpope/vim-repeat",
    }
  },
}
