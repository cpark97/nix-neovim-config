{
  description = "neovim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      allSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      makeAllSystems =
        f:
        nixpkgs.lib.genAttrs allSystems (
          system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          f { inherit system pkgs; }
        );
    in
    rec {
      packages = makeAllSystems (
        { pkgs, ... }:
        {
          default = pkgs.callPackage ./neovim.nix {
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
            ];
            runtimeDeps = with pkgs; [
              # language servers
              lua-language-server
              nixd

              # formatters
              stylua
              nixfmt

              ripgrep
            ];
          };
        }
      );
      devShells = makeAllSystems (
        { system, ... }:
        {
          default = packages.${system}.default.overrideAttrs (prevAttrs: {
            shellHook = ''
              source $stdenv/setup
            '';
          });
        }
        // checks.${system}
      );
      checks = makeAllSystems (
        { pkgs, ... }:
        let
          inherit (nixpkgs) lib;
          isNixFile = filename: lib.strings.hasSuffix ".nix" filename;
          allCheckFiles = lib.filter isNixFile (lib.filesystem.listFilesRecursive ./checks);
        in
        builtins.foldl' (
          checks: checkFile:
          let
            check = pkgs.callPackage checkFile { };
          in
          assert !checks ? "${check.name}";
          checks // { "${check.name}" = check; }
        ) { } allCheckFiles
      );
    };
}
