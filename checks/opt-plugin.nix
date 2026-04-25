{
  callPackage,
  runCommand,
}:
let
  # wrapNeovimUnstable 내부에서 plugin derivation의 pname을 사용해서 없으면 에러
  myPlugin = runCommand "myPlugin" { pname = "myPlugin"; } ''
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
