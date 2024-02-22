{ config, lib, ... }:
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
    # Enable other modules
    modules = {
      ags.enable = true;
      rofi.enable = true;
      gtklock.enable = true;
    };
  };
}
