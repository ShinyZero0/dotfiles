{
  description = "Home Manager configuration of ShinyZero0";
  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs = {

      url = "github:nixos/nixpkgs/nixos-unstable";
      # config = { permittedInsecurePackages = [ "openssl-1.1.1t" ]; };
    };
    home-manager = {

      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nuScripts = {

      url = "github:nushell/nu_scripts";
      flake = false;
    };
    nuTreeSitter = {

      url = "github:nushell/tree-sitter-nu";
      flake = false;
    };
    jsonfmt = { url = "github:shinyzero0/jsonfmt"; };
    sentsplit = { url = "github:shinyzero0/sentsplit.cs"; };
    descfmt = { url = "github:shinyzero0/descfmt"; };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.zero = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          inherit inputs;
          inherit system;
        };

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
