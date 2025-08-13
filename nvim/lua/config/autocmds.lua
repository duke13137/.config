-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable autoformat for cljure files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "clojure" },
  callback = function()
    vim.b.autoformat = false
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown", "python" },
  callback = function()
    vim.diagnostic.enable(false, { bufnr = 0 })
  end,
})
