-- See `:help gitsigns` to understand what the configuration keys do
-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
  "gitsigns.nvim",
  enabled = not vim.g.vscode,
  event = "DeferredUIEnter",
  after = function()
    require('gitsigns').setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    })
  end,
}
