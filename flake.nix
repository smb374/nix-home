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
    # Nixpkgs, Home-Manager, and flake-parts.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    # Other inputs
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "tarball+https://install.devenv.sh/latest";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs, home-manager, flake-parts, ags, devenv, disko, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems =
        [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        formatter = pkgs.nixpkgs-fmt;
      };
      flake =
        let
          system = "x86_64-linux";
          pkgs = nixpkgs.legacyPackages.${system};
          devenv' = devenv.outputs.packages.${system}.default;
          myLib = import ./lib {
            inherit (nixpkgs) lib;
            inherit disko;
          };
        in
        {
          diskoConfigurations = myLib.genDiskoConfigs [ "sda" "vda" "nvme0n1" ];
          homeConfigurations."poyehchen" =
            home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [
                ags.homeManagerModules.default
                ./home.nix
                { home.packages = [ devenv' ]; }
              ];
              extraSpecialArgs = { };
            };
          homeConfigurations."test" =
            home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [
                ags.homeManagerModules.default
                ./home-test.nix
                { home.packages = [ devenv' ]; }
              ];
              extraSpecialArgs = { inherit inputs; };
            };
          nixosConfigurations."nix-general" = myLib.generalOs {
            extraModules = [ ./os/modules/greetd-hyprland.nix ];
          };
          nixosConfigurations."nix-qemu" = myLib.generalOs {
            device = "/dev/vda";
            isQemu = true;
            bootLoader = "systemd";
          };
          nixosConfigurations."smb374-nix" = myLib.generalOs {
            device = "/dev/nvme0n1";
            extraModules = [ ./os/modules/greetd-hyprland.nix ];
            bootLoader = "systemd";
          };
        };
    };
}
