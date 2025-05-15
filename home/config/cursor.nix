{pkgs, ...}:

{
  home.pointerCursor = {
    gtk.enable = true;
    hyprcursor = {
      enable = true;
      size = 24;
    };
    name = "Qogir-Dark";
    package = pkgs.qogir-icon-theme;
    size = 24;
  };
}
