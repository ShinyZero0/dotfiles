{
  description = "A very basic .NET flake";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      dotnetPkgs = with pkgs;
        (with dotnetCorePackages; combinePackages [ sdk_7_0 sdk_6_0 ]);
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "<name>";
        buildInputs = with pkgs; [ dotnetPkgs omnisharp-roslyn ];
        shellHook = ''
          export DOTNET_ROOT=${dotnetPkgs}
        '';
      };
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "<name>";
        version = "<version>";
        src = pkgs.fetchFromGitHub {
          owner = "<username>";
          repo = "<name>";
          rev = "master";
          sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        };
        nativeBuildInputs = with pkgs; [ dotnetPkgs ];
        buildInputs = with pkgs; [ ];
        buildPhase = ''
          					HOME=$PWD/home
          					PATH=${dotnetPkgs}/bin:$PATH
          					DOTNET_ROOT=${dotnetPkgs}

          					mkdir -p $HOME
                    dotnet publish -c Release -o ./out/
        '';

        installPhase = ''
          mkdir -p $out/bin
          cp ./out/<name> $out/bin/
        '';
      };
    };
}
