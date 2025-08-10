return { -- Collection of various small independent plugins/modules
  "mini.nvim",
  event = "DeferredUIEnter",
  after = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    local spec_treesitter = require("mini.ai").gen_spec.treesitter
    require("mini.ai").setup({
      n_lines = 500,

      mappings = {
        around_last = "ap",
        inside_last = "ip",
      },

      custom_textobjects = {
        f = spec_treesitter({
          a = "@function.outer",
          i = "@function.inner",
        }),
        c = spec_treesitter({
          a = "@class.outer",
          i = "@class.inner",
        }),
        a = spec_treesitter({
          a = "@parameter.outer",
          i = "@parameter.inner",
        }),
        b = spec_treesitter({
          a = "@block.outer",
          i = "@block.inner",
        }),
        b = spec_treesitter({
          a = "@block.outer",
          i = "@block.inner",
        }),
        ["*"] = spec_treesitter({
          a = "@comment.outer",
          i = "@comment.inner",
        }),
      },
    })

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- keymaps: https://github.com/ggandor/leap.nvim/discussions/59#discussioncomment-3842315
    -- - gsaiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - gsd'   - [S]urround [D]elete [']quotes
    -- - gsr)'  - [S]urround [R]eplace [)] [']
    require("mini.surround").setup({
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        add = "gza",            -- Add surrounding in Normal and Visual modes
        delete = "gzd",         -- Delete surrounding
        find = "gzf",           -- Find surrounding (to the right)
        find_left = "gzF",      -- Find surrounding (to the left)
        highlight = "gzh",      -- Highlight surrounding
        replace = "gzr",        -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`

        suffix_last = "l",      -- Suffix to search with "prev" method
        suffix_next = "n",      -- Suffix to search with "next" method
      },
    })

    require("mini.splitjoin").setup({})
    require("mini.align").setup({})

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    -- local statusline = require("mini.statusline")
    -- set use_icons to true if you have a Nerd Font
    -- statusline.setup({ use_icons = vim.g.have_nerd_font })

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    -- ---@diagnostic disable-next-line: duplicate-set-field
    -- statusline.section_location = function()
    --   return "%2l:%-2v"
    -- end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim

    if not vim.g.vscode then
      require("mini.cursorword").setup()
      require("mini.trailspace").setup()
    end
  end,
}
