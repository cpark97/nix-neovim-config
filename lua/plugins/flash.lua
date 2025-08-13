return {
  "flash.nvim",
  event = "DeferredUIEnter",
  after = function()
    require("flash").setup({
      modes = {
        char = {
          -- disable f, F, t, T
          enabled = false,
        },
      },
    })

    vim.keymap.set({ "n", "x", "o" }, "s", function()
      require("flash").jump()
    end, { desc = "Flash" })
    vim.keymap.set({ "n", "x", "o" }, "S", function()
      require("flash").treesitter()
    end, { desc = "Flash Treesitter" })
    vim.keymap.set({ "o" }, "r", function()
      require("flash").remote()
    end, { desc = "Flash Remote" })
    vim.keymap.set({ "x", "o" }, "R", function()
      require("flash").treesitter_search()
    end, { desc = "Flash Treesitter Search" })
    vim.keymap.set({ "c" }, "<C-s>", function()
      require("flash").toggle()
    end, { desc = "Flash Search Toggle" })
  end,
}
