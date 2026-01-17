{
  config,
  pkgs,
  caelestia-config,
  ...
}:
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
        clock = "Noto Sans CJK TC";
        mono = "Maple Mono NL NF CN";
        sans = "Noto Sans CJK TC";
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
        theme.enableQt = true;
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
  xdg.configFile = {
    "electron-flags.conf".text = ''
      --enable-features=UseOzonePlatform
      --ozone-platform-hint=auto
      --ozone-platform=wayland
    '';
    "hypr" = {
      recursive = true;
      source = "${caelestia-config}/hypr";
    };
    "hypr/scheme/current.conf" = {
      source = "${caelestia-config}/hypr/scheme/default.conf";
    };
    "thunar".source = "${caelestia-config}/thunar";
    "caelestia/hypr-user.conf".source = ./sources/caelestia/hypr-user.conf;
    "caelestia/hypr-vars.conf".source = ./sources/caelestia/hypr-vars.conf;
  };
}
