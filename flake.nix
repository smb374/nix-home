{
  description = "Home Manager configuration of poyehchen";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos.url = "github:NixOS/nixpkgs/nixos-23.11";
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
    nix-ld-rs = {
      url = "github:nix-community/nix-ld-rs";
      inputs.nixpkgs.follows = "nixos";
    };
  };

  outputs = { nixpkgs, nixos, home-manager, decl-cachix, devenv, ags, nix-ld-rs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs' = nixos.legacyPackages.${system};
      devenv' = devenv.outputs.packages.${system}.default;
    in {
      programs.${system} = {
        auto-partition =
          pkgs'.writeShellScriptBin "auto-partition" (builtins.readFile ./scripts/auto-partition);
      };
      formatter.${system} = pkgs.nixfmt;
      homeConfigurations."smb374-nix" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ags.homeManagerModules.default
            decl-cachix.homeManagerModules.declarative-cachix
            ./home.nix
            { home.packages = [ devenv' ]; }
          ];
          extraSpecialArgs = { };
        };
      nixosConfigurations."smb374-nix" = nixos.lib.nixosSystem {
        system = system;
        modules = [
          ./os/configuration.nix
          { programs.nix-ld.package = nix-ld-rs.packages.${system}.nix-ld-rs; }
        ];
      };
    };
}
