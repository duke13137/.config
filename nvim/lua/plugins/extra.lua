return {
  { "tpope/vim-fugitive" },

  {
    "mbbill/undotree",
    dependencies = { "tpope/vim-repeat" },
  },

  {
    "preservim/tagbar",
    keys = { { "<leader>ct", "<Cmd>TagbarToggle<CR>", desc = "Toggle Tagbar" } },
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
}
