return {
  {
    "nvim-treesitter",
    event = "DeferredUIEnter",
    after = function()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
          local lang = vim.treesitter.language.get_lang(filetype)

          if vim.treesitter.language.add(lang) then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

            if not vim.g.vscode then
              vim.treesitter.start(args.buf, lang)
              vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
              vim.wo.foldmethod = "expr"
            end
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter-textobjects", -- @see: mini.lua
    event = "DeferredUIEnter",
    beforeAll = function()
      vim.g.no_plugin_maps = true
    end,
    before = function()
      require("lz.n").trigger_load("nvim-treesitter")
    end,
  },
}
