{ pkgs, ... }:

{
  imports = [
    ./config/catppuccin.nix
    ./config/file.nix
    ./config/gtk.nix
    ./config/hyprland.nix
    ./config/i18n.nix
    ./config/packages.nix
    ./config/programs.nix
    ./config/qt.nix
    ./config/services.nix
    ./config/variables.nix
    ./config/xdg.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "poyehchen";
  home.homeDirectory = "/home/poyehchen";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.pointerCursor = {
    gtk.enable = true;
    name = "Qogir-dark";
    package = pkgs.qogir-icon-theme;
    size = 24;
  };
  home.file.".cargo/config.toml" = {
    text = ''
      [target.x86_64-unknown-linux-gnu]
      rustflags = ["-C", "link-arg=-fuse-ld=mold"]
    '';
  };

  # Self manage.
  programs.home-manager.enable = true;
  # Enable fontconfig
  fonts.fontconfig.enable = true;
  # Manages nix
  nix = {
    package = pkgs.nix;
    settings = {
      substituters = [ "https://cache.nixos.org" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
        "https://cache.iog.io"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
    };
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: prev: {
      matugen = final.rustPlatform.buildRustPackage rec {
        pname = "matugen";
        version = "2.4.0";

        src = final.fetchFromGitHub {
          owner = "InioX";
          repo = "matugen";
          rev = "refs/tags/v${version}";
          hash = "sha256-l623fIVhVCU/ylbBmohAtQNbK0YrWlEny0sC/vBJ+dU=";
        };

        cargoHash = "sha256-FwQhhwlldDskDzmIOxhwRuUv8NxXCxd3ZmOwqcuWz64=";

        meta = {
          description = "Material you color generation tool";
          homepage = "https://github.com/InioX/matugen";
          changelog = "https://github.com/InioX/matugen/blob/${src.rev}/CHANGELOG.md";
          license = final.lib.licenses.gpl2Only;
          maintainers = with final.lib.maintainers; [ lampros ];
          mainProgram = "matugen";
        };
      };
    })
  ];
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        # gsconnect.extensionUuid
      ];
    };
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
