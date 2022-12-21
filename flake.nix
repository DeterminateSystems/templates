{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }:
    let
      nameValuePair = name: value: { inherit name value; };
      genAttrs = names: f: builtins.listToAttrs (map (n: nameValuePair n (f n)) names);
      allSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: genAttrs allSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forAllSystems ({ pkgs }:
        let
          exampleShells = import ./shell/example.nix { inherit pkgs; };
        in
        {
          inherit (exampleShells) example javascript python go rust multi;
        });
      templates = {
        go-dev = {
          path = ./templates/dev/go;
          description = "Go dev environment template for Zero to Nix";
        };

        javascript-dev = {
          path = ./templates/dev/javascript;
          description = "JavaScript dev environment template for Zero to Nix";
        };

        python-dev = {
          path = ./templates/dev/python;
          description = "Python dev environment template for Zero to Nix";
        };

        rust-dev = {
          path = ./templates/dev/rust;
          description = "Rust dev environment template for Zero to Nix";
        };

        go-pkg = {
          path = ./templates/pkg/go;
          description = "Go package starter template for Zero to Nix";
        };

        javascript-pkg = {
          path = ./templates/pkg/javascript;
          description = "JavaScript package starter template for Zero to Nix";
        };

        python-pkg = {
          path = ./templates/pkg/python;
          description = "Python package starter template for Zero to Nix";
        };

        rust-pkg = {
          path = ./rust-pkg;
          description = "Rust package starter template for Zero to Nix";
        };
      };
    };
}
