{ config, lib, pkgs, ... }:
let
  cfg = config.modules.hyprland;
in
{
  imports = [
    ./settings.nix
  ];
  options = {
    modules.hyprland = {
      enable = lib.mkEnableOption "hyprland";
      monitor = lib.mkOption { default = "eDP-1"; };
    };
  };
  config = lib.mkIf cfg.enable {
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
    # Enable other modules
    modules = {
      ags.enable = true;
      dunst.enable = true;
      fcitx5.enable = true;
      fonts.enable = true;
      foot.enable = true;
      gtk.enable = true;
      gtklock.enable = true;
      qt.enable = true;
      rofi.enable = true;
    };
    # Enable packages for screenshot script.
    home.packages = with pkgs; [
      light
      slurp
      wayshot
      wl-clipboard
    ];
    services.cliphist.enable = true;
  };
}
