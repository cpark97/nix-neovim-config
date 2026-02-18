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
  optionalPlugins = [
    myPlugin
  ];

  makeNeovimCheck = callPackage ../make-neovim-check.nix { };
in
makeNeovimCheck {
  name = "checkOptPlugin";

  neovimAttrs = { inherit optionalPlugins; };

  luaThenPhase = ''
    assert(vim.g.myplugin ~= true);

    vim.cmd.packadd("myPlugin");

    assert(vim.g.myplugin == true);
  '';
}
