return {
  "snacks.nvim",
  before = function()
    require("lz.n").trigger_load({ "nvim-web-devicons" })
  end,
  after = function()
    require("snacks").setup({
      indent = { enabled = not vim.g.vscode },
      input = { enabled = not vim.g.vscode },
      notifier = { enabled = not vim.g.vscode },
      scratch = { enabled = not vim.g.vscode },
    })

    vim.keymap.set("n", "<leader>N", function()
      Snacks.notifier.show_history()
    end, { desc = "[N]otification history (Snacks)" })
    vim.keymap.set("n", "<leader>.", function()
      Snacks.scratch()
    end, { desc = "Toggle Scratch Buffer (Snacks)" })
    vim.keymap.set("n", "<leader>S", function()
      Snacks.scratch.select()
    end, { desc = "[S]elect Scratch Buffer (Snacks)" })
  end,
}
