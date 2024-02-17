{ pkgs, ... }:
let
  qtctAppearance = {
    custom_palette = false;
    icon_theme = "Papirus-Dark";
    standard_dialogs = "gtk3";
    style = "kvantum-dark";
  };
in {
  imports = [
    ./xdg.nix.d/configfiles/hyprland.nix
    ./xdg.nix.d/portal.nix
  ];
  xdg = {
    enable = true;
    configFile = {
      "fish/themes/Catppuccin Mocha.theme".source =
        ./sources/fish/catppuccin_mocha.theme;
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
