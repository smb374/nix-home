{
  config,
  lib,
  pkgs,
  ...
}:
let
  home = config.home.homeDirectory;
  hyprland_root = "${home}/.config/hypr";
  workspaceKeys = lib.lists.concatMap (
    i:
    let
      x = builtins.toString i;
    in
    [
      "$mainMod, ${x}, workspace, ${x}"
      "$mainMod SHIFT, ${x}, movetoworkspace, ${x}"
    ]
  ) (lib.lists.range 1 9);
  floatRule = type: expr: "float,${type}:${expr}";
in
{
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;
  services.hyprpaper.enable = true;
  home.packages = with pkgs; [
    hyprpanel
    hyprpicker
    hyprpolkitagent
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      monitor = [
        "DP-1,1920x1080@165.00,0x0,1"
      ];
      env = [
        "HYPRLAND_ROOT,${hyprland_root}"
        "SCRIPT_ROOT,${hyprland_root}/scripts"
        "ROFI_ROOT,${hyprland_root}/rofi"
        "WLR_NO_HARDWARE_CURSORS,1"
        "QT_QPA_PLATFORM,wayland;xcb"
      ];
      exec-once = [
        "fcitx5"
        "hyprpanel"
        "systemctl --user start hyprpolkitagent"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = false;
        };
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        repeat_rate = 50;
        repeat_delay = 200;
      };
      cursor = {
        no_hardware_cursors = true;
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
      gestures = {
        workspace_swipe = "off";
      };
      misc = {
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
      };
      xwayland = {
        force_zero_scaling = true;
      };
      windowrulev2 =
        (builtins.map (x: floatRule "class" x) [
          "(float-term)"
          "(music)"
          "(imv)"
          "(mpv)"
          "^(waydroid\..*)$"
        ])
        ++ (builtins.map (x: floatRule "title" x) [
          "(rmpd)"
          "(rmpc)"
          "(PyLNP)"
          "(Waydroid)"
        ])
        ++ [ "size 1000 500,class:(music)" ];
      # Keybindings
      "$mainMod" = "SUPER";
      bind = [
        # Main keys
        "$mainMod, RETURN, exec, foot"
        "$mainMod SHIFT, RETURN, exec, foot -a float-term"
        "$mainMod SHIFT, Q, killactive"
        "$mainMod SHIFT, F, togglefloating"
        "$mainMod SHIFT, R, exec, hyprctl reload"
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

        # OBS stuff
        "CTRL, F10, pass, ^(com\.obsproject\.Studio)$"
        "CTRL SHIFT, F10, pass, ^(com\.obsproject\.Studio)$"

        # MPD
        "SUPER ALT, M, exec, foot -a music -o colors.alpha=1.0 ncmpcpp"
        "SUPER, SPACE, exec, mpc -q toggle"
        ", XF86AudioPlay, exec, mpc -q toggle"
        ", XF86AudioPrev, exec, mpc -q prev"
        ", XF86AudioNext, exec, mpc -q next"

        # screenshot
        ", PRINT, exec, $SCRIPT_ROOT/screenshot"
        "CTRL, PRINT, exec, $SCRIPT_ROOT/screenshot select"
      ] ++ workspaceKeys;
      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
  xdg.configFile = {
    "hypr/rofi" = {
      source = ./sources/hyprland/rofi;
      recursive = true;
    };
    "hypr/scripts" = {
      source = ./sources/hyprland/scripts;
      recursive = true;
    };
    "hypr/hypridle.conf" = {
      source = ./sources/hyprland/hypridle.conf;
    };
    "hypr/hyprpaper.conf" = {
      source = ./sources/hyprland/hyprpaper.conf;
    };
    "hypr/hyprlock.conf" = {
      source = ./sources/hyprland/hyprlock.conf;
    };
    "hypr/conf.d/mocha.color.conf" = {
      source = ./sources/hyprland/mocha.color.conf;
    };
  };
}
