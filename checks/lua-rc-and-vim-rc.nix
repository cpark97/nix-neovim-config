{
  callPackage,
  runCommand,
}:
let
  configDir = runCommand "configDir" { } ''
    mkdir "$out"
    echo "vim.g.myluarc = true" > "$out/init.lua"
    echo "let g:myvimrc = true" > "$out/init.vim"
  '';

  makeNeovimCheck = callPackage ../make-neovim-check.nix { };
in
makeNeovimCheck {
  name = "checkLuaRcAndVimRcCheck";

  neovimAttrs = { inherit configDir; };

  luaThenPhase = ''
    assert(vim.g.myluarc == true and vim.g.myvimrc ~= true);
  '';
}
