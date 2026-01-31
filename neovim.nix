{
  wrapNeovimUnstable,
  neovim-unwrapped,
  writeText,
  runCommand,
  makeWrapper,
  lib,
  configDir ? null,
  plugins ? [ ],
}:
let
  wrappedNeovim = wrapNeovimUnstable neovim-unwrapped {
    inherit plugins;
  };
  wrappedNeovimLuaRcFile =
    let
      name = "wrappedNeovimInit.lua";
      text = wrappedNeovim.luaRcContent;
    in
    writeText name text;
in
runCommand "nvim"
  {
    inherit wrappedNeovim configDir;
    nativeBuildInputs = [ makeWrapper ];
  }
  (
    ''
      mkdir $out

      echo "dofile('${wrappedNeovimLuaRcFile}')" > $out/init.lua

      if [ -z "$configDir" ]; then
        mkdir "$out/config"
        export configDir="$out/config"
      fi

      if [ -f "$configDir/init.lua" ]; then
        echo "dofile('$configDir/init.lua')" >> $out/init.lua
      elif [ -f "$configDir/init.vim" ]; then
        echo "vim.cmd.source('$configDir/init.vim')" >> $out/init.lua
      fi
    ''
    + ''
      makeWrapper "$wrappedNeovim/bin/nvim" "$out/bin/nvim" \
        --set-default VIMINIT "lua dofile(\"$out/init.lua\")" \
        --append-flags "--cmd \"
          lua
          vim.opt.runtimepath:prepend('$configDir')
          vim.opt.packpath:prepend('$configDir')
        \""
    ''
  )
