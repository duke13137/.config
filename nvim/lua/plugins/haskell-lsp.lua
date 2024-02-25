return {
  "mrcjkb/haskell-tools.nvim",
  version = "^3",
  ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  cond = function()
    return vim.fn.filereadable("hls.json") ~= 0 and true
  end,
  keys = {
    {
      "<leader>ch",
      function()
        require("haskell-tools").hoogle.hoogle_signature()
      end,
      mode = { "n" },
      desc = "Hoogle search",
    },
  },
  init = function()
    vim.g.haskell_tools = {
      hls = {
        default_settings = {
          haskell = { -- haskell-language-server options
            -- Setting this to true could have a performance impact on large mono repos.
            checkProject = false,
            formattingProvider = "fourmolu",
            plugin = {
              eval = { globalOn = false },
              -- fourmolu = { config = { external = true } },
              -- hlint = { globalOn = false },
              importLens = { codeLensOn = false },
              retrie = { globalOn = false },
              splice = { globalOn = false },
              stan = { globalOn = false },
              tactics = { globalOn = false },
            },
          },
        },
      },
      tools = {
        codeLens = {
          autoRefresh = true,
        },
        hover = {
          enable = false,
          auto_focus = false,
          stylize_markdown = true,
        },
        repl = {
          handler = "toggleterm",
          prefer = function()
            return vim.fn.executable("stack") == 1 and "stack" or "cabal"
          end,
        },
      },
    }
  end,
}
