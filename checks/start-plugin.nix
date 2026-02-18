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
  startPlugins = [
    myPlugin
  ];

  makeNeovimCheck = callPackage ../make-neovim-check.nix { };
in
makeNeovimCheck {
  name = "checkStartPlugin";

  neovimAttrs = { inherit startPlugins; };

  luaThenPhase = ''
    assert(vim.g.myplugin == true);
  '';
}
