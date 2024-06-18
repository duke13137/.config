return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "ray-x/lsp_signature.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup({
      gofmt = "gofumpt",
      tag_transform = false,
      test_dir = "",
      comment_placeholder = "   ",
      lsp_cfg = true, -- false: use your own lspconfig
      lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
      lsp_on_attach = true, -- use on_attach from go.nvim
      dap_debug = true,
      dap_debug_gui = true,
      luasnip = true,
    })
  end,
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
