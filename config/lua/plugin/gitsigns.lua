local function setup()
  if vim.g.vscode then
    return
  end

  vim.cmd.packadd("gitsigns.nvim")

  local gitsigns = require("gitsigns")
  gitsigns.setup({
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    current_line_blame = true,
  })

  local keymaps = {
    -- navigation
    {
      "n",
      "]c",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end,
      "Gitsigns next hunk",
    },
    {
      "n",
      "[c",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end,
      "Gitsigns prev hunk",
    },

    -- actions
    { "n", "<leader>hs", gitsigns.stage_hunk, "Gitsigns stage/unstage hunk" },
    { "n", "<leader>hr", gitsigns.reset_hunk, "Gitsigns reset hunk" },

    {
      "n",
      "<leader>hs",
      function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      "Gitsigns stage/unstage hunk",
    },
    {
      "n",
      "<leader>hr",
      function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      "Gitsigns reset hunk",
    },

    {
      "n",
      "<leader>hS",
      gitsigns.stage_buffer,
      "Gitsigns stage/unstage buffer",
    },
    { "n", "<leader>hR", gitsigns.reset_buffer, "Gitsigns reset buffer" },

    { "n", "<leader>hp", gitsigns.preview_hunk, "Gitsigns preview hunk" },
    {
      "n",
      "<leader>hi",
      gitsigns.preview_hunk_inline,
      "Gitsigns preview hunk inline",
    },

    {
      "n",
      "<leader>hb",
      function()
        gitsigns.blame_line({ full = true })
      end,
      "Gistigns blame line",
    },

    {
      "n",
      "<leader>hd",
      function()
        gitsigns.diffthis("HEAD")
      end,
      "Gitsigns buffer diff with HEAD",
    },
    {
      "n",
      "<leader>hD",
      gitsigns.diffthis,
      "Gitsigns buffer diff with index(staging area)",
    },

    {
      "n",
      "<leader>hq",
      gitsigns.setqflist,
      "Gitsigns buffer hunks in quickfix window",
    },
    {
      "n",
      "<leader>hQ",
      function()
        gitsigns.setqflist("all")
      end,
      "Gitsigns buffer hunks in quickfix window",
    },

    -- toggles
    {
      "n",
      "<leader>htb",
      gitsigns.toggle_current_line_blame,
      "Gitsigns toggle current line blame",
    },
    {
      "n",
      "<leader>htw",
      gitsigns.toggle_word_diff,
      "Gitsigns toggle word diff",
    },

    -- text object
    { { "o", "x" }, "ih", gitsigns.select_hunk, "Gitsigns select hunk" },
  }

  for index, keymap in ipairs(keymaps) do
    local mode = keymap[1]
    local key = keymap[2]
    local fn = keymap[3]
    local desc = keymap[4]

    vim.keymap.set(mode, key, fn, { desc = desc })
  end
end

setup()
