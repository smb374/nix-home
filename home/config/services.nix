{ pkgs, ... }:

{
  imports = [
    # ./services.nix.d/dunst.nix
    ./services.nix.d/mpd.nix
    # ./services.nix.d/mopidy.nix
  ];
  services = {
    cliphist.enable = true;
    gpg-agent = {
      enable = true;
      enableExtraSocket = true;
      enableScDaemon = true;
      enableSshSupport = true;
      pinentry.package = pkgs.pinentry-gnome3;
    };
    syncthing.enable = true;
  };
}
