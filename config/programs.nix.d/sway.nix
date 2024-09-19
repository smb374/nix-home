{
  config,
  lib,
  pkgs,
  ...
}:
{
  wayland.windowManager.sway = {
    enable = true;
    package = null;
    config =
      let
        # Catppuccin Mocha
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      in
      {
        modifier = "Mod4";
        terminal = "foot";
        fonts = {
          names = [
            "JetBrainsMono NF"
            "Noto Sans TC"
          ];
          style = "Regular";
          size = 10.0;
        };
        startup = [
          {
            command = ''
              swayidle -w \
                  timeout 300 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
                  timeout 1800 'swaylock-fancy' \
                  before-sleep 'swaylock-fancy'
            '';
          }
          { command = "fcitx5"; }
          { command = "dunst"; }
          { command = "wl-paste --type text --watch cliphist store"; }
          { command = "wl-paste --type image --watch cliphist store"; }
          { command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"; }
        ];
        output = {
          "*".bg = "~/Pictures/101768924_p0.png fill";
        };
        input = {
          "type:keyboard" = {
            xkb_layout = "us";
            repeat_delay = "150";
            repeat_rate = "40";
          };
        };
        gaps.inner = 5;
        colors = {
          focused = {
            border = lavender;
            background = base;
            text = text;
            indicator = rosewater;
            childBorder = lavender;
          };
          focusedInactive = {
            border = overlay0;
            background = base;
            text = text;
            indicator = rosewater;
            childBorder = overlay0;
          };
          unfocused = {
            border = overlay0;
            background = base;
            text = text;
            indicator = rosewater;
            childBorder = overlay0;
          };
          urgent = {
            border = peach;
            background = base;
            text = peach;
            indicator = overlay0;
            childBorder = peach;
          };
          placeholder = {
            border = overlay0;
            background = base;
            text = text;
            indicator = overlay0;
            childBorder = overlay0;
          };
          background = base;
        };
        bars = [
          {
            position = "top";
            statusCommand = "while date +'%Y-%m-%d %X'; do sleep 1; done";
            fonts = {
              names = [
                "JetBrainsMono NF"
                "Noto Sans TC"
              ];
              style = "Regular";
              size = 10.0;
            };
            colors = {
              background = base;
              statusline = text;
              focusedStatusline = text;
              focusedSeparator = base;
              focusedWorkspace = {
                border = base;
                background = lavender;
                text = crust;
              };
              activeWorkspace = {
                border = base;
                background = surface2;
                text = text;
              };
              inactiveWorkspace = {
                border = base;
                background = base;
                text = text;
              };
              urgentWorkspace = {
                border = base;
                background = red;
                text = crust;
              };
            };
          }
        ];
        # Bindings not in here follows the default sway bindings.
        keybindings =
          let
            modifier = config.wayland.windowManager.sway.config.modifier;
          in
          lib.mkOptionDefault {
            # launcher commands
            "${modifier}+d" = "exec rofi-launcher drun";
            "${modifier}+r" = "exec rofi-launcher run";
            "${modifier}+w" = "exec rofi-launcher window";
            "${modifier}+c" = "exec rofi-clipboard";
            # reload config
            "${modifier}+Shift+r" = "reload";
            # exit menu
            "${modifier}+Shift+x" = "exec rofi-powermenu";
            # tabbed layout
            "${modifier}+t" = "layout tabbed";
            # toggle float
            "${modifier}+Shift+f" = "floating toggle";
            # toggle resize mode
            "${modifier}+Alt+r" = ''mode "resize"'';
          };
      };
    extraConfig = ''
      #
      # Blur
      #
      smart_corner_radius on
      corner_radius 5
      blur enable
      blur_passes 3
      blur_radius 7
    '';
  };
}
