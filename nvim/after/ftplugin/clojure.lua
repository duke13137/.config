vim.cmd "iabbrev <buffer> !spy (when (and) (sc.api/spy))"
vim.cmd "inoremap <buffer> (  ("
vim.cmd "inoremap <buffer> '  '"
vim.cmd "inoremap <buffer> `  `"

if vim.g.vscode then
  return
end

local wk = require("which-key")
wk.add({
  { "<localleader>c", group = "connect" },
  { "<localleader>d", group = "debug" },
  { "<localleader>e", group = "eval" },
  { "<localleader>i", group = "inspect" },
  { "<localleader>l", group = "log" },
  { "<localleader>p", group = "portal" },
  { "<localleader>r", group = "reload" },
  { "<localleader>s", group = "session" },
  { "<localleader>t", group = "test" },
  { "<localleader>v", group = "view" },
  { "<localleader>x", group = "macroexpand" },
})

local function options(desc)
  return { buffer = true, noremap = true, silent = true, desc = desc }
end

local map = vim.keymap.set
-- Reload
map(
  "n",
  ",rr",
  ":<C-u>ConjureEval ((requiring-resolve 'clj-reload.core/reload))<CR>",
  options("Reload changed namespaces")
)
map("n", ",rs", ":ConjureEval ((requiring-resolve 'malli.dev/start!))<CR>", options("Start malli.dev"))
map("n", ",rt", ":ConjureEval ((requiring-resolve 'malli.dev/stop!))<CR>", options("Stop malli.dev"))

-- Scope-capture
map(
  "n",
  ",ds",
  [[ :ConjureEval (do (require 'sc.api) (in-ns 'user) (defn read-spy [form] (require 'sc.api) `(sc.api/spy ~form)) (defn read-letsc [form] `(sc.api/letsc ~((requiring-resolve 'sc.api/last-ep-id)) ~form)) (set! *data-readers* (assoc *data-readers* 'sc/letsc #'read-letsc 'sc/spy #'read-spy)))<CR> ]],
  options("setup capture")
)
map("n", ",di", ":ConjureEval (tap> (sc.api/ep-info))<CR>", options("tap ep-info"))
map("n", ",dl", ":ConjureEval (eval `(sc.api/defsc ~(sc.api/last-ep-id)))<CR>", options("def locals"))
map("n", ",du", ":ConjureEval (eval `(sc.api/undefsc ~(sc.api/last-ep-id)))<CR>", options("undef locals "))
map("n", ",dU", ":ConjureEval ((requiring-resolve 'sc.api/dispose-all!))<CR>", options("undef all locals"))
map("v", ",e", 'y :<C-u>ConjureEval #sc/letsc <C-r>=@"<CR><CR>', options("eval letsc"))

-- Portal
map(
  "n",
  ",pp",
  [[ :ConjureEval (do (in-ns 'user) (require '[portal.api :as p]) (add-tap #'p/submit) (def p (p/open)))<CR> ]],
  options("portal")
)
map("n", ",p1", ":ConjureEval (tap> *1)<CR>", options("tap *1"))
map("n", ",p2", ":ConjureEval (tap> *2)<CR>", options("tap *2"))
map("n", ",p3", ":ConjureEval (tap> *2)<CR>", options("tap *3"))
map("n", ",pe", ":ConjureEval ((requiring-resolve 'clj-commons.pretty.repl/pretty-pst))<CR>", options("pst *e*"))

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufEnter", {
  pattern = "*.clj",
  callback = function()
    vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = "bb nrepl-server localhost:$port"
  end,
})

autocmd("BufEnter", {
  pattern = "*.cljs",
  callback = function()
    vim.g["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = "npx nbb nrepl-server :port $port"
  end,
})
