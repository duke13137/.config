return {
  {
    "ggml-org/llama.vim",
    init = function()
      vim.g.llama_config = {
        auto_fim = true,
        show_info = false,
      }
    end,
  },
  {
    "GeorgesAlkhouri/nvim-aider",
    cmd = {
      "AiderTerminalToggle",
    },
    keys = {
      { "<leader>aa", "<cmd>AiderQuickAddFile<cr>", desc = "Aider: Add File" },
      { "<leader>ad", "<cmd>AiderQuickDropFile<cr>", desc = "Aider: Drop File" },
      { "<leader>ai", "<cmd>AiderTerminalToggle<cr>", desc = "Aider: Open Terminal " },
      { "<leader>al", "<cmd>AiderTerminalSend<cr>", desc = "Aider: Send", mode = { "n", "v" } },
      { "<leader>aL", "<cmd>AiderQuickSendBuffer<cr>", desc = "Aider: Send Buffer" },
      { "<leader>ak", "<cmd>AiderQuickSendCommand<cr>", desc = "Aider: Send Command" },
    },
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      args = {
        "--model",
        "g2pro",
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
