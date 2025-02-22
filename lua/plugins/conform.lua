return {
  "conform.nvim",
  enabled = not vim.g.vscode,
  event = "DeferredUIEnter",
  after = function()
    local formatters_by_ft = {
      lua = { "stylua" },
      nix = { "nixfmt" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      svelte = { "prettier" },
    }

    if type(vim.g.formatters_by_ft) == "table" then
      for k, v in pairs(vim.g.formatters_by_ft) do
        formatters_by_ft[k] = v
      end
    end

    require("conform").setup({
      formatters_by_ft = formatters_by_ft,
      format_on_save = {
        lsp_format = "fallback",
      },
    })
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    vim.keymap.set("n", "<leader>f", function()
      require("conform").format({ lsp_fallback = true })
    end, { desc = "Format Document" })
  end,
}
