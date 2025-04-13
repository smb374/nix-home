{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "Maple Mono NF CN";
      size = 14.0;
      package = pkgs.maple-mono.NF-CN;
    };
    settings = {
      background_opacity = 1.0;
    };
    themeFile = "Catppuccin-Mocha";
    shellIntegration.mode = "no-cursor";
  };
}
