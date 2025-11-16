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
  programs.caelestia = {
    enable = true;
    systemd = {
      enable = false; # if you prefer starting from your compositor
      target = "graphical-session.target";
      environment = [ ];
    };
    settings = {
      appearance.font.family = {
        mono = "Maple Mono NL NF CN";
      };
      general.idle = {
        timeouts = [
          {
            timeout = 180;
            idleAction = "lock";
          }
          {
            timeout = 300;
            idleAction = "dpms off";
            returnAction = "dpms on";
          }
          # {
          #   timeout = 900;
          #   idleAction = [
          #     "systemctl"
          #     "suspend-then-hibernate"
          #   ];
          # }
        ];
      };
      bar.status = {
        showBattery = false;
      };
      paths.wallpaperDir = "~/Pictures";
      workspaces.showWindows = true;
    };
    cli = {
      enable = true; # Also add caelestia-cli to path
      settings = {
        theme.enableQt = false;
      };
    };
  };
  home.packages = with pkgs; [
    hyprland-qtutils
    hyprpicker
    hyprpolkitagent
    hyprsunset
  ];
  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
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
        "GDK_BACKEND,wayland,x11,*"
        "SDL_VIDEODRIVER,wayland,x11,windows"
        "CLUTTER_BACKEND,wayland"
        # Qt
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
      ];
      exec-once = [
        "fcitx5"
        "trash-empty 30"
        "gnome-keyring-daemon --start --components=secrets"
        "systemctl --user start hyprpolkitagent"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "caelestia shell -d"
        "caelestia resizer -d"
      ];
      exec = [
        "hyprctl dispatch submap global"
      ];
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = false;
        };
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        repeat_rate = 40;
        repeat_delay = 300;
      };
      cursor = {
        hotspot_padding = 1;
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
          size = 5;
          passes = 3;
          new_optimizations = true;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(181825ee)";
        };
      };
      animations = {
        enabled = true;
        bezier = [
          "specialWorkSwitch, 0.05, 0.7, 0.1, 1"
          "emphasizedAccel, 0.3, 0, 0.8, 0.15"
          "emphasizedDecel, 0.05, 0.7, 0.1, 1"
          "standard, 0.2, 0, 0, 1"
        ];
        animation = [
          "layersIn, 1, 5, emphasizedDecel, slide"
          "layersOut, 1, 4, emphasizedAccel, slide"
          "fadeLayers, 1, 5, standard"
          "windowsIn, 1, 5, emphasizedDecel"
          "windowsOut, 1, 3, emphasizedAccel"
          "windowsMove, 1, 6, standard"
          "workspaces, 1, 5, standard"
          "specialWorkspace, 1, 4, specialWorkSwitch, slidefadevert 15%"
          "fade, 1, 6, standard"
          "fadeDim, 1, 6, standard"
          "border, 1, 6, standard"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      misc = {
        vfr = true;
        vrr = 1;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        new_window_takes_over_fullscreen = 2;
        allow_session_lock_restore = true;
        middle_click_paste = false;
        focus_on_activate = true;
        session_lock_xray = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
      };
      xwayland = {
        force_zero_scaling = true;
      };
      windowrule = [
        # Float, resize, and center
        "opacity $windowOpacity override, fullscreen:0"
        "opaque, class:foot|equibop|org\.quickshell|imv|swappy"
        "center 1, floating:1, xwayland:0"
        "float, class:foot, title:nmtui"
        "size 60% 70%, class:foot, title:nmtui"
        "center 1, class:foot, title:nmtui"
        "float, class:org\.gnome\.Settings"
        "size 70% 80%, class:org\.gnome\.Settings"
        "center 1, class:org\.gnome\.Settings"
        "float, class:org\.pulseaudio\.pavucontrol|yad-icon-browser"
        "size 60% 70%, class:org\.pulseaudio\.pavucontrol|yad-icon-browser"
        "center 1, class:org\.pulseaudio\.pavucontrol|yad-icon-browser"
        "float, class:nwg-look"
        "size 50% 60%, class:nwg-look"
        "center 1, class:nwg-look"
        # Special Workspaces
        "workspace special:sysmon, class:btop"
        "workspace special:music, class:feishin|Spotify|Supersonic|Cider"
        "workspace special:music, initialTitle:Spotify( Free)?" # Spotify wayland, it has no class for some reason
        "workspace special:communication, class:discord|equibop|vesktop|whatsapp"
        "workspace special:todo, class:Todoist"
        # Picture in Picture stuff.
        "move 100%-w-2% 100%-w-3%, title:Picture(-| )in(-| )[Pp]icture"
        "keepaspectratio, title:Picture(-| )in(-| )[Pp]icture"
        "float, title:Picture(-| )in(-| )[Pp]icture"
        "pin, title:Picture(-| )in(-| )[Pp]icture"
        # XWayland Popups
        "nodim, xwayland:1, title:win[0-9]+"
        "noshadow, xwayland:1, title:win[0-9]+"
        "rounding 10, xwayland:1, title:win[0-9]+"
        # Steam
        "rounding 10, title:, class:steam"
        "float, title:Friends List, class:steam"
        "immediate, class:steam_app_[0-9]+" # Allow tearing for steam games
        "idleinhibit always, class:steam_app_[0-9]+" # Always idle inhibit when playing a steam game
        # ATLauncher console
        "float, class:com-atlauncher-App, title:ATLauncher Console"
        # Autodesk Fusion 360
        "noblur, title:Fusion360|(Marking Menu), class:fusion360\.exe"
      ];
      windowrulev2 =
        (builtins.map (x: floatRule "class" x) [
          "(float-term)"
          "(music)"
          "(imv)"
          "(mpv)"
          "^(waydroid\..*)$"
          "(guifetch)"
          "(yad)"
          "(zenity)"
          "(wev)"
          "(org\.gnome\.FileRoller)"
          "(file-roller)"
          "(blueman-manager)"
          "(com\.github\.GradienceTeam\.Gradience)"
          "(feh)"
          "(system-config-printer)"
          "(org\.quickshell)"
        ])
        ++ (builtins.map (x: floatRule "title" x) [
          "(rmpd)"
          "(rmpc)"
          "(PyLNP)"
          "(Waydroid)"
          "(Emulator)"
        ])
        ++ [ "size 1600 800,class:(music)" ];
      layerrule = [
        "animation fade, hyprpicker" # Colour picker out animation
        "animation fade, logout_dialog" # wlogout
        "animation fade, selection" # slurp
        "animation fade, wayfreeze"
        # Fuzzel
        "animation popin 80%, launcher"
        "blur, launcher"
        # Shell
        "noanim, caelestia-(border-exclusion|area-picker)"
        "animation fade, caelestia-(drawers|background)"
        "blur, caelestia-drawers"
        "ignorealpha 0.57, caelestia-drawers"
      ];
      # Keybindings
      "$mainMod" = "SUPER";
      bind = [
        # Main keys
        "$mainMod, RETURN, exec, kitty"
        "$mainMod SHIFT, RETURN, exec, kitty --app-id=float-term"
        "$mainMod SHIFT, Q, killactive"
        "$mainMod SHIFT, F, togglefloating"
        "$mainMod SHIFT, R, exec, pkill quickshell; caelestia shell -d"
        "$mainMod, F, fullscreen, 0"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"

        # rofi
        # "$mainMod SHIFT, X, exec, $SCRIPT_ROOT/rofi-powermenu"
        # "$mainMod, D, exec, $SCRIPT_ROOT/rofi-launcher drun"
        # "$mainMod, R, exec, $SCRIPT_ROOT/rofi-launcher run"
        # "$mainMod, W, exec, $SCRIPT_ROOT/rofi-launcher window"
        # "$mainMod, V, exec, $SCRIPT_ROOT/rofi-clipboard"
        "$mainMod SHIFT, X, global, caelestia:session"
        "$mainMod, D, global, caelestia:launcher"
        "$mainMod, V, exec, pkill fuzzel || caelestia clipboard"
        "$mainMod SHIFT, V, exec, pkill fuzzel || caelestia clipboard -d"
        "$mainMod, Period, exec, pkill fuzzel || caelestia emoji -p"
        "$mainMod, K, global, caelestia:showall"
        "$mainMod, L, global, caelestia:lock"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e-1"
        "$mainMod, mouse_up, workspace, e+1"
        "$mainMod, mouse_left, workspace, e-1"
        "$mainMod, mouse_right, workspace, e+1"

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
        "SUPER ALT, M, exec, kitty --app-id=music rmpc"
        "SUPER, SPACE, global, caelestia:mediaToggle"
        ", XF86AudioPlay, global, caelestia:mediaToggle"
        ", XF86AudioPause, global, caelestia:mediaToggle"
        ", XF86AudioPrev, global, caelestia:mediaPrev"
        ", XF86AudioNext, global, caelestia:mediaNext"
        ", XF86AudioStop, global, caelestia:mediaStop"

        # screenshot
        ", PRINT, exec, $SCRIPT_ROOT/screenshot"
        "CTRL, PRINT, exec, $SCRIPT_ROOT/screenshot select"
      ]
      ++ workspaceKeys;
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
    "electron-flags.conf" = {
      text = ''
        --enable-features=UseOzonePlatform
        --ozone-platform-hint=auto
        --ozone-platform=wayland
      '';
    };
  };
}
