{
  inputs = {
    naersk.url = "github:nix-community/naersk/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    fenix,
    nixpkgs,
    utils,
    naersk,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
        rustNightly = fenix.packages.${system}.latest;
        naersk-lib = pkgs.callPackage naersk {
          cargo = rustNightly.toolchain;
          rustc = rustNightly.toolchain;
        };
      in {
        defaultPackage = naersk-lib.buildPackage ./.;
        devShell = with pkgs;
          mkShell {
            buildInputs = [rustNightly.toolchain rustfmt pre-commit rustPackages.clippy];
            RUST_SRC_PATH = rustPlatform.rustLibSrc;
          };
      }
    );
}
