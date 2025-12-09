return {
  {
    "ggml-org/llama.vim",
    init = function()
      vim.g.llama_config = {
        auto_fim = true,
        show_info = 1,
        keymap_trigger = "<C-l>",
        keymap_accept_line = "<Tab>",
        keymap_accept_full = "<S-Tab>",
        keymap_accept_word = "",
      }
    end,
  },

  {
    "GeorgesAlkhouri/nvim-aider",
    dependencies = {
      "folke/snacks.nvim",
    },
    cmd = "Aider",
    keys = {
      { "<leader>aa", "<cmd>Aider add<cr>", desc = "Aider: Add File" },
      { "<leader>ab", "<cmd>Aider buffer<cr>", desc = "Aider: Send Buffer" },
      { "<leader>ac", "<cmd>Aider command<cr>", desc = "Aider: Send Command" },
      { "<leader>ad", "<cmd>Aider drop<cr>", desc = "Aider: Drop File" },
      { "<leader>ar", "<cmd>Aider add readonly<cr>", desc = "Aider: Read File" },
      { "<leader>as", "<cmd>Aider send<cr>", desc = "Aider: Send", mode = { "n", "v" } },
      { "<leader>at", "<cmd>Aider toggle<cr>", desc = "Aider: Toggle Chat" },
    },
    opts = {
      args = {
        "--model",
        "flash",
        "--no-analytics",
        "--no-auto-commits",
        "--yes-always",
        "--watch-files",
      },
      win = {
        position = "right",
        wo = { winbar = "Aider" },
      },
    },
  },
}
