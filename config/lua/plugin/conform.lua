local function setup()
  if vim.g.vscode then
    return
  end

  local formatters_by_ft = {
    lua = { "stylua" },
    nix = { "nixfmt" },
  }

  if type(vim.g.formatters_by_ft) == "table" then
    for k, v in pairs(vim.g.formatters_by_ft) do
      formatters_by_ft[k] = v
    end
  end

  vim.cmd.packadd("conform.nvim")

  require("conform").setup({
    formatters_by_ft = formatters_by_ft,
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      lsp_format = "fallback",
    },
  })

  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

  vim.keymap.set("n", "gQ", function()
    require("conform").format({ lsp_fallback = true })
  end, { desc = "Conform: format document" })
end

setup()
