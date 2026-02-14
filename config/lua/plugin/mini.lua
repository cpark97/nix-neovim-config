local function setup()
  -- depends on nvim-treesitter-textobjects
  local spec_treesitter = require("mini.ai").gen_spec.treesitter
  require("mini.ai").setup({
    n_lines = 1000,
    mappings = {
      around_last = "ap",
      inside_last = "ip",
    },
    custom_textobjects = {
      f = spec_treesitter({
        a = "@call.outer",
        i = "@call.inner",
      }),
      F = spec_treesitter({
        a = "@function.outer",
        i = "@function.inner",
      }),
      c = spec_treesitter({
        a = "@class.outer",
        i = "@class.inner",
      }),
      P = spec_treesitter({
        a = "@parameter.outer",
        i = "@parameter.inner",
      }),
      b = spec_treesitter({
        a = "@block.outer",
        i = "@block.inner",
      }),
      C = spec_treesitter({
        a = "@comment.outer",
        i = "@comment.inner",
      }),
    },
  })

  require("mini.surround").setup({
    mappings = {
      suffix_last = "p",
    },
    n_lines = 1000,
  })

  require("mini.splitjoin").setup({})
  require("mini.align").setup({})

  if not vim.g.vscode then
    require("mini.cursorword").setup()
    require("mini.trailspace").setup()
  end
end

setup()
