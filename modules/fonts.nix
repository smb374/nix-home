{ config, lib, pkgs, ... }:
let
  cfg = config.modules.fonts;
in
{
  options = {
    modules.fonts.enable = lib.mkEnableOption "fonts";
  };
  config = lib.mkIf cfg.enable {
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
      jetbrains-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" "FantasqueSansMono" ]; })
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
  };
}
