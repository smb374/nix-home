{
  description = "Home Manager configuration of poyehchen";

  nixConfig = {
    extra-substituters =
      [ "https://nix-community.cachix.org" "https://devenv.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "tarball+https://install.devenv.sh/latest";
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld-rs = {
      url = "github:nix-community/nix-ld-rs";
      inputs.nixpkgs.follows = "nixos";
    };
  };

  outputs = { nixpkgs, nixos, home-manager, devenv, ags, nix-ld-rs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs' = nixos.legacyPackages.${system};
      devenv' = devenv.outputs.packages.${system}.default;
    in {
      packages.${system} = {
        auto-partition = pkgs'.writeShellScriptBin "auto-partition"
          (builtins.readFile ./scripts/auto-partition);
      };
      formatter.${system} = pkgs.nixfmt;
      homeConfigurations."smb374-nix" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ags.homeManagerModules.default
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
