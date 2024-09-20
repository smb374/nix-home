{ pkgs, ... }:

{
  imports = [
    ./services.nix.d/dunst.nix
    ./services.nix.d/mpd.nix
  ];
  services = {
    cliphist.enable = true;
    gpg-agent = {
      enable = true;
      enableExtraSocket = true;
      enableScDaemon = true;
      enableSshSupport = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
  };
}
