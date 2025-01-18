return {
  "neo-tree.nvim",
  enabled = not vim.g.vscode,
  keys = {
    { "<leader>n", ":Neotree filesystem reveal left toggle<CR>", { desc = "Toggle Neotree" } }
  },
  before = function()
    require("lz.n").trigger_load({ "plenary.nvim", "nvim-web-devicons" })
    require("lz.n").load({ "nui.nvim" })
  end,
  after = function()
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false, -- only works on Windows
        },
        follow_current_file = {
          enabled = true, -- neotree를 열어둔 상태에서 다른 파일을 열면 neotree에 그 파일 표시
          leave_dirs_open = true,
        },
        hijack_netrw_behavior = "disabled",
      },
    })

    vim.keymap.set("n", "<leader>n", ":Neotree filesystem reveal left toggle<CR>", { desc = "Toggle Neotree" })
  end,
}
