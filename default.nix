{
  pkgs,
  lib,
  stdenv,
  ...
}:
pkgs.stdenv.mkDerivation rec {
  pname = "antoinecarnec.github.io";
  version = "0.0.1";
  src = ./site;
  # nativeBuildInputs = [
  #   pkgs.breakpointHook
  # ];
  buildInputs = [pkgs.hugo pkgs.quarto pkgs.busybox];
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
