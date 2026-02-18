require("plugin.lsp.keymap")
require("plugin.lsp.fidget")

local servers = {
  "nixd",
  "lua_ls",
  "ts_ls",
  "svelte",
}

local setup_functions = {}

if not vim.g.vscode then
  for index, server in ipairs(servers) do
    vim.lsp.enable(server)
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my-lsp-attach", { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if client:supports_method("textDocument/foldingRange") then
        vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
        vim.wo.foldmethod = "expr"
      end

      setup_functions.document_highlight()
    end,
  })
end

function setup_functions.document_highlight(buf)
  local highlight_augroup =
    vim.api.nvim_create_augroup("my-lsp-highlight", { clear = true })

  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    buffer = buf,
    group = highlight_augroup,
    callback = vim.lsp.buf.document_highlight,
  })

  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    buffer = buf,
    group = highlight_augroup,
    callback = vim.lsp.buf.clear_references,
  })

  vim.api.nvim_create_autocmd("LspDetach", {
    group = highlight_augroup,
    callback = function(args)
      vim.lsp.buf.clear_references()
      vim.api.nvim_clear_autocmds({
        group = highlight_augroup,
        buffer = args.buf,
      })
    end,
  })
end
