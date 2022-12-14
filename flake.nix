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
        go = {
          path = ./go;
          description = "Go starter template for Zero to Nix";
        };

        javascript = {
          path = ./javascript;
          description = "JavaScript starter template for Zero to Nix";
        };

        python = {
          path = ./python;
          description = "Python starter template for Zero to Nix";
        };

        rust = {
          path = ./rust;
          description = "Rust starter template for Zero to Nix";
        };
      };
    };
}
