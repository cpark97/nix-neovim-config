local function setup()
  vim.cmd.packadd("telescope.nvim")
  vim.cmd.packadd("telescope-ui-select.nvim")

  -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#file-and-text-search-in-hidden-files-and-directories
  local telescope = require("telescope")
  local telescopeConfig = require("telescope.config")

  -- Clone the default Telescope configuration
  local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

  -- I want to search in hidden/dot files.
  table.insert(vimgrep_arguments, "--hidden")
  -- I don't want to search in the `.git` directory.
  table.insert(vimgrep_arguments, "--glob")
  table.insert(vimgrep_arguments, "!**/.git/*")

  telescope.setup({
    defaults = {
      -- `hidden = true` is not supported in text grep commands.
      vimgrep_arguments = vimgrep_arguments,
      -- :h telescope.layout
      layout_strategy = "flex",
    },
    pickers = {
      find_files = {
        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
      },
    },
  })
  telescope.load_extension("ui-select")

  local builtin = require("telescope.builtin")

  local keymaps = {
    -- file pickers
    { "ff", builtin.find_files, "Telescope find files" },
    { "fg", builtin.live_grep, "Telescope live grep" },
    { "fw", builtin.grep_string, "Telescope grep current word" },

    -- vim pickers
    { "fb", builtin.buffers, "Telescope buffers" },
    { "fr", builtin.oldfiles, "Telescope recent files" },
    { "fc", builtin.commands, "Telescope commands" },
    { "ft", builtin.tags, "Telescope tags" },
    { "fC", builtin.command_history, "Telescope command history" },
    { "f/", builtin.search_history, "Telescope search history" },
    { "fh", builtin.help_tags, "Telescope help tags" },
    { "fm", builtin.marks, "Telescope marks" },
    { "fq", builtin.quickfix, "Telescope quickfix list" },
    { "fl", builtin.loclist, "Telescope location list" },
    { "fj", builtin.jumplist, "Telescope jump list" },
    { 'f"', builtin.registers, "Telescope registers" },
    { "fk", builtin.keymaps, "Telescope keymaps" },
    {
      "fz",
      builtin.current_buffer_fuzzy_find,
      "Telescope fuzzy find in current buffer",
    },
    { "fT", builtin.current_buffer_tags, "Telescope current buffer tags" },

    -- lsp pickers
    { "rr", builtin.lsp_references, "Telescope LSP references" },
    { "rc", builtin.lsp_incoming_calls, "Telescope LSP incoming calls" },
    { "rC", builtin.lsp_outgoing_calls, "Telescope LSP outgoing calls" },
    {
      "ro",
      -- symbol filtering
      -- https://github.com/nvim-telescope/telescope.nvim/blob/ad7d9580338354ccc136e5b8f0aa4f880434dcdc/lua/telescope/utils.lua#L116
      -- builtin.lsp_document_symbols({
      --   ignore_symbols = { "variable", ... },
      --   symbols = { "class", ... },
      -- }
      builtin.lsp_document_symbols,
      "Telescope document symbols in current buffer",
    },
    {
      "rO",
      builtin.lsp_workspace_symbols,
      "Telescope document symbols in current buffer",
    },
    {
      "<c-w>d",
      function()
        builtin.diagnostics({ bufnr = 0 })
      end,
      "Telescope diagnostics",
    },
    { "ri", builtin.lsp_implementations, "Telescope lsp implementations" },
    { "rd", builtin.lsp_definitions, "Telescope lsp definitions" },
    { "rt", builtin.lsp_type_definitions, "Telescope lsp type definitions" },

    -- treesitter pickers
    { "ft", builtin.treesitter, "Telescope treesitter symbols" },

    -- lists picker
    { "fp", builtin.builtin, "Telescope builtin pickers" },
  }

  for index, keymap in ipairs(keymaps) do
    local key = keymap[1]
    local fn = keymap[2]
    local desc = keymap[3]
    vim.keymap.set("n", "<leader>" .. key, fn, { desc = desc })
  end
end

if not vim.g.vscode then
  setup()
end
