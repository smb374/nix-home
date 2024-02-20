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
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "tarball+https://install.devenv.sh/latest";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ags, devenv, disko, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      devenv' = devenv.outputs.packages.${system}.default;
      generalOs = { device ? "/dev/sda", isQemu ? false }:
        nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            disko.nixosModules.disko
            ./os/disko.nix
            { _module.args.device = device; }
            ./os/configuration.nix
            ./os/hardware/general.nix
          ] ++ (if isQemu then [ ./os/hardware/qemu.nix ] else [ ]);
        };
    in {
      packages.${system} = {
        auto-partition = pkgs.writeShellScriptBin "auto-partition"
          (builtins.readFile ./scripts/auto-partition);
      };
      formatter.${system} = pkgs.nixfmt;
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
      nixosConfigurations."nix-general" = generalOs { };
      nixosConfigurations."nix-qemu" = generalOs {
        device = "/dev/vda";
        isQemu = true;
      };
      nixosConfigurations."smb374-nix" =
        generalOs { device = "/dev/nvme0n1"; };
    };
}
