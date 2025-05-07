return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")

    mc.setup()

    local set = vim.keymap.set

    -- Add or skip cursor above/below the main cursor.
    set({ "n", "v" }, "<M-up>", function()
      mc.lineAddCursor(-1)
    end)
    set({ "n", "v" }, "<M-down>", function()
      mc.lineAddCursor(1)
    end)
    set({ "n", "v" }, "<up>", function()
      mc.lineSkipCursor(-1)
    end)
    set({ "n", "v" }, "<down>", function()
      mc.lineSkipCursor(1)
    end)

    -- Rotate the main cursor.
    set({ "n", "v" }, "<left>", mc.nextCursor)
    set({ "n", "v" }, "<right>", mc.prevCursor)

    -- Add and remove cursors with alt + left click.
    set("n", "<M-leftmouse>", mc.handleMouse)

    -- Easy way to add and remove cursors using the main cursor.
    set({ "n", "v" }, "<M-c>", mc.toggleCursor)

    -- Delete the main cursor.
    set({ "n", "v" }, "<M-d>", mc.deleteCursor)

    set("n", "<M-q>", function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      elseif mc.hasCursors() then
        mc.clearCursors()
      else
        -- Default <esc> handler.
      end
    end)

    -- Add or skip adding a new cursor by matching word/selection
    set({ "n", "v" }, "gb", function()
      mc.matchAddCursor(1)
    end)
    set({ "n", "v" }, "gB", function()
      mc.matchAddCursor(-1)
    end)

    -- Add all matches in the document
    set({ "n", "v" }, "gA", mc.matchAllAddCursors)

    -- bring back cursors if you accidentally clear them
    set("n", "gV", mc.restoreCursors)

    -- Align cursor columns.
    set("n", "g|", mc.alignCursors)

    -- Append/insert for each line of visual selections.
    set("v", "I", mc.insertVisual)
    set("v", "A", mc.appendVisual)

    -- match new cursors within visual selections by regex.
    set("v", "M", mc.matchCursors)

    -- Jumplist support
    set({ "v", "n" }, "<c-i>", mc.jumpForward)
    set({ "v", "n" }, "<c-o>", mc.jumpBackward)

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
