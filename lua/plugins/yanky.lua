return {
  "yanky.nvim",
  event = "DeferredUIEnter",
  after = function()
    require("yanky").setup({})

    vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
    vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")

    -- Linewise put 에서 붙여넣기 한 후 그 다음 라인으로 커서 이동
    -- vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
    -- vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

    vim.keymap.set("n", "[p", "<Plug>(YankyPreviousEntry)")
    vim.keymap.set("n", "]p", "<Plug>(YankyNextEntry)")

    -- Linewise put: this will force put above or below the current line
    vim.keymap.set("n", "gp", "<Plug>(YankyPutIndentAfterLinewise)")
    vim.keymap.set("n", "gP", "<Plug>(YankyPutIndentBeforeLinewise)")
    -- vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
    -- vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

    -- Shift right/left put: will put above or below the current line and increasing or decreasing indent
    -- vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
    -- vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
    -- vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
    -- vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

    -- Filter put: will put above or below the current line and reindenting.
    vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
    vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")

    vim.keymap.set("n", "<leader>yh", "<CMD>YankyRingHistory<CR>", { desc = "YankyRing History" })
  end,
}
