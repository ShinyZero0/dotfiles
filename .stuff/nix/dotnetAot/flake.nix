{
  description = "A very basic .NET flake";
  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      dotnetPkgs = with pkgs;
        (with dotnetCorePackages; combinePackages [ sdk_7_0 ]);
      deps = with pkgs; [ clang zlib zlib.dev icu pkg-config ];
    in {
      apps.${system}.fetch-deps = {
        type = "app";
        program = "${self.packages.${system}.default.passthru.fetch-deps}";
      };

      packages.${system}.default = with pkgs;
        buildDotnetModule {
          pname = "<name>";
          version = "0.0.1";
          src = fetchFromGitHub {
            owner = "<username>";
            repo = "<name>";
            rev = "master";
            sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
          };
          # nugetDeps = ./deps.nix;
          dotnet-sdk = dotnetCorePackages.sdk_7_0;
          dotnet-runtime = dotnetCorePackages.runtime_7_0;
          buildInputs = deps;
          nativeBuildInputs = [ ] ++ deps;
          selfContainedBuild = true;

          DOTNET_ROOT = "${dotnetPkgs}";
          LOCALE_ARCHIVE = "${glibcLocales}/lib/locale/locale-archive";
          NIX_LD_LIBRARY_PATH = lib.makeLibraryPath ([ stdenv.cc.cc ] ++ deps);
          NIX_LD = "${stdenv.cc.libc_bin}/bin/ld.so";
        };
    };
}
