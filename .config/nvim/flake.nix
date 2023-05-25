{
  description = "A very basic flake";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

      devShells.${system}.default = pkgs.mkShell {
        name = "<name>";
        buildInputs = with pkgs; [ lua-language-server stylua ];
        shellHook = "";
      };

    };
}
