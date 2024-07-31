local M = {
  { "mrcjkb/neotest-haskell", enabled = false },
  {
    "mrcjkb/haskell-tools.nvim",
    cond = function()
      return vim.fn.filereadable("hls.json") ~= 0 and true
    end,
  },
  {
    "fonghou/fzf-hoogle.vim",
    ft = "haskell",
    dependencies = {
      "junegunn/fzf",
      "mrcjkb/haskell-snippets.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      if vim.fn.filereadable(".hiedb") ~= 0 then
        require "lspconfig".hls.setup { cmd = { "static-ls" } }
      end
    end,
  },
}

function M.ghcid()
  local null_ls = require("null-ls")
  local helpers = require("null-ls.helpers")
  local utils = require("null-ls.utils")
  return {
    name = "ghcid",
    meta = { url = "https://github.com/ndmitchell/ghcid" },
    method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    filetypes = { "haskell" },
    generator = helpers.generator_factory({
      command = "bash",
      args = {
        "-c",
        [[ sleep 1 && [ -f ghcid.txt ] && cat ghcid.txt \
          | grep -A2 -E '.*[^>]: (error|warning):' \
          | grep -v '\--' \
          | paste -s -d'\0\t\n' - \
          | tr -s '\t' ' '
      ]],
      },
      format = "line",
      multiple_files = true,
      on_output = function(line, _)
        local filename, row, end_row, col, end_col, severity, message =
          line:match("([^:]+):%(?(%d+)[-,]?(%d*)%)?[:-]%(?(%d+)[-,]?(%d*)%)?:%s*(%w+):.+]%s*(.+)")

        if end_col == nil or end_col == "" then
          end_col = col
        end

        if end_row == nil or end_row == "" then
          end_row = row
        else
          end_row, col = col, end_row
        end

        return {
          filename = filename,
          row = row,
          end_row = end_row,
          col = col,
          end_col = end_col + 1,
          severity = helpers.diagnostics.severities[severity],
          message = message,
        }
      end,
    }),
    cwd = helpers.cache.by_bufnr(function(params)
      return utils.root_pattern("ghcid.txt")(params.bufname)
    end),
  }
end

function M.hlint()
  local null_ls = require("null-ls")
  local helpers = require("null-ls.helpers")
  return {
    name = "hlint",
    meta = { url = "https://github.com/ndmitchell/hlint" },
    method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    filetypes = { "haskell" },
    generator = helpers.generator_factory({
      command = "hlint",
      args = { "--json", "$FILENAME" },
      format = "json",
      check_exit_code = { 1 },
      ignore_stderr = true,
      on_output = function(params)
        local diagnostics = {}
        local severities = {
          Warning = 3,
          Suggestion = 4,
        }
        for _, o in ipairs(params.output) do
          table.insert(diagnostics, {
            row = o.startLine,
            end_row = o.endLine,
            col = o.startColumn,
            end_col = o.endColumn,
            message = o.hint,
            severity = severities[o.severity],
          })
        end
        return diagnostics
      end,
    }),
  }
end

return M
