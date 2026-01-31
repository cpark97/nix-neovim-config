{
  callPackage,
  writeText,
}:
{
  name,
  neovimAttrs ? { },
  givenPhase ? "",
  whenPhase ? "true",
  luaThenPhase ? "",
  ...
}@attrs:
let
  makeCheck = callPackage ./make-check.nix { };
  neovim = callPackage ./neovim.nix neovimAttrs;
  rest = removeAttrs attrs [
    "name"
    "neovimAttrs"
    "givenPhase"
    "whenPhase"
    "luaThenPhase"
  ];
in
makeCheck (
  {
    inherit
      name
      whenPhase
      neovim
      ;

    luaThenPhase = writeText "thenPhase.lua" ''
      assert(vim.v.errmsg == "", "initialization error");

      ${luaThenPhase}

      vim.cmd("q")
    '';

    nativeBuildInputs = [ neovim ];

    givenPhase = ''
      mkdir -p "$out/home"
      export HOME="$out/home"
      export XDG_CONFIG_HOME="$HOME/.config"
      export XDG_CONFIG_DIRS="$XDG_CONFIG_HOME"
      export XDG_DATA_HOME="$HOME/.local/share"
      export XDG_DATA_DIRS="$XDG_DATA_HOME"
      export XDG_STATE_HOME="$HOME/.local/state"
      export XDG_CACHE_HOME="$HOME/.cache"

      ${givenPhase}
    '';

    thenPhase = ''
      nvim \
        --headless \
        -c "lua dofile('$luaThenPhase')" \
        -c "cq"

      touch "$out"
    '';
  }
  // rest
)
