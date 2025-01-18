local M = {}

---@class my.OpenOpts
---@field cmd? "edit" | "split" | "vsplit"
---@field nomodifiable? boolean
---@field readonly? boolean

---open file in new buffer or new window
---@param filename string
---@param opts my.OpenOpts
M.open = function(filename, opts)
  local cmd = opts.cmd or "edit"
  vim.cmd({ cmd = cmd, args = { filename } })

  if opts.nomodifiable == true then
    vim.cmd("setlocal nomodifiable")
    vim.cmd("setlocal readonly")
  end

  if opts.readonly == true then
    vim.cmd("setlocal readonly")
  end
end

return M
