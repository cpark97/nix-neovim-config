local function setup()
  if vim.g.vscode then
    return
  end

  vim.cmd.packadd("fidget.nvim")
  require("fidget").setup({})
end

setup()
