{
  pkgs,
  lib,
  stdenvNoCC,
  ...
}:
pkgs.stdenvNoCC.mkDerivation rec {
  pname = "antoinecarnec.github.io";
  version = "0.0.1";
  src = ./site;

  buildInputs = with pkgs; [hugo quarto];
  nativeBuildInputs = with pkgs; [coreutils];
  buildPhase = ''
    mkdir .cache
    mkdir .share
    export XDG_CACHE_HOME=.cache
    export XDG_DATA_HOME=.share
    quarto render && hugo
  '';
  installPhase = ''
    mv public $out
  '';
}
