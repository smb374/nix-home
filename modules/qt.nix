{ config, lib, pkgs, ... }:
let
  cfg = config.modules.qt;
in
{
  options = {
    modules.qt.enable = lib.mkEnableOption "qt";
  };
  config = lib.mkIf cfg.enable {
    qt = {
      enable = true;
      platformTheme = "qtct";
      style.name = "kvantum";
    };
    home.packages = with pkgs; [
      (catppuccin-kvantum.override {
        accent = "Lavender";
        variant = "Mocha";
      })
    ];
    xdg.configFile =
      let
        qtctAppearance = {
          custom_palette = false;
          icon_theme = "Papirus-Dark";
          standard_dialogs = "gtk3";
          style = "kvantum-dark";
        };
      in
      {
        "Kvantum/kvantum.kvconfig".source =
          (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
            General.theme = "Catppuccin-Mocha-Lavender";
          };
        "qt5ct/qt5ct.conf".source = (pkgs.formats.ini { }).generate "qt5ct.conf" {
          Appearance = qtctAppearance;
          Font = {
            fixed = "JetBrains Mono,11,-1,5,50,0,0,0,0,0";
            general = "Noto Sans CJK TC,11,-1,5,50,0,0,0,0,0";
          };
        };
        "qt6ct/qt6ct.conf".source = (pkgs.formats.ini { }).generate "qt6ct.conf" {
          Appearance = qtctAppearance;
          Font = {
            fixed = "JetBrains Mono,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular";
            general =
              "Noto Sans CJK TC,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular";
          };
        };
      };
  };
}
