return {
  {
    "nvim-treesitter",
    event = "DeferredUIEnter",
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
        highlight = { enable = not vim.g.vscode },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            scope_incremental = "<CR>",
            node_incremental = "<TAB>",
            node_decremental = "<S-TAB>",
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter-textobjects",
    event = "DeferredUIEnter",
    before = function()
      require("lz.n").trigger_load("nvim-treesitter")
    end,
  },
}
