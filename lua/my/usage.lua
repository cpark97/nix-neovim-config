local usage_file = vim.fs.joinpath(require("nixCats").configDir, "USAGE.md")

local function show_usage(cmd)
  require("my.open").open(usage_file, { cmd = cmd, nomodifiable = true })
end

vim.api.nvim_create_user_command("Usage", function(opts)
  if opts.fargs[1] == "v" then
    show_usage("vsplit")
  else
    show_usage("split")
  end
end, {
  nargs = "?",
  complete = function(ArgLead, CmdLine, CursorPos)
    return { "h", "v" }
  end,
})
