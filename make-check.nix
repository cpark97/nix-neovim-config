{ stdenvNoCC, writeText }:
{
  name,
  givenPhase ? "true",
  whenPhase ? "true",
  thenPhase ? "true",
  ...
}@attrs:
let
  setup = writeText "setup" ''
    givenPhase() {
      ${givenPhase}
    }

    whenPhase() {
      ${whenPhase}
    }

    thenPhase() {
      ${thenPhase}
    }

    check() {
      givenPhase && whenPhase && thenPhase
    }
  '';

  check = writeText "check" ''
    source "$setup";
    check
  '';

  rest = removeAttrs attrs [
    "name"
    "givenPhase"
    "whenPhase"
    "thenPhase"
  ];
in
stdenvNoCC.mkDerivation (
  {
    inherit name setup check;
    buildCommandPath = check;
    shellHook = ''
      source $setup
    '';
  }
  // rest
)
