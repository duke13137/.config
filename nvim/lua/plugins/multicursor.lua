return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")

    mc.setup()

    local set = vim.keymap.set

    -- Add or skip cursor above/below the main cursor.
    set({ "n", "v" }, "<c-p>", function()
      mc.lineAddCursor(-1)
    end)
    set({ "n", "v" }, "<c-n>", function()
      mc.lineAddCursor(1)
    end)
    set({ "n", "v" }, "<up>", function()
      mc.lineSkipCursor(-1)
    end)
    set({ "n", "v" }, "<down>", function()
      mc.lineSkipCursor(1)
    end)

    -- Add or skip adding a new cursor by matching word/selection
    set({ "n", "v" }, "gn", function()
      mc.matchAddCursor(1)
    end)
    set({ "n", "v" }, "gN", function()
      mc.matchAddCursor(-1)
    end)

    -- Add all matches in the document
    set({ "n", "v" }, "gA", mc.matchAllAddCursors)

    -- You can also add cursors with any motion you prefer:
    -- set("n", "<right>", function()
    --     mc.addCursor("w")
    -- end)
    -- set("n", "<leader><right>", function()
    --     mc.skipCursor("w")
    -- end)

    -- Rotate the main cursor.
    set({ "n", "v" }, "<left>", mc.nextCursor)
    set({ "n", "v" }, "<right>", mc.prevCursor)

    -- Delete the main cursor.
    set({ "n", "v" }, "<c-q>", mc.deleteCursor)

    -- Easy way to add and remove cursors using the main cursor.
    set({ "n", "v" }, "<s-esc>", mc.toggleCursor)

    -- Add and remove cursors with alt + left click.
    set("n", "<A-leftmouse>", mc.handleMouse)

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
