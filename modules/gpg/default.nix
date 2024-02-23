{ config, lib, ... }:
let
  cfg = config.modules.gpg;
in
{
  options = {
    modules.gpg = { enable = lib.mkEnableOption "gpg"; };
  };
  config = lib.mkIf cfg.enable {
    programs.gpg = {
      enable = true;
      mutableKeys = true;
      mutableTrust = true;
      publicKeys = [{
        source = ./sources/gpg/pub-0x0A507FC2325D77EA.gpg;
        trust = "ultimate";
      }];
      settings = {
        armor = true;
        no-greeting = true;
        throw-keyids = true;
      };
    };
    services.gpg-agent = {
      enable = true;
      enableExtraSocket = true;
      enableScDaemon = true;
      enableSshSupport = true;
      pinentryFlavor = "qt";
    };
  };
}
