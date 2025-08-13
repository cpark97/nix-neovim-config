return {
  "conform.nvim",
  enabled = not vim.g.vscode,
  event = "DeferredUIEnter",
  after = function()
    local formatters_by_ft = {
      lua = { "stylua" },
      nix = { "nixfmt" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      svelte = { "prettier" },
    }

    if type(vim.g.formatters_by_ft) == "table" then
      for k, v in pairs(vim.g.formatters_by_ft) do
        formatters_by_ft[k] = v
      end
    end

    require("conform").setup({
      formatters_by_ft = formatters_by_ft,
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = {
        lsp_format = "fallback",
      },
    })

    -- gq 등으로 포매팅 할 때 적용
    -- https://neovim.io/doc/user/change.html#gq
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    vim.keymap.set("n", "<leader>f", function()
      require("conform").format({ lsp_fallback = true })
    end, { desc = "Format Document" })
  end,
}
