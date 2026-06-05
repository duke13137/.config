return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "nvim-dap-ui",
        opts = {
          layouts = {
            {
              position = "top",
              size = 0.3,
              elements = {
                { id = "scopes", size = 0.6 },
                { id = "stacks", size = 0.4 },
              },
            },
            {
              position = "bottom",
              size = 0.3,
              elements = {
                { id = "repl", size = 0.6 },
                { id = "console", size = 0.4 },
              },
            },
          },
        },
      },
    },
  },

  {
    "jonboh/nvim-dap-rr",
    dependencies = { "nvim-dap" },
    config = function()
      local dap = require("dap")
      local rr = require("nvim-dap-rr")
      table.insert(dap.configurations.c, rr.get_config())
    end,
  },
}
