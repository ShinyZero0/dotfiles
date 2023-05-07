{
  description = "A very basic .NET flake";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "<name>";
        buildInputs = with pkgs; [ dotnet-sdk_7 clang zlib omnisharp-roslyn ];
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
					PATH=${pkgs.dotnet-sdk_7}/bin:$PATH
					DOTNET_ROOT=${pkgs.dotnet-sdk_7}

					mkdir -p $HOME
          dotnet publish -o ./out/
        '';

        installPhase = ''
          mkdir -p $out/bin
          cp ./out/<name> $out/bin/
        '';
      };
    };
}