{
  description = "JavaFX development environment for your project";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        (pkgs.jdk23.override {
          enableJavaFX = true;
        })
        pkgs.maven
      ];
    };
  };
}
