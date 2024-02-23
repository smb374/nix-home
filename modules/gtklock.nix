{ config, lib, pkgs, ... }:
let
  cfg = config.modules.gtklock;
in
{
  options = {
    modules.gtklock.enable = lib.mkEnableOption "ags";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ gtklock ];
  };
}

