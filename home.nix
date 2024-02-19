{ pkgs, ... }:

{
  imports = [
    ./config/caches.nix
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
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Self manage.
  programs.home-manager.enable = true;
  # Enable fontconfig
  fonts.fontconfig.enable = true;
  # Manages nix
  nix.package = pkgs.nix;
}
