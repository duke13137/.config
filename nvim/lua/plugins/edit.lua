return {
  {
    "MagicDuck/grug-far.nvim",
    opts = {
      keymaps = {
        replace = { n = "gr" },
        qflist = { n = "gq" },
        syncLocations = { n = "gs" },
        syncLine = { n = "gl" },
        close = { n = "gc" },
        historyOpen = { n = "gt" },
        historyAdd = { n = "ga" },
        refresh = { n = "gf" },
        openLocation = { n = "go" },
        openNextLocation = { n = "<down>" },
        openPrevLocation = { n = "<up>" },
        gotoLocation = { n = "<enter>" },
        pickHistoryEntry = { n = "<enter>" },
        abort = { n = "gb" },
        help = { n = "g?" },
        toggleShowCommand = { n = "gp" },
        swapEngine = { n = "ge" },
        previewLocation = { n = "gi" },
        swapReplacementInterpreter = { n = "gx" },
        applyNext = { n = "gj" },
        applyPrev = { n = "gk" },
      },
    },
  },

  {
    "nvim-mini/mini.surround",
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
    "mbbill/undotree",
    dependencies = { "tpope/vim-repeat" },
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "folke/snacks.nvim",
    },
  },
}
