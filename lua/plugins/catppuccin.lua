  return {
    "catppuccin-nvim",
    enabled = not vim.g.vscode,
    -- colorscheme = {"catppuccin", "catppuccin-mocha", "catppuccin-latte", "catppuccin-frappe", "catppuccin-macchiato"},
    after = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end
  }

