local M = {
  "Olical/conjure",
  branch = "develop",
  ft = { "clojure", "fennel", "python" },
  dependencies = {
    { "Olical/nfnl", ft = "fennel" },
    "m00qek/baleia.nvim",
    "harrygallagher4/nvim-parinfer-rust",
    { "eraserhd/parinfer-rust", build = "cargo build --release" },
  },
}

function M.init()
  vim.g["conjure#client#clojure#nrepl#eval#auto_require"] = false
  vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = true
  vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
  vim.g["conjure#client#clojure#nrepl#mapping#refresh_changed"] = "rR"
  vim.g["conjure#log#strip_ansi_escape_sequences_line_limit"] = 0
  vim.g["conjure#mapping#eval_motion"] = ","
  vim.g["conjure#mapping#eval_visual"] = ","
  vim.g["conjure#mapping#doc_word"] = "vd"
end

function M.config()
  local baleia = require("baleia").setup({ line_starts_at = 3 })
  vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = { "conjure-log-*" },
    callback = function()
      vim.diagnostic.disable(0)
      baleia.automatically(vim.api.nvim_get_current_buf())
    end,
  })
end

return M
