{ pkgs, ... }:

let
  catkvantum = pkgs.catppuccin-kvantum.override {
    accent = "lavender";
    variant = "mocha";
  };
in
{
  home.packages = with pkgs; [
    catkvantum
    catppuccin-qt5ct
  ];
  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };
  xdg.configFile = {
    "Kvantum/catppuccin-mocha-lavender/catppuccin-mocha-lavender" = {
      source = "${catkvantum}/share/Kvantum/catppuccin-mocha-lavender";
      recursive = true;
    };
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=catppuccin-mocha-lavender
    '';
  };
}
