return {
  "todo-comments.nvim",
  event = "DeferredUIEnter",
  enabled = not vim.g.vscode,
  before = function()
    require("lz.n").trigger_load({ "nvim-lua/plenary.nvim" })
  end,
  after = function()
    require("todo-comments").setup({ signs = false })
  end,
}
