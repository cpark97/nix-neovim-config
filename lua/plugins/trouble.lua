return {
  "trouble.nvim",
  enabled = not vim.g.vscode,
  cmd = "Trouble",
  keys = {
    { "<leader>tP", "<CMD>Trouble diagnostics toggle<CR>", desc = "Trouble Diagnostics" },
    {
      "<leader>tp",
      "<CMD>Trouble diagnostics toggle filter.buf=0<CR>",
      desc = "Trouble Document Diagnostics",
    },
    {
      "<leader>ts",
      "<CMD>Trouble symbols toggle win.position=bottom focus=true<CR>",
      desc = "Trouble Symbol",
    },
    {
      "<leader>tl",
      "<CMD>Trouble lsp toggle<CR>",
      desc = "Trouble Lsp",
    },
    {
      "<leader>to",
      "<CMD>Trouble loclist toggle<CR>",
      desc = "Trouble Location List",
    },
    {
      "<leader>tq",
      "<CMD>Trouble qflist toggle<CR>",
      desc = "Trouble Quickfix List",
    },
  },
  after = function()
    require("trouble").setup({
      focus = true,
      win = {
        position = "bottom",
      },
    })
  end,
}
