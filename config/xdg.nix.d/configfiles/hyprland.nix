{ ... }:

{
  xdg.configFile = {
    "hypr/ags" = {
      source = ../../sources/hyprland/ags;
      recursive = true;
    };
    "hypr/rofi" = {
      source = ../../sources/hyprland/rofi;
      recursive = true;
    };
    "hypr/scripts" = {
      source = ../../sources/hyprland/scripts;
      recursive = true;
    };
    "hypr/hypridle.conf" = {
      source = ../../sources/hyprland/hypridle.conf;
    };
    "hypr/hyprpaper.conf" = {
      source = ../../sources/hyprland/hyprpaper.conf;
    };
    "hypr/hyprlock.conf" = {
      source = ../../sources/hyprland/hyprlock.conf;
    };
    "hypr/conf.d/mocha.color.conf" = {
      source = ../../sources/hyprland/mocha.color.conf;
    };
  };
}
