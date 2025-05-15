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
