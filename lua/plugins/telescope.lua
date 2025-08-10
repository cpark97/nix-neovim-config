return {
  {
    "telescope.nvim",
    enabled = not vim.g.vscode,
    event = "DeferredUIEnter",
    before = function()
      require("lz.n").trigger_load("plenary.nvim")
      require("lz.n").load({ "telescope-ui-select.nvim" })
    end,
    after = function()
      local telescope = require("telescope")
      local telescopeConfig = require("telescope.config")
      local builtin = require("telescope.builtin")

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

      vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>sp", builtin.builtin, { desc = "[S]earch builtin [P]ickers" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader><leader>", builtin.resume, { desc = "Search Resume" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch existing [B]uffers" })
      vim.keymap.set("n", "<leader>sr", builtin.registers, { desc = "[S]earch [R]egisters" })
      vim.keymap.set("n", "<leader>sq", builtin.quickfix, { desc = "[S]earch [Q]uickfix list" })
      vim.keymap.set("n", "<leader>sl", builtin.loclist, { desc = "[S]earch [L]ocation list" })
      vim.keymap.set("n", "<leader>sj", builtin.jumplist, { desc = "[S]earch [J]ump list" })
      vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = "[S]earch [M]arks" })
      vim.keymap.set(
        "n",
        "<leader>/",
        builtin.current_buffer_fuzzy_find,
        { desc = "[/] Fuzzily search in current buffer" }
      )

      vim.keymap.set("n", "<leader>ssp", function()
        builtin.diagnostics({ bufnr = 0 })
      end, { desc = "[S]earch [S]ource document [P]roblems (diagnostics)" })
      vim.keymap.set(
        "n",
        "<leader>ssP",
        builtin.diagnostics,
        { desc = "[S]earch [S]ource workspace [P]roblems (diagnostics)" }
      )
      vim.keymap.set("n", "<leader>ssr", builtin.lsp_references, { desc = "[S]earch [S]ource [R]eferences" })
      vim.keymap.set("n", "<leader>sss", function()
        builtin.lsp_document_symbols({
          symbols = { "Class", "Struct", "Interface", "Function", "Method", "Enum", "Namespace" },
        })
      end, { desc = "[S]earch [S]ource document [S]ymbols" })
      vim.keymap.set("n", "<leader>ssS", function()
        builtin.lsp_workspace_symbols({
          symbols = { "Class", "Struct", "Interface", "Function", "Method", "Enum", "Namespace" },
        })
      end, { desc = "[S]earch [S]ource workspace [S]ymbols" })
      vim.keymap.set("n", "<leader>ssi", builtin.lsp_implementations, { desc = "[S]earch [S]ource [I]mplementations" })
      vim.keymap.set("n", "<leader>ssd", builtin.lsp_definitions, { desc = "[S]earch [S]ource [D]efinitions" })
      vim.keymap.set(
        "n",
        "<leader>sst",
        builtin.lsp_type_definitions,
        { desc = "[S]earch [S]ource [T]ype definitions" }
      )
      vim.keymap.set("n", "<leader>ssc", builtin.lsp_incoming_calls, { desc = "[S]earch [S]ource [I]ncoming calls" })
      vim.keymap.set("n", "<leader>sso", builtin.lsp_outgoing_calls, { desc = "[S]earch [S]ource [O]outgoing calls" })
    end,
  },
}
