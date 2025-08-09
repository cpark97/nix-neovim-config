return {
  "which-key.nvim",
  enabled = not vim.g.vscode,
  event = "DeferredUIEnter",
  after = function()
    require("which-key").setup({})

    vim.keymap.set("n", "<leader>?", function()
      require("which-key").show({ global = false })
    end, { desc = "Buffer Local keymaps (which-key)" })
  end,
}
