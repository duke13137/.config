return {
  { "Olical/nfnl", ft = "fennel" },

  {
    "Olical/conjure",
    branch = "main",
    ft = { "clojure", "fennel", "lua" },
    dependencies = { "m00qek/baleia.nvim" },

    init = function()
      vim.g["conjure#log#hud#width"] = 1.0
      vim.g["conjure#log#hud#enabled"] = true
      vim.g["conjure#log#hud#anchor"] = "SE"
      vim.g["conjure#log#botright"] = true
      vim.g["conjure#extract#context_header_lines"] = 100
      vim.g["conjure#highlight#enabled"] = true
      vim.g["conjure#client#clojure#nrepl#eval#auto_require"] = false
      vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = true
      vim.g["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = true
      vim.g["conjure#client#clojure#nrepl#mapping#refresh_changed"] = "rR"
      vim.g["conjure#client#sql#stdio#command"] = "sqlite3"
      vim.g["conjure#client#sql#stdio#prompt_pattern"] = "sqlite> "
      vim.g["conjure#mapping#eval_motion"] = ","
      vim.g["conjure#mapping#eval_visual"] = ","
      vim.g["conjure#mapping#doc_word"] = "k"
      vim.g["conjure#mapping#def_word"] = "g"
      vim.g["conjure#log#strip_ansi_escape_sequences_line_limit"] = 0
      vim.filetype.add({
        extension = {
          lpy = "clojure",
        },
      })
      vim.api.nvim_create_augroup("conjure_set_state_on_filetype", { clear = true })
      vim.api.nvim_create_autocmd("BufEnter", {
        group = "conjure_set_state_on_filetype",
        pattern = { "*.clj", "*.cljs", "*.lpy" },
        callback = function()
          local ext = vim.fn.expand("%:e")
          vim.cmd("ConjureClientState " .. ext)
          if ext == "clj" then
            vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = "bb nrepl-server localhost:$port"
          elseif ext == "cljs" then
            vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = "npx nbb nrepl-server :port $port"
          end
        end,
      })
    end,

    config = function()
      local baleia = require("baleia").setup({ line_starts_at = 3 })
      vim.api.nvim_create_autocmd("BufWinEnter", {
        pattern = { "conjure-log-*" },
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          vim.diagnostic.enable(false, { bufnr = buffer })
          baleia.automatically(buffer)

          vim.keymap.set(
            { "n", "v" },
            "[c",
            "<CMD>call search('^; -\\+$', 'bw')<CR>",
            { silent = true, buffer = true, desc = "Jumps to the begining of previous evaluation output." }
          )
          vim.keymap.set(
            { "n", "v" },
            "]c",
            "<CMD>call search('^; -\\+$', 'w')<CR>",
            { silent = true, buffer = true, desc = "Jumps to the begining of next evaluation output." }
          )
        end,
      })
    end,
  },

  {
    "harrygallagher4/nvim-parinfer-rust",
    event = "LazyFile",
    dependencies = { "eraserhd/parinfer-rust", build = "cargo build --release" },
  },

  {
    "julienvincent/nvim-paredit",
    config = function()
      require("nvim-paredit").setup()
    end,
  },
}
