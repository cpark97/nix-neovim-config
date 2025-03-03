local function nvim_lspconfig_config()
  local lspconfig = require("lspconfig")
  local blink = require("blink.cmp")

  local servers = {
    nixd = {},
    lua_ls = {},
    svelte = {},
  }

  if type(vim.g.language_servers) == "table" then
    for k, v in vim.g.language_servers do
      servers[k] = v
    end
  end

  for server, config in pairs(servers) do
    config.capabilities = blink.get_lsp_capabilities(config.capabilities)
    lspconfig[server].setup(config)
  end

  -- Brief aside: **What is LSP?**
  --
  -- LSP is an initialism you've probably heard, but might not understand what it is.
  --
  -- LSP stands for Language Server Protocol. It's a protocol that helps editors
  -- and language tooling communicate in a standardized fashion.
  --
  -- In general, you have a "server" which is some tool built to understand a particular
  -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
  -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
  -- processes that communicate with some "client" - in this case, Neovim!
  --
  -- LSP provides Neovim with features like:
  --  - Go to definition
  --  - Find references
  --  - Autocompletion
  --  - Symbol Search
  --  - and more!
  --
  -- Thus, Language Servers are external tools that must be installed separately from
  -- Neovim. This is where `mason` and related plugins come into play.
  --
  -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
  -- and elegantly composed help section, `:help lsp-vs-treesitter`

  --  This function gets run when an LSP attaches to a particular buffer.
  --    That is to say, every time a new file is opened that is associated with
  --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
  --    function will be executed to configure the current buffer
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
      -- NOTE: Remember that Lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
      end

      -- Jump to the definition of the word under your cursor.
      --  This is where a variable was first declared, or where a function is defined, etc.
      --  To jump back, press <C-t>.
      map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

      -- Find references for the word under your cursor.
      map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

      -- Jump to the implementation of the word under your cursor.
      --  Useful when your language has ways of declaring types without an actual implementation.
      map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

      -- Jump to the type of the word under your cursor.
      --  Useful when you're not sure what type a variable is and you want to see
      --  the definition of its *type*, not where it was *defined*.
      map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

      -- Fuzzy find all the symbols in your current document.
      --  Symbols are things like variables, functions, types, etc.
      map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

      -- Fuzzy find all the symbols in your current workspace.
      --  Similar to document symbols, except searches over your entire project.
      map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

      -- Rename the variable under your cursor.
      --  Most Language Servers support renaming across files, etc.
      map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

      -- Opens a popup that displays documentation about the word under your cursor
      --  See `:help K` for why this keymap.
      map("K", vim.lsp.buf.hover, "Hover Documentation")

      -- WARN: This is not Goto Definition, this is Goto Declaration.
      --  For example, in C this would take you to the header.
      map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

      map("<leader>se", vim.diagnostic.open_float, "[S]how [E]rrors")

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client.server_capabilities.documentHighlightProvider then
        local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd("LspDetach", {
          group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
          end,
        })
      end

      -- The following autocommand is used to enable inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
        map("<leader>th", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, "[T]oggle Inlay [H]ints")
      end
    end,
  })
end

return {
  {
    "nvim-lspconfig",
    enabled = not vim.g.vscode,
    event = "DeferredUIEnter",
    before = function()
      -- Useful status updates for LSP.
      require("lz.n").load({
        "fidget.nvim",
        enabled = not vim.g.vscode,
        after = function()
          require("fidget").setup({})
        end,
      })
      require("lz.n").trigger_load({ "blink.cmp" })
    end,
    after = nvim_lspconfig_config,
  },

  {
    "typescript-tools.nvim",
    enabled = not vim.g.vscode,
    event = "DeferredUIEnter",
    before = function()
      require("lz.n").trigger_load({ "plenary.nvim", "nvim-lspconfig" })
    end,
    after = function()
      require("typescript-tools").setup({})
    end,
  },

  {
    "blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    enabled = not vim.g.vscode,
    before = function()
      require("lz.n").load({
        {
          -- Snippet Engine
          "luasnip",
          before = function()
            require("lz.n").load({ "friendly-snippets" })
          end,
          after = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip").config.setup({})
          end,
        },
      })
    end,
    after = function()
      local blink = require("blink.cmp")
      blink.setup({
        keymap = {
          preset = "default",
          ["<tab>"] = {},
          ["<s-tab>"] = {},
          ["<c-l>"] = { "snippet_forward", "fallback" },
          ["<c-h>"] = { "snippet_backward", "fallback" },
        },
        appearance = {
          use_nvim_cmp_as_default = true,
        },
        snippets = {
          preset = "luasnip",
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },
        completion = {
          menu = {
            draw = {
              components = {
                label_description = {
                  text = function(ctx)
                    if ctx.label_description and ctx.label_description ~= "" then
                      return ctx.label_description
                    elseif
                      ctx.item.data
                      and ctx.item.data.entryNames
                      and ctx.item.data.entryNames[1]
                      and ctx.item.data.entryNames[1].source
                    then
                      return ctx.item.data.entryNames[1].source
                    end
                  end,
                },
              },
            },
          },
        },
      })
    end,
  },
}
