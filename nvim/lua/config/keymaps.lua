-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- This file is automatically loaded by lazyvim.config.init
local map = vim.keymap.set

-- Increment/descrement
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- paste over currently selected text without yanking it
map("v", "p", '"_dp')
map("v", "P", '"_dP')

map("n", "<leader>r", function()
  vim.ui.input({}, function(c)
    if c and c ~= "" then
      vim.cmd("noswapfile vnew")
      vim.bo.buftype = "nofile"
      vim.bo.bufhidden = "wipe"
      vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
    end
  end)
end, { desc = "Run cmd" })
