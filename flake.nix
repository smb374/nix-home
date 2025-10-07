{
  description = "Home Manager configuration of poyehchen";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://devenv.cachix.org"
    ];
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
    poetry2nix.url = "github:nix-community/poetry2nix";
    # Other inputs
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astal = {
      url = "github:Aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    devenv.url = "tarball+https://install.devenv.sh/latest";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up to date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      flake-parts,
      ags,
      astal,
      catppuccin,
      devenv,
      disko,
      rust-overlay,
      zen-browser,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          formatter = pkgs.nixfmt;
          legacyPackages.homeConfigurations."poyehchen" = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
              inherit system;
              overlays = [
                rust-overlay.overlays.default
              ];
            };
            modules = [
              ags.homeManagerModules.default
              catppuccin.homeModules.catppuccin
              ./home.nix
              {
                home.packages = [
                  devenv.outputs.packages.${system}.default
                  zen-browser.packages."${system}".default
                ];
              }
            ];
            extraSpecialArgs = {
              inherit system;
              inherit inputs;
              astalPkg = astal.packages.${system};
            };
          };
        };
      flake =
        let
          myLib = import ./lib {
            inherit (nixpkgs) lib;
            inherit disko;
          };
        in
        {
          nixosConfigurations."nix-general" = myLib.generalOs {
            extraModules = [
              ./os/modules/greetd-hyprland.nix
            ];
          };
          nixosConfigurations."nix-qemu" = myLib.generalOs {
            device = "/dev/vda";
            isQemu = true;
            bootLoader = "systemd";
          };
          nixosConfigurations."smb374-nix" = myLib.generalOs {
            device = "/dev/nvme0n1";
            extraModules = [
              ./os/modules/greetd-hyprland.nix
            ];
            bootLoader = "systemd";
          };
          nixosConfigurations."smb374-nix-desktop" = myLib.generalOs {
            device = "/dev/nvme0n1";
            extraModules = [
              ./os/hardware/bluetooth.nix
              ./os/modules/greetd-hyprland.nix
              # ./os/modules/sddm.nix
              # ./os/modules/nvidia.nix
              ./os/modules/amd.nix
              ./os/modules/hyprland.nix
              ./os/modules/gnome.nix
            ];
            bootLoader = "grub";
            timeZone = "US/Eastern";
          };
        };
    };
}
