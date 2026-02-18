{ pkgs, ... }:
pkgs.callPackage ./neovim.nix {
  configDir = ./config;
  startPlugins = with pkgs.vimPlugins; [
    nvim-treesitter.withAllGrammars
    nvim-treesitter-textobjects
    nvim-lspconfig
    mini-nvim
    snacks-nvim
  ];
  optionalPlugins = with pkgs.vimPlugins; [
    fidget-nvim
    telescope-nvim
    telescope-ui-select-nvim
    conform-nvim
    oil-nvim
    blink-cmp
    luasnip
    friendly-snippets
    neo-tree-nvim
    gitsigns-nvim
    trouble-nvim
    which-key-nvim
    todo-comments-nvim
    monokai-pro-nvim
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
