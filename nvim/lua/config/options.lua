-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.maplocalleader = ","

local opt = vim.opt
opt.mousemodel = "extend"
opt.relativenumber = false
opt.exrc = true
opt.list = true
opt.listchars = {
  leadmultispace = "│ ",
  tab = "│ ",
}
