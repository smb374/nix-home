{ pkgs, ... }:
{
  programs.ags = {
    enable = true;
    configDir = ../sources/ags;
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
}
