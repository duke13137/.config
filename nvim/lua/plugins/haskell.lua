local M = {
  "mrcjkb/haskell-tools.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "preservim/tagbar",
  },
  branch = "2.x.x",
  lazy = false,
}

function M.init()
  vim.g.haskell_tools = {
    hls = {
      default_settings = {
        haskell = { -- haskell-language-server options
          -- Setting this to true could have a performance impact on large mono repos.
          checkProject = false,
          formattingProvider = "fourmolu",
          plugin = {
            eval = { globalOn = false },
            -- hlint = { globalOn = false },
            importLens = { codeLensOn = false },
            retrie = { globalOn = false },
            splice = { globalOn = false },
            tactics = { globalOn = false },
          },
        },
      },
    },
    tools = {
      hover = {
        auto_focus = false,
        stylize_markdown = true,
      },
      repl = {
        handler = "toggleterm",
        prefer = function()
          return vim.fn.executable("stack") == 1 and "stack" or "cabal"
        end,
      },
    },
  }
end

function M.ghcid()
  local helpers = require("null-ls.helpers")
  local methods = require("null-ls.methods")
  local utils = require("null-ls.utils")
  return {
    name = "ghcid",
    meta = { url = "https://github.com/ndmitchell/ghcid" },
    method = methods.internal.DIAGNOSTICS_ON_SAVE,
    filetypes = { "haskell" },
    generator = helpers.generator_factory({
      command = "bash",
      args = {
        "-c",
        [[ sleep 1 && [ -f ghcid.log ] && cat ghcid.log \
          | grep -A2 -E '.*: (error|warning):' \
          | grep -v '\--' \
          | paste -s -d'\0\t\n' - \
          | tr -s '\t' ' '
      ]],
      },
      format = "line",
      multiple_files = true,
      on_output = function(line, _)
        local filename, row, end_row, col, end_col, severity, message =
          line:match("([^:]+):%(?(%d+)[-,]?(%d*)%)?[:-]%(?(%d+)[-,]?(%d*)%)?:%s*(%w+):%s*(.*)")

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
      return utils.root_pattern(".ghci*")(params.bufname)
    end),
  }
end

function M.hlint()
  local helpers = require("null-ls.helpers")
  local methods = require("null-ls.methods")
  return {
    name = "hlint",
    meta = { url = "https://github.com/ndmitchell/hlint" },
    method = methods.internal.DIAGNOSTICS_ON_SAVE,
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
