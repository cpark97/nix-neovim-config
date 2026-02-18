{ pkgs, ... }:
pkgs.callPackage ./neovim.nix {
  configDir = ./config;
  plugins = with pkgs.vimPlugins; [
    nvim-treesitter.withAllGrammars
    nvim-treesitter-textobjects
    nvim-lspconfig
    {
      plugin = fidget-nvim;
      optional = true;
    }
    {
      plugin = telescope-nvim;
      optional = true;
    }
    {
      plugin = telescope-ui-select-nvim;
      optional = true;
    }
    {
      plugin = conform-nvim;
      optional = true;
    }
    {
      plugin = oil-nvim;
      optional = true;
    }
    {
      plugin = blink-cmp;
      optional = true;
    }
    {
      plugin = luasnip;
      optional = true;
    }
    {
      plugin = friendly-snippets;
      optional = true;
    }
    mini-nvim
    snacks-nvim
    {
      plugin = neo-tree-nvim;
      optional = true;
    }
    {
      plugin = gitsigns-nvim;
      optional = true;
    }
    {
      plugin = trouble-nvim;
      optional = true;
    }
    {
      plugin = which-key-nvim;
      optional = true;
    }
    {
      plugin = todo-comments-nvim;
      optional = true;
    }
    {
      plugin = monokai-pro-nvim;
      optional = true;
    }
  ];
  runtimeDeps = with pkgs; [
    # language servers
    lua-language-server
    nixd
    typescript-language-server
    svelte-language-server

    # formatters
    stylua
    nixfmt
    prettier

    ripgrep
  ];
}
