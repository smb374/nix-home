{ lib, pkgs, ... }:
{
  imports = [
    ./settings.nix
    # Other modules to enable.
    ../ags.nix
    ../dunst.nix
    ../fcitx5.nix
    ../fonts.nix
    ../foot.nix
    ../gtk.nix
    ../gtklock.nix
    ../qt.nix
    ../rofi.nix
  ];
  options = {
    modules.hyprland.monitor = lib.mkOption { default = "eDP-1"; };
  };
  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      plugins = [ ];
    };
    # Link necessary config files.
    xdg.configFile = {
      "hypr/ags" = {
        source = ./sources/ags;
        recursive = true;
      };
      "hypr/gtklock" = {
        source = ./sources/gtklock;
        recursive = true;
      };
      "hypr/rofi" = {
        source = ./sources/rofi;
        recursive = true;
      };
      "hypr/scripts" = {
        source = ./sources/scripts;
        recursive = true;
      };
    };
    # Enable xdg-desktop-portal
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
      config.common.default = "*";
    };
    # Allow software renderer for machine in the wild.
    home.sessionVariables = {
      WLR_RENDERER_ALLOW_SOFTWARE = 1;
    };
    # Enable packages for screenshot script.
    home.packages = with pkgs; [
      hyprpaper
      light
      slurp
      wayshot
      wl-clipboard
    ];
    services.cliphist.enable = true;
  };
}
