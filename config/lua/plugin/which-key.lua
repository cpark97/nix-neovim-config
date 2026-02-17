local function setup()
  if vim.g.vscode then
    return
  end

  vim.cmd.packadd("which-key.nvim")

  require("which-key").setup({})

  vim.keymap.set("n", "<leader>?", function()
    require("which-key").show({ global = false })
  end, { desc = "Buffer Local keymaps (which-key)" })
end

setup()
