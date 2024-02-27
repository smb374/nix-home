{ config, lib, pkgs, ... }:
let
  cfg = config.modules.fonts;
in
{
  options = {
    modules.fonts = {
      nerdfonts = lib.mkOption { default = [ "JetBrainsMono" "FantasqueSansMono" ]; };
    };
  };
  config = lib.mkIf cfg.enable {
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
      jetbrains-mono
      (nerdfonts.override { fonts = cfg.nerdfonts; })
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
  };
}
