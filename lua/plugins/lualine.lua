return {
  'lualine.nvim',
  enabled = not vim.g.vscode,
  before = function()
    require("lz.n").trigger_load({ "nvim-web-devicons" })
  end,
  after = function()
    require('lualine').setup()
  end
}
