{
  callPackage,
  writeTextDir,
}:
let
  configDir = writeTextDir "init.lua" ''
    vim.g.myluarc = true
  '';

  makeNeovimCheck = callPackage ../make-neovim-check.nix { };
in
makeNeovimCheck {
  name = "checkLuaRc";

  neovimAttrs = { inherit configDir; };

  luaThenPhase = ''
    assert(vim.g.myluarc == true);
  '';
}
