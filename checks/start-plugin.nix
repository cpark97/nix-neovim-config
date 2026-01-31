{
  callPackage,
  runCommand,
}:
let
  myPlugin = runCommand "myPlugin" { } ''
    mkdir "$out"
    mkdir "$out/lua"
    mkdir "$out/plugin"

    echo "vim.g.myplugin = true" > "$out/lua/myplugin.lua"
    echo "require('myplugin')" > "$out/plugin/myplugin.lua"
  '';
  plugins = [
    myPlugin
  ];

  makeNeovimCheck = callPackage ../make-neovim-check.nix { };
in
makeNeovimCheck {
  name = "checkStartPlugin";

  neovimAttrs = { inherit plugins; };

  luaThenPhase = ''
    assert(vim.g.myplugin == true);
  '';
}
