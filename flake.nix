{
  description = "Home Manager configuration of poyehchen";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    decl-cachix.url =
      "github:jonascarpay/declarative-cachix/800c308a85b964eb3447a3cb07e8190fb74dcf59";
    devenv.url = "https://install.devenv.sh/latest";
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, decl-cachix, devenv, ags, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      devenv' = devenv.outputs.packages.${system}.default;
    in {
      formatter.${system} = pkgs.nixfmt;
      homeConfigurations."poyehchen" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [
            ags.homeManagerModules.default
            decl-cachix.homeManagerModules.declarative-cachix
            ./home.nix
            { home.packages = [ devenv' ]; }
          ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
          extraSpecialArgs = { };
        };
    };
}
