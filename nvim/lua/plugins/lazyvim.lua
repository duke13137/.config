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
      "jake-stewart/multicursor.nvim",
      branch = "1.0",
      config = function()
          local mc = require("multicursor-nvim")

          mc.setup()

          local set = vim.keymap.set

          -- Add or skip cursor above/below the main cursor.
          set({"n", "v"}, "<up>",
              function() mc.lineAddCursor(-1) end)
          set({"n", "v"}, "<down>",
              function() mc.lineAddCursor(1) end)
          set({"n", "v"}, "<leader><up>",
              function() mc.lineSkipCursor(-1) end)
          set({"n", "v"}, "<leader><down>",
              function() mc.lineSkipCursor(1) end)

          -- Add or skip adding a new cursor by matching word/selection
          set({"n", "v"}, "<leader>n",
              function() mc.matchAddCursor(1) end)
          set({"n", "v"}, "<leader>s",
              function() mc.matchSkipCursor(1) end)
          set({"n", "v"}, "<leader>N",
              function() mc.matchAddCursor(-1) end)
          set({"n", "v"}, "<leader>S",
              function() mc.matchSkipCursor(-1) end)

          -- Add all matches in the document
          set({"n", "v"}, "<leader>A", mc.matchAllAddCursors)

          -- You can also add cursors with any motion you prefer:
          -- set("n", "<right>", function()
          --     mc.addCursor("w")
          -- end)
          -- set("n", "<leader><right>", function()
          --     mc.skipCursor("w")
          -- end)

          -- Rotate the main cursor.
          set({"n", "v"}, "<left>", mc.nextCursor)
          set({"n", "v"}, "<right>", mc.prevCursor)

          -- Delete the main cursor.
          set({"n", "v"}, "<leader>x", mc.deleteCursor)

          -- Add and remove cursors with control + left click.
          set("n", "<leftmouse>", mc.handleMouse)

          -- Easy way to add and remove cursors using the main cursor.
          set({"n", "v"}, "<c-q>", mc.toggleCursor)

          -- Clone every cursor and disable the originals.
          set({"n", "v"}, "<leader><c-q>", mc.duplicateCursors)

          set("n", "<esc>", function()
              if not mc.cursorsEnabled() then
                  mc.enableCursors()
              elseif mc.hasCursors() then
                  mc.clearCursors()
              else
                  -- Default <esc> handler.
              end
          end)

          -- bring back cursors if you accidentally clear them
          set("n", "<leader>gv", mc.restoreCursors)

          -- Align cursor columns.
          set("n", "<leader>a", mc.alignCursors)

          -- Split visual selections by regex.
          set("v", "S", mc.splitCursors)

          -- Append/insert for each line of visual selections.
          set("v", "I", mc.insertVisual)
          set("v", "A", mc.appendVisual)

          -- match new cursors within visual selections by regex.
          set("v", "M", mc.matchCursors)

          -- Rotate visual selection contents.
          set("v", "<leader>t",
              function() mc.transposeCursors(1) end)
          set("v", "<leader>T",
              function() mc.transposeCursors(-1) end)

          -- Jumplist support
          set({"v", "n"}, "<c-i>", mc.jumpForward)
          set({"v", "n"}, "<c-o>", mc.jumpBackward)

          -- Customize how cursors look.
          local hl = vim.api.nvim_set_hl
          hl(0, "MultiCursorCursor", { link = "Cursor" })
          hl(0, "MultiCursorVisual", { link = "Visual" })
          hl(0, "MultiCursorSign", { link = "SignColumn"})
          hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
          hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
          hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
      end
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
  },
}
