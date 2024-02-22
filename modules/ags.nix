{ config, lib, pkgs, ... }:
let
  cfg = config.modules.ags;
in
{
  options = {
    modules.ags = { enable = lib.mkEnableOption "ags"; };
  };
  config = lib.mkIf cfg.enable {
    programs.ags = {
      enable = true;
      extraPackages = with pkgs; [ gtksourceview webkitgtk accountsservice ];
    };
  };
}
