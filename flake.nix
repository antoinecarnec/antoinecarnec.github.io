{
  description = "A very basic flake";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    quarto = pkgs.callPackage ./quarto/quarto.nix {};
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        (
          _: _: {
            quarto = quarto.override {
              pythonExtraPackages = [
                "numpy"
                "matplotlib"
                "pandas"
                "scipy"
              ];
            };
          }
        )
      ];
    };
    lib = pkgs.lib;
  in {
    packages.x86_64-linux.default = pkgs.callPackage ./default.nix {};

    devShells.x86_64-linux.default = pkgs.mkShellNoCC {
      buildInputs = with pkgs; [
        hugo
        quarto
      ];
    };
  };
}
