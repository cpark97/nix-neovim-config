return {
  "alpha-nvim",
  enabled = not vim.g.vscode,
  before = function()
    require("lz.n").trigger_load({ "nvim-web-devicons" })
  end,
  after = function()
    require("alpha").setup(require("alpha.themes.startify").config)
  end,
}
