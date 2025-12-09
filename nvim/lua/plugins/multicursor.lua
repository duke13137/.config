return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")

    mc.setup()

    local set = vim.keymap.set

    -- Add or skip cursor above/below the main cursor.
    set({ "n", "x" }, "<M-up>", function()
      mc.lineAddCursor(-1)
    end)
    set({ "n", "x" }, "<M-down>", function()
      mc.lineAddCursor(1)
    end)
    set({ "n", "x" }, "<M-S-up>", function()
      mc.lineSkipCursor(-1)
    end)
    set({ "n", "x" }, "<M-S-down>", function()
      mc.lineSkipCursor(1)
    end)

    -- Easy way to add and remove cursors using the main cursor.
    set({ "n", "x" }, "<M-x>", mc.toggleCursor)

    set("n", "<M-v>", function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      elseif mc.hasCursors() then
        mc.clearCursors()
      else
        mc.restoreCursors()
      end
    end)

    -- Rotate the main cursor.
    set({ "n", "x" }, "<left>", mc.nextCursor)
    set({ "n", "x" }, "<right>", mc.prevCursor)

    -- Add and remove cursors with alt + left click.
    set("n", "<M-leftmouse>", mc.handleMouse)

    set({ "n", "x" }, "gA", mc.matchAllAddCursors, { desc = "Cursor: Add All Match" })
    -- Add or skip adding a new cursor by matching word/selection
    set({ "n", "x" }, "gb", function()
      mc.matchAddCursor(1)
    end, { desc = "Cursor: Add Match Next " })
    set({ "n", "x" }, "gB", function()
      mc.matchSkipCursor(1)
    end, { desc = "Cursor: Skip Match Next" })

    -- Add a cursor and jump to the next/previous search result.
    set("n", "gj", function()
      mc.searchAddCursor(1)
    end, { desc = "Cursor: Add Search Next" })
    set("n", "gJ", function()
      mc.searchSkipCursor(1)
    end, { desc = "Cursor: Skip Search Next" })
    -- Add all matches in the document
    set({ "n", "x" }, "gS", mc.searchAllAddCursors, { desc = "Cursor: Add All Search" })

    -- Align cursor columns.
    set("n", "g|", mc.alignCursors, { desc = "Align Cursor Columns" })

    -- Append/insert for each line of visual selections.
    set("x", "I", mc.insertVisual)
    set("x", "A", mc.appendVisual)

    -- match new cursors within visual selections by regex.
    set("x", "M", mc.matchCursors)

    -- Jumplist support
    set({ "x", "n" }, "<c-i>", mc.jumpForward)
    set({ "x", "n" }, "<c-o>", mc.jumpBackward)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { link = "Cursor" })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
