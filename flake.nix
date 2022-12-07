{
  outputs = { self, nixpkgs, flake-utils }: {
    templates = {
      go = {
        path = ./templates/go;
        description = "Go starter template for Zero to Nix";
      };

      javascript = {
        path = ./templates/javascript;
        description = "JavaScript starter template for Zero to Nix";
      };

      python = {
        path = ./templates/python;
        description = "Python starter template for Zero to Nix";
      };

      rust = {
        path = ./templates/rust;
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
