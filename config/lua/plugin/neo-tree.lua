local function setup()
  if vim.g.vscode then
    return
  end

  vim.cmd.packadd("neo-tree.nvim")

  require("neo-tree").setup({
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    window = {
      width = 30,
    },
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

  vim.keymap.set(
    "n",
    "<leader>ne",
    ":Neotree filesystem reveal left toggle<CR>",
    { desc = "Toggle Neotree explorer" }
  )
  vim.keymap.set(
    "n",
    "<leader>ng",
    ":Neotree git_status reveal left toggle<CR>",
    { desc = "Toggle Neotree git status" }
  )
  vim.keymap.set(
    "n",
    "<leader>nb",
    ":Neotree buffers reveal left toggle<CR>",
    { desc = "Toggle Neotree buffers" }
  )
end

setup()
