return {

  { "theHamsta/nvim-dap-virtual-text", pin = true, lazy = true },

  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>dc",
        function()
          vim.fn.sign_define("DapStopped", { text = "🛑", texthl = "DapBreakpoint" })
          local dap = require("dap")
          dap.adapters.lldb = dap.adapters.codelldb
          if vim.fn.filereadable(".vscode/launch.json") then
            require("dap.ext.vscode").load_launchjs(nil, { lldb = { "c", "cpp" } })
          end
          dap.continue()
        end,
        desc = "Continue",
      },
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Dap UI",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval()
        end,
        desc = "Eval",
        mode = { "n", "v" },
      },
    },
    opts = {},
    config = function(_, opts)
      -- setup dap config by VsCode launch.json file
      -- require("dap.ext.vscode").load_launchjs()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },
}
