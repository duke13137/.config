return {
  {
    "ggml-org/llama.vim",
  },
  {
    "editor-code-assistant/eca-nvim",
    dependencies = {
      "MunifTanjim/nui.nvim", -- Required: UI framework
      "nvim-lua/plenary.nvim", -- Optional: Enhanced async operations
      "folke/snacks.nvim", -- Optional: Picker for server messages/tools
    },
    keys = {
      { "<leader>aa", "<cmd>EcaChatAddFile %<cr>", desc = "ECA Add file" },
      { "<leader>ab", "<cmd>EcaChatAddSelection<cr>", desc = "ECA Add selection", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>EcaChat<cr>", desc = "ECA Open chat" },
      { "<leader>af", "<cmd>EcaFocus<cr>", desc = "ECA Focus chat" },
      { "<leader>at", "<cmd>EcaToggle<cr>", desc = "ECA Toggle sidebar" },
    },
    opts = {
      debug = false,
      server_path = "",
      behavior = {
        auto_set_keymaps = true,
        auto_focus_sidebar = true,
      },
    },
  },
}
