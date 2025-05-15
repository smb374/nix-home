{ ... }:

{
  arch-packages = [
    "hyprcursor"
    "hyprgraphics"
    "hypridle"
    "hyprland"
    "hyprland-protocols"
    "hyprland-qt-support"
    "hyprland-qtutils"
    "hyprlock"
    "hyprpolkitagent"
    "hyprsunset"
    "hyprutils"
    "hyprwayland-scanner"
    "xdg-desktop-portal-hyprland"
  ];

  xdg.configFile = {
    "hypr/hyprland.conf" = {
      source = ../sources/hyprland/hyprland.conf;
    };
    "hypr/rofi" = {
      source = ../sources/hyprland/rofi;
      recursive = true;
    };
    "hypr/scripts" = {
      source = ../sources/hyprland/scripts;
      recursive = true;
    };
    "hypr/hypridle.conf" = {
      source = ../sources/hyprland/hypridle.conf;
    };
    "hypr/hyprpaper.conf" = {
      source = ../sources/hyprland/hyprpaper.conf;
    };
    "hypr/hyprlock.conf" = {
      source = ../sources/hyprland/hyprlock.conf;
    };
    "hypr/conf.d/mocha.color.conf" = {
      source = ../sources/hyprland/mocha.color.conf;
    };
    "electron-flags.conf" = {
      text = ''
        --enable-features=UseOzonePlatform
        --ozone-platform-hint=auto
        --ozone-platform=wayland
      '';
    };
  };
}
