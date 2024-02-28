{ ... }:

{
  xdg.configFile = {
    "hypr/ags" = {
      source = ../../sources/hyprland/ags;
      recursive = true;
    };
    "hypr/gtklock" = {
      source = ../../sources/hyprland/gtklock;
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
  };
}
