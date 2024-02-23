{ config, lib, pkgs, ... }:
let
  cfg = config.modules.dunst;
in
{
  options = {
    modules.dunst.enable = lib.mkEnableOption "dunst";
  };
  config = lib.mkIf cfg.enable {
    services.dunst = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package =
          (pkgs.catppuccin-papirus-folders.override { accent = "lavender"; });
      };
      settings = {
        global = {
          width = "(0, 500)";
          offset = "30x30";
          notification_limit = 0;
          progress_bar_corner_radius = 0;
          icon_corner_radius = 0;
          separator_height = 3;
          padding = 10;
          horizontal_padding = 10;
          text_icon_padding = 10;
          frame_width = 2;
          frame_color = "#B4BEFE";
          gap_size = 10;
          separator_color = "frame";
          font = "JetBrains Mono 12";
          line_height = 2;
          corner_radius = 6;
        };
        urgency_low = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
        };
        urgency_normal = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
        };
        urgency_critical = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
          frame_color = "#FAB387";
        };
      };
    };
  };
}

