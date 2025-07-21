{
  description = "A collection of flake templates";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    templates = {
      inherit
        (nixpkgs.templates)
        trivial
        simplaContainer
        typescript-pnpm
        full
        bash-hello
        empty
        hercules-ci
        dotnet
        rust-web-server
        go-hello
        typescript-p5js
        haskell-nix
        haskell-hello
        haskell-flake
        compat
        utils-generic
        ruby
        c-hello
        python
        ;

      uv = {
        path = ./uv;
        description = "A NixOS container running apache-httpd";
      };

      rust = {
        path = ./rust;
        description = "Rust template, using Naersk";
      };

      rust-nightly = {
        path = ./rust-nigthly;
        description = "Rust template, using Naersk nigthly";
      };

      java = {
        path = ./javafx23;
        description = "Java template, using java23 and javafx";
      };
    };

    defaultTemplate = self.templates.trivial;
  };
}
