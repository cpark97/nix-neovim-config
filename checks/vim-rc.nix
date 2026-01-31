{
  callPackage,
  writeTextDir,
}:
let
  configDir = writeTextDir "init.vim" ''
    let g:myvimrc = 1
  '';

  makeNeovimCheck = callPackage ../make-neovim-check.nix { };
in
makeNeovimCheck {
  name = "checkVimRc";

  neovimAttrs = { inherit configDir; };

  luaThenPhase = ''
    assert(vim.g.myvimrc == 1);
  '';
}
