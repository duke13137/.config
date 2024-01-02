-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.maplocalleader = ","

local opt = vim.opt
opt.relativenumber = false
opt.exrc = true
opt.list = true
opt.listchars = {
  leadmultispace = "│ ",
  tab = "│ ",
}

vim.lsp.set_log_level("off")
