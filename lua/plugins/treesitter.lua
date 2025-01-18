return {
  "nvim-treesitter",
  event = "DeferredUIEnter",
  enabled = not vim.g.vscode,
  after = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      -- ensure_installed = {
      --   "lua",
      --   "luadoc",
      --   "bash",
      --   "diff",
      --   "html",
      --   "javascript",
      --   "typescript",
      --   "tsx",
      --   "json",
      --   "yaml",
      --   "toml",
      --   "make",
      --   "markdown",
      --   "vim",
      --   "vimdoc",
      -- },
      -- auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
