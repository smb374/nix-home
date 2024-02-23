{ config, lib, pkgs, ... }:
let
  cfg = config.modules.rofi;
in
{
  options = {
    modules.rofi.enable = lib.mkEnableOption "rofi";
  };
  config = lib.mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };
  };
}

