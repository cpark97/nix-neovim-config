vim.keymap.set(
  "n",
  "grd",
  vim.lsp.buf.definition,
  { desc = "LSP: Go to definition" }
)
vim.keymap.set(
  "n",
  "grD",
  vim.lsp.buf.declaration,
  { desc = "LSP: Go to declaration" }
)
vim.keymap.set(
  "n",
  "grc",
  vim.lsp.buf.incoming_calls,
  { desc = "LSP: Show incomming calls in quickfix window" }
)
vim.keymap.set(
  "n",
  "grC",
  vim.lsp.buf.outgoing_calls,
  { desc = "LSP: Show outgoing calls in quickfix window" }
)
vim.keymap.set(
  "n",
  "grT",
  vim.lsp.buf.typehierarchy,
  { desc = "LSP: Show type hierarchy in quickfix window" }
)
vim.keymap.set(
  "n",
  "grO",
  vim.lsp.buf.workspace_symbol,
  { desc = "LSP: Show workspace symbols in quickfix window" }
)
vim.keymap.set("n", "grh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "LSP: LSP: Toggle inlay hint" })
-- TODO: semantic token (0.12)
-- vim.keymap.set("n", "grs", function()
--   vim.lsp.semantic_tokens.enable(not vim.lsp.semantic_tokens.is_enabled())
-- end, { desc = "LSP: LSP: Toggle semantic token" })
-- TODO: vim.lsp.util.rename
-- TODO: lsp-linked_editing_range (0.12)
