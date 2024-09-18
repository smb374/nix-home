{ pkgs, ... }:

{
  gtk = {
    enable = true;
    font = {
      name = "Noto Sans CJK TC";
      package = pkgs.noto-fonts-cjk-sans;
      size = 11;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package =
        (pkgs.catppuccin-papirus-folders.override { accent = "lavender"; });
    };
    theme = {
      name = "catppuccin-mocha-lavender-standard";
      package = (pkgs.catppuccin-gtk.override {
        accents = [ "blue" "lavender" ];
        variant = "mocha";
      });
    };
  };
}
