local function setup()
  if vim.g.vscode then
    return
  end

  vim.cmd.packadd("oil.nvim")

  local oil = require("oil")
  oil.setup({
    view_options = {
      show_hidden = true,
    },
  })

  vim.keymap.set("n", "-", oil.toggle_float, { desc = "Toggle Oil" })
end

setup()
