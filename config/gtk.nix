{ pkgs, ... }: {
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Qogir-dark";
      package = pkgs.qogir-icon-theme;
      size = 24;
    };
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
      name = "Catppuccin-Mocha-Standard-Lavender-Dark";
      package = (pkgs.catppuccin-gtk.override {
        accents = [ "blue" "lavender" ];
        variant = "mocha";
      });
    };
  };
}
