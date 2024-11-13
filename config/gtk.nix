{ pkgs, ... }:

{
  gtk = {
    enable = true;
    font = {
      name = "Noto Sans CJK TC";
      package = pkgs.noto-fonts-cjk-sans;
      size = 11;
    };
    catppuccin.icon = {
      enable = true;
      accent = "lavender";
    };
    theme = {
      name = "catppuccin-mocha-lavender-standard";
      package = (
        pkgs.catppuccin-gtk.override {
          accents = [
            "lavender"
          ];
          variant = "mocha";
        }
      );
    };
  };
}
