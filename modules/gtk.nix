{ config, lib, pkgs, ... }:
let
  cfg = config.modules.gtk;
in
{
  options = {
    modules.gtk.enable = lib.mkEnableOption "gtk";
  };
  config = lib.mkIf cfg.enable {
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
        name = "Catppuccin-Mocha-Standard-Lavender-Dark";
        package = (pkgs.catppuccin-gtk.override {
          accents = [ "blue" "lavender" ];
          variant = "mocha";
        });
      };
    };
    home.pointerCursor = {
      gtk.enable = true;
      name = "Qogir-dark";
      package = pkgs.qogir-icon-theme;
      size = 24;
    };
  };
}
