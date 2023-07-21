require("lspconfig").fennel_ls.setup({})

vim.opt.iskeyword:append(".,:")

local wk = require("which-key")
wk.register({
  e = { "eval" },
  g = { "godo" },
  l = { "log" },
  r = { "reload" },
  t = { "test" },
  v = { "view" },
}, { prefix = "<localleader>", mode = "n", silent = true })

-- need <Left>...<Right> here to expand <cexpr> in lisp parens
vim.keymap.set("i", "<C-j>", "<Left><C-o>:ConjureEval ,complete <C-r>=expand('<cexpr>')<CR><CR><Right>")

local command = vim.api.nvim_create_user_command
command("FnlApropos", "ConjureEval ,apropos <args>", { nargs = 1 })
command("FnlComplete", "ConjureEval ,complete <args>", { nargs = 1 })
command("FnlDoc", "ConjureEval ,doc <args>", { nargs = 1 })
command("FnlFind", "ConjureEval ,find <args>", { nargs = 1 })
command("FnlReload", "ConjureEval ,reload <args>", { nargs = 1 })
