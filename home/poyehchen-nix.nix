{ inputs, pkgs, ... }:

{
  imports = [
    ./config/catppuccin.nix
    ./config/cursor.nix
    ./config/file.nix
    ./config/gtk.nix
    ./config/hyprland.nix
    ./config/i18n.nix
    ./config/packages.nix
    ./config/programs.nix
    ./config/qt.nix
    ./config/services.nix
    ./config/services.nix.d/mpd.nix
    ./config/variables.nix
    ./config/xdg.nix
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
