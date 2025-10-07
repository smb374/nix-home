{ inputs, pkgs, ... }:

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
    hyprcursor = {
      enable = true;
      size = 24;
    };
    name = "Qogir-Dark";
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
  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];
  nixpkgs.overlays = [
    (final: prev: {
      sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation {
        pname = "sf-mono-liga-bin";
        version = "dev";
        src = inputs.sf-mono-liga-src;
        dontConfigure = true;
        installPhase = ''
          mkdir -p $out/share/fonts/opentype
          cp -R $src/*.otf $out/share/fonts/opentype/
        '';
      };
    })
    (final: prev: rec {
      python3Packages = prev.python3.pkgs;
      mopidy-tidal = python3Packages.buildPythonApplication {
        pname = "mopidy-tidal";
        version = "0.3.9";
        format = "wheel";

        src = prev.fetchurl {
          url = "https://github.com/tehkillerbee/mopidy-tidal/releases/download/v0.3.9/mopidy_tidal-0.3.9-py3-none-any.whl";
          hash = "sha256-lXrFTAZ1UDs++71mn8GyzItMIBfyaqpO031blfR+5r4=";
        };
        propagatedBuildInputs = [
          prev.mopidy
          python3Packages.tidalapi
        ];
      };
    })
  ];
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        gsconnect.extensionUuid
        kimpanel.extensionUuid
      ];
    };
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
