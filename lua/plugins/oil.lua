return {
  "oil.nvim",
  enabled = not vim.g.vscode,
  after = function()
    local oil = require("oil")
    oil.setup({
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        -- conflicts leap.nvim
        ["gs"] = false,
      },
    })
    vim.keymap.set("n", "-", oil.toggle_float, { desc = "Toggle Oil" })
  end,
}
