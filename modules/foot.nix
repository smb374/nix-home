{ config, lib, ... }:
let
  cfg = config.modules.foot;
in
{
  options = {
    modules.foot.enable = lib.mkEnableOption "foot";
  };
  config = lib.mkIf cfg.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          term = "foot-extra";
          font = builtins.concatStringsSep ", " [
            "JetBrainsMono NF:pixelsize=22"
            "Noto Sans CJK JP:pixelsize=22"
            "Noto Sans CJK TC:pixelsize=22"
          ];
          dpi-aware = true;
          pad = "5x5 center";
        };
        cursor = { color = "1e2e2e cdd6f4"; };
        colors = {
          foreground = "cdd6f4"; # Text
          background = "1e1e2e"; # Base
          regular0 = "45475a"; # Surface 1
          regular1 = "f38ba8"; # red
          regular2 = "a6e3a1"; # green
          regular3 = "f9e2af"; # yellow
          regular4 = "89b4fa"; # blue
          regular5 = "f5c2e7"; # pink
          regular6 = "94e2d5"; # teal
          regular7 = "bac2de"; # Subtext 1
          bright0 = "585b70"; # Surface 2
          bright1 = "f38ba8"; # red
          bright2 = "a6e3a1"; # green
          bright3 = "f9e2af"; # yellow
          bright4 = "89b4fa"; # blue
          bright5 = "f5c2e7"; # pink
          bright6 = "94e2d5"; # teal
          bright7 = "a6adc8"; # Subtext 0
          alpha = 0.4;
        };
      };
    };
  };
}

