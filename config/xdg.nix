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
      "x-scheme-handler/http" = [ "floorp.desktop" ];
      "x-scheme-handler/https" = [ "floorp.desktop" ];
      "x-scheme-handler/chrome" = [ "floorp.desktop" ];
      "text/html" = [ "floorp.desktop" ];
      "application/x-extension-htm" = [ "floorp.desktop" ];
      "application/x-extension-html" = [ "floorp.desktop" ];
      "application/x-extension-shtml" = [ "floorp.desktop" ];
      "application/xhtml+xml" = [ "floorp.desktop" ];
      "application/x-extension-xhtml" = [ "floorp.desktop" ];
      "application/x-extension-xht" = [ "floorp.desktop" ];
    };
    defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "x-scheme-handler/http" = [ "floorp.desktop" ];
      "x-scheme-handler/https" = [ "floorp.desktop" ];
      "text/html" = [ "floorp.desktop" ];
      "x-scheme-handler/chrome" = [ "floorp.desktop" ];
      "application/x-extension-htm" = [ "floorp.desktop" ];
      "application/x-extension-html" = [ "floorp.desktop" ];
      "application/x-extension-shtml" = [ "floorp.desktop" ];
      "application/xhtml+xml" = [ "floorp.desktop" ];
      "application/x-extension-xhtml" = [ "floorp.desktop" ];
      "application/x-extension-xht" = [ "floorp.desktop" ];
    };
  };
}
