{
  description = "A very basic Zig flake";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "<name>";
        buildInputs = with pkgs; [ clang zlib zig ];
      };
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "<name>";
        version = "<version>";
        # unpackPhase = ":";
        src = pkgs.fetchFromGitHub {
          owner = "ShinyZero0";
          repo = "<name>";
          rev = "<version>";
          sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        };
        nativeBuildInputs = with pkgs; [ zlib ];
        buildInputs = with pkgs; [ icu ];
        buildPhase = ''
          					HOME=$PWD/home
          					PATH=${pkgs.zig}/bin:$PATH

          					mkdir -p $HOME
                    zig build
        '';

        installPhase = ''
          mkdir -p $out/bin
          cp ./zig-out/bin/* $out/bin/
        '';
      };
    };
}
