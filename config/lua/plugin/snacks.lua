local function setup()
  if vim.g.vscode then
    return
  end

  require("snacks").setup({
    indent = { enabled = not vim.g.vscode },
    input = { enabled = not vim.g.vscode },
    notifier = { enabled = not vim.g.vscode },
    scratch = { enabled = not vim.g.vscode },
    explorer = {
      enabled = not vim.g.vscode,
      replace_netrw = false,
      trash = true,
    },
  })

  vim.keymap.set("n", "<leader>N", function()
    Snacks.notifier.show_history()
  end, { desc = "[N]otification history (Snacks)" })

  vim.keymap.set("n", "<leader>s", function()
    Snacks.scratch()
  end, { desc = "Toggle Scratch Buffer (Snacks)" })

  vim.keymap.set("n", "<leader>S", function()
    Snacks.scratch.select()
  end, { desc = "[S]elect Scratch Buffer (Snacks)" })
end

setup()
