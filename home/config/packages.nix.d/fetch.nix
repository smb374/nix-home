{ stdenv, fetchFromGitHub, ... }:

stdenv.mkDerivation {
  name = "fetch";
  src = fetchFromGitHub {
    owner = "Manas140";
    repo = "fetch";
    rev = "4fc114ed332245b2415ddd007be50e412aaa0cb5";
    hash = "sha256-9yB1ur1yVe0qHsACcofdsGGbf+cZsYTgqnNc/IWS/4A=";
  };
  installPhase = ''
    mkdir -p $out/bin
    cp fetch $out/bin
  '';
}
