{
  outputs = { self, nixpkgs, flake-utils }: {
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
  } // flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      exampleShells = import ./shell/example.nix { inherit pkgs; };
    in
    {
      devShells = {
        inherit (exampleShells) example javascript python go rust multi;
      };
    });
}
