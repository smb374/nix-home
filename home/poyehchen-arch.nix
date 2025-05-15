{ pkgs, ... }:

{
  imports = [
    ./poyehchen-arch.nix.d/packages.nix
    ./poyehchen-arch.nix.d/kitty.nix
    ./poyehchen-arch.nix.d/hyprland.nix
    ./config/catppuccin.nix
    ./config/cursor.nix
    ./config/file.nix
    ./config/gtk.nix
    ./config/i18n.nix
    ./config/qt.nix
    ./config/rust.nix
    ./config/services.nix
    ./config/variables.nix
    ./config/xdg.nix
    # Shared programs
    ./config/programs.nix.d/ags.nix
    ./config/programs.nix.d/fish.nix
    ./config/programs.nix.d/gpg.nix
    ./config/programs.nix.d/helix.nix
    ./config/programs.nix.d/lazygit.nix
    ./config/programs.nix.d/rofi.nix
    ./config/programs.nix.d/tmux.nix
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza = {
      enable = true;
      extraOptions = [
        "--color=always"
        "-h"
      ];
    };
    fzf = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = "fd -t f -H -I --exclude=.git";
    };
    git = {
      enable = true;
      delta.enable = true;
      userName = "Po-Yeh Chen";
      userEmail = "poyehchen@cs.nycu.edu.tw";
      signing = {
        key = "0A507FC2325D77EA";
        signByDefault = false;
      };
    };
  };

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
