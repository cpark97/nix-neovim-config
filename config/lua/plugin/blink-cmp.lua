local function setup()
  if vim.g.vscode then
    return
  end

  vim.cmd.packadd("friendly-snippets")
  vim.cmd.packadd("luasnip")

  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip").config.setup({})

  vim.cmd.packadd("blink.cmp")

  require("blink.cmp").setup({
    keymap = {
      preset = "default",
    },
    appearance = {
      use_nvim_cmp_as_default = true,
    },
    snippets = {
      preset = "luasnip",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  })
end

setup()
