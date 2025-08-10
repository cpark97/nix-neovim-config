return {
  "nvim-ts-autotag",
  enabled = not vim.g.vscode,
  event = "DeferredUIEnter",
  after = function()
    require("nvim-ts-autotag").setup({})
  end,
}
