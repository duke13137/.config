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
}
