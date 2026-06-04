return {
  {
    "milanglacier/minuet-ai.nvim",
    config = function()
      require("minuet").setup {
        provider = "openai_fim_compatible",
        provider_options = {
          openai_fim_compatible = {
            model = "deepseek-v4-flash",
            end_point = "https://api.deepseek.com/beta/completions",
            api_key = "DEEPSEEK_API_KEY",
            name = "deepseek",
            stream = true,
            optional = {
              max_tokens = 256,
              stop = { "\n\n" },
              top_p = 0.9,
            },
          },
        },
      }
    end,
  },

  {
    "saghen/blink.cmp",
    dependencies = { "saghen/blink.lib" },
    opts = {
      keymap = {
        preset = "default",
        ["<C-l>"] = {
          function(cmp)
            cmp.show { providers = { "minuet" } }
          end,
        },
      },
      completion = {
        ghost_text = { enabled = false },
        trigger = { prefetch_on_insert = false },
      },
      signature = { enabled = true },
      sources = {
        -- if you want to use auto-complete
        -- default = { "minuet" },
        providers = {
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            async = true,
            timeout_ms = 3000,
            score_offset = 100,
          },
        },
      },
    },
  },
}
