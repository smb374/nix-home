{ pkgs, ... }:
{
  xdg.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
  };
  xdg.configFile."ncmpcpp/tsession" = {
    enable = true;
    text = ''
      set status off

      send-keys "tmux split-window -h" C-m
      send-keys "stty -echo" C-m
      send-keys "export PS1=\"\"" C-m
      send-keys "pkill ueberzug" C-m
      send-keys "start_ueberzug; clear" C-m

      select-pane -t 1
      send-keys "ncmpcpp" C-m

      resize-pane -t 0 -x 49 -y 23
      resize-pane -t 1 -y 23
    '';
  };
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "x-scheme-handler/http" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
      "x-scheme-handler/https" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
      "x-scheme-handler/chrome" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
      "text/html" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
      "application/x-extension-htm" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
      "application/x-extension-html" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
      "application/x-extension-shtml" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
      "application/xhtml+xml" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
      "application/x-extension-xhtml" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
      "application/x-extension-xht" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
    };
    defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "x-scheme-handler/http" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
      "x-scheme-handler/https" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
      "text/html" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
      "x-scheme-handler/chrome" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
      "application/x-extension-htm" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
      "application/x-extension-html" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
      "application/x-extension-shtml" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
      "application/xhtml+xml" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
      "application/x-extension-xhtml" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
      "application/x-extension-xht" = [
        "zen.desktop"
        "zen-beta.desktop"
      ];
    };
  };
}
