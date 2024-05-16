return {
  {
    "Olical/conjure",
    branch = "develop",
    ft = { "clojure", "fennel", "lua" },
    dependencies = {
      { "Olical/nfnl", ft = "fennel" },
      "m00qek/baleia.nvim",
      "harrygallagher4/nvim-parinfer-rust",
      { "eraserhd/parinfer-rust", build = "cargo build --release" },
    },
    init = function()
      vim.g["conjure#log#hud#width"] = 1.0
      vim.g["conjure#log#hud#enabled"] = true
      vim.g["conjure#log#hud#anchor"] = "SE"
      vim.g["conjure#log#botright"] = true
      vim.g["conjure#extract#context_header_lines"] = 100
      vim.g["conjure#client#clojure#nrepl#eval#raw_out"] = true
      vim.g["conjure#client#clojure#nrepl#eval#auto_require"] = false
      vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = true
      vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
      vim.g["conjure#client#clojure#nrepl#mapping#refresh_changed"] = "rR"
      vim.g["conjure#log#strip_ansi_escape_sequences_line_limit"] = 0
      vim.g["conjure#mapping#eval_motion"] = ","
      vim.g["conjure#mapping#eval_visual"] = ","
      vim.g["conjure#mapping#doc_word"] = "vd"
    end,
    config = function()
      local baleia = require("baleia").setup({ line_starts_at = 3 })
      vim.api.nvim_create_autocmd("BufWinEnter", {
        pattern = { "conjure-log-*" },
        callback = function()
          vim.diagnostic.disable(0)
          baleia.automatically(vim.api.nvim_get_current_buf())
        end,
      })
    end,
  },

  {
    "nvim-cmp",
    dependencies = {
      "PaterJason/cmp-conjure",
      ft = { "clojure", "fennel", "lua" },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "conjure" },
      }))
    end,
  },
}
