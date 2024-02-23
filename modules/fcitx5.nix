{ config, lib, pkgs, ... }:
let
  cfg = config.modules.fcitx5;
in
{
  options = {
    modules.fcitx5.enable = lib.mkEnableOption "fcitx5";
  };
  config = lib.mkIf cfg.enable {
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-rime fcitx5-gtk ];
    };
  };
}

