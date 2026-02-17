local function setup()
  if vim.g.vscode then
    return
  end

  vim.cmd.packadd("trouble.nvim")

  require("trouble").setup({})

  local keymaps = {
    {
      "<leader>td",
      "<CMD>Trouble diagnostics toggle<CR>",
      desc = "Trouble Diagnostics",
    },
    {
      "<leader>tD",
      "<CMD>Trouble diagnostics toggle filter.buf=0<CR>",
      desc = "Trouble Document Diagnostics",
    },
    {
      "<leader>to",
      "<CMD>Trouble symbols toggle win.position=bottom focus=true<CR>",
      desc = "Trouble Document Symbol",
    },
    {
      "<leader>tL",
      "<CMD>Trouble lsp toggle<CR>",
      desc = "Trouble Lsp",
    },
    {
      "<leader>tl",
      "<CMD>Trouble loclist toggle<CR>",
      desc = "Trouble Location List",
    },
    {
      "<leader>tq",
      "<CMD>Trouble qflist toggle<CR>",
      desc = "Trouble Quickfix List",
    },
  }

  for index, keymap in ipairs(keymaps) do
    local key = keymap[1]
    local fn = keymap[2]
    local desc = keymap.desc

    vim.keymap.set("n", key, fn, { desc = desc })
  end
end

setup()
