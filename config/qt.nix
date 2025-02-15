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
    # style.catppuccin = {
    #   enable = true;
    #   accent = "lavender";
    # };
    # style.name = "kvantum";
    platformTheme.name = "qt5ct";
  };
  xdg.configFile = {
    "Kvantum/catppuccin-mocha-lavender" = {
      source = "${catkvantum}/share/Kvantum/catppuccin-mocha-lavender";
      recursive = true;
    };
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=catppuccin-mocha-lavender
    '';
  };
}
