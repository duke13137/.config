return {
  {
    "preservim/tagbar",
    keys = {
      { "<leader>ct", "<Cmd>TagbarToggle<CR>", desc = "Toggle Tagbar" },
    },
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
    "Mythos-404/xmake.nvim",
    version = "^3",
    lazy = true,
    event = "BufReadPost xmake.lua",
    config = true,
  },
}
