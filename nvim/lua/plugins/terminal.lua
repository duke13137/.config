local M = {
  "akinsho/nvim-toggleterm.lua",
  dependencies = {
    "alexghergh/nvim-tmux-navigation",
    "mtikekar/nvim-send-to-term",
  },
}

function M.init()
  vim.cmd([[
    command -nargs=1 Repl :call g:send_target.send(["<args>"])
    nnoremap <silent>,<CR>  <Plug>SendLine
    nnoremap <silent>,;     <Plug>Send$
    xnoremap <silent>,<CR>  <Plug>Send
  ]])

  vim.g.send_disable_mapping = true
  vim.g.send_multiline = {
    ghci = {
      begin = ":{\n",
      ["end"] = "\n:}\n",
      newline = "\n",
    },
    aider = {
      begin = "{code\n\n",
      ["end"] = "\n\ncode}\n",
      newline = "\n",
    },
  }
end

function M.config()
  require("nvim-tmux-navigation").setup({
    disable_when_zoomed = true, -- defaults to false
    keybindings = {
      left = "<C-h>",
      down = "<C-j>",
      up = "<C-k>",
      right = "<C-l>",
    },
  })

  require("toggleterm").setup({
    -- size can be a number or function which is passed the current terminal
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.45
      end
    end,
    open_mapping = "<M-/>",
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    persist_mode = true,
    direction = "float", -- 'vertical' | 'horizontal' | 'window' | 'float',
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      -- The border key is *almost* the same as 'nvim_win_open'
      -- see :h nvim_win_open for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      border = "single", -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      -- width = <value>,
      -- height = <value>,
      winblend = 3,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  })

  function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
  end

  -- if you only want these mappings for toggle term use term://*toggleterm#* instead
  vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
end

return M
