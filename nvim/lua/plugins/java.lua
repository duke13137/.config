local function checker()
  local null_ls = require("null-ls")
  local helpers = require("null-ls.helpers")
  return {
    name = "Checker",
    meta = { url = "https://github.com/eisopux/javac-diagnostics-wrapper" },
    method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    filetypes = { "java" },
    generator = helpers.generator_factory({
      command = "cat",
      args = { "nullness.log" },
      format = "json_raw",
      ignore_stderr = true,
      on_output = function(params)
        print(params.err)
        local diagnostics = {}
        for _, o in ipairs(params.output["diagnostics"]) do
          local pos = o.endPosition - o.startPosition
          table.insert(diagnostics, {
            row = o.lineNumber,
            end_row = o.lineNumber,
            col = o.columnNumber,
            end_col = o.columnNumber + pos,
            message = o.message,
            severity = 1,
          })
        end
        return diagnostics
      end,
    }),
  }
end

return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      test = {
        config_overrides = {
          vmArgs = "",
        },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      opts.debug = true
      vim.list_extend(opts.sources, {
        checker(),
      })
    end,
  },
}
