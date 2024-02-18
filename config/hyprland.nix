{ config, lib, ... }:
let
  # NOTE: Check monitor name.
  monitor = "eDP-1";
  home = config.home.homeDirectory;
  hyprlandRoot = "${home}/.config/hypr";
  workspaceKeys = lib.lists.concatMap (i:
    let x = builtins.toString i;
    in [
      "$mainMod, ${x}, workspace, ${x}"
      "$mainMod SHIFT, ${x}, movetoworkspace, ${x}"
    ]) (lib.lists.range 1 9);
  floatRule = type: expr: "float,${type}:${expr}";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    plugins = [ ];
    settings = {
      # NOTE: Check monitor name.
      monitor = [
        "${monitor},1920x1080@60,0x0,1"
        ",preferred,auto,1,mirror,${monitor}"
      ];
      env = [
        "HYPRLAND_ROOT,${hyprlandRoot}"
        "SCRIPT_ROOT,${hyprlandRoot}/scripts"
        "AGS_CONFIG,${hyprlandRoot}/ags/config.js"
        "ROFI_ROOT,${hyprlandRoot}/rofi"
        "WLR_NO_HARDWARE_CURSORS,1"
      ];
      exec-once = [
        "hyprpaper"
        "fcitx5"
        "dunst"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "ags -c $AGS_CONFIG"
      ];
      exec = [ ];
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = { natural_scroll = false; };
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        repeat_rate = 50;
        repeat_delay = 200;
      };
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 3;
        "col.active_border" = "rgba(b4befeff)";
        "col.inactive_border" = "rgba(45475aff)";
        layout = "dwindle";
      };
      decoration = {
        rounding = 5;
        blur = {
          enabled = true;
          size = 7;
          passes = 2;
          new_optimizations = true;
        };
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(181825ee)";
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = { new_is_master = true; };
      gestures = { workspace_swipe = "off"; };
      misc = {
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
      };
      xwayland = { force_zero_scaling = true; };
      windowrulev2 = (builtins.map (x: floatRule "class" x) [
        "(float-term)"
        "(music)"
        "(imv)"
        "(mpv)"
      ]) ++ (builtins.map (x: floatRule "title" x) [
        "(rmpd)"
        "(rmpc)"
        "(PyLNP)"
      ]) ++ [ "size 1000 500,class:(music)" ];
      # Keybindings
      "$mainMod" = "SUPER";
      bind = [
        # Main keys
        "$mainMod, RETURN, exec, foot"
        "$mainMod SHIFT, RETURN, exec, foot -a float-term"
        "$mainMod SHIFT, Q, killactive"
        "$mainMod SHIFT, F, togglefloating"
        "$mainMod, F, fullscreen, 0"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"

        # rofi
        "$mainMod SHIFT, X, exec, $SCRIPT_ROOT/rofi-powermenu"
        "$mainMod, D, exec, $SCRIPT_ROOT/rofi-launcher drun"
        "$mainMod, R, exec, $SCRIPT_ROOT/rofi-launcher run"
        "$mainMod, W, exec, $SCRIPT_ROOT/rofi-launcher window"
        "$mainMod, V, exec, $SCRIPT_ROOT/rofi-clipboard"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Media keys
        ", XF86MonBrightnessUp, exec, light -A 10"
        ", XF86MonBrightnessDown, exec, light -U 10"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # screenshot
        ", PRINT, exec, $SCRIPT_ROOT/screenshot"
        "CTRL, PRINT, exec, $SCRIPT_ROOT/screenshot select"

        # TODO: MPD
        # "$mainMod ALT, M, exec, foot -a music -o colors.alpha=1.0 ncmpcpp"
        # "$mainMod, SPACE, exec, mpc toggle"
        # ", XF86AudioPlay, exec, mpc -q toggle"
        # ", XF86AudioPrev, exec, mpc -q prev"
        # ", XF86AudioNext, exec, mpc -q next"
      ] ++ workspaceKeys;
      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
