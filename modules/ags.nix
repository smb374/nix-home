{ pkgs, ... }:
{
  programs.ags = {
    enable = true;
    extraPackages = with pkgs; [ gtksourceview webkitgtk accountsservice ];
  };
  home.packages = with pkgs; [ bun brightnessctl sassc ];
}
