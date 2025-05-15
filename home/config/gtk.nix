{ pkgs, ... }:

{
  gtk = {
    enable = true;
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
