{
  callPackage,
  writeTextDir,
  writeShellScriptBin,
}:
let
  myDep = writeShellScriptBin "myDep" ''
    echo -n myDep
  '';

  configDir = writeTextDir "init.lua" ''
    vim.g.myluarc = vim.fn.system("myDep");
  '';

  makeNeovimCheck = callPackage ../make-neovim-check.nix { };
in
makeNeovimCheck {
  name = "checkRuntimeDeps";

  neovimAttrs = {
    inherit configDir;
    runtimeDeps = [ myDep ];
  };

  luaThenPhase = ''
    assert(vim.g.myluarc == "myDep");
  '';
}
