vim.api.nvim_create_user_command("Plugin", function(opts)
  local plugins_dir_path = vim.fs.joinpath(require("nixCats").configDir, "lua", "plugins")

  require("telescope.builtin").find_files({
    cwd = plugins_dir_path,
  })
end, {
  nargs = 0,
})
