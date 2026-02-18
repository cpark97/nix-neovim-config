local function setup()
  if vim.g.vscode then
    return
  end

  vim.cmd.packadd("monokai-pro.nvim")

  require("monokai-pro").setup({ filter = "pro" })

  vim.cmd.colorscheme("monokai-pro")
end

setup()
