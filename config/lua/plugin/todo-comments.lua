local function setup()
  if vim.g.vscode then
    return
  end

  vim.cmd.packadd("todo-comments.nvim")

  require("todo-comments").setup({
    signs = false,
  })

  vim.keymap.set(
    "n",
    "<leader>tt",
    "<cmd>Trouble todo<cr>",
    { desc = "Trouble todo comments" }
  )
end

setup()
