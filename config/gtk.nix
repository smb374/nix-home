{ pkgs, ... }:

{
  gtk = {
    enable = false;
    font = {
      name = "Noto Sans CJK TC";
      package = pkgs.noto-fonts-cjk-sans;
      size = 11;
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
