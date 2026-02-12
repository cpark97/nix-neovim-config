vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local filetype =
      vim.api.nvim_get_option_value("filetype", { buf = args.buf })
    local lang = vim.treesitter.language.get_lang(filetype)

    if not vim.treesitter.language.add(lang) then
      return
    end

    if not vim.g.vscode then
      -- start syntax highlighting
      vim.treesitter.start(args.buf, lang)

      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo.foldmethod = "expr"
    end

    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
