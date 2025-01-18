# Plugin
```
:Plugin
```
Show plugin configurations list in Telescope.nvim
Useful keymaps
- <C-x> Go to file selection as a split
- <C-v> Go to file selection as a vsplit
- <C-t> Go to a file in a new tab

# Setup Language Servers
```
vim.g.lauguage_servers = {
  nixd = {},
  lua_ls = {},
  svelte = nil,
}
```
Be sure lauguage servers are installed
To disable servers enabled by default, set nil
See default servers `:Plugin` > lsp-config.lua

# Setup formatters
```
vim.g.formatters_by_ft = {
  javascript = { "prettierd", "prettier" },
}
```
Be sure formatters are installed
See default formatters `:Plugin` > conform.lua

