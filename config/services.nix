{ pkgs, ... }:

{
  imports = [
    # ./services.nix.d/dunst.nix
    ./services.nix.d/mpd.nix
    ./services.nix.d/mopidy.nix
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
    # ollama = {
    #   enable = false;
    #   acceleration = "cuda";
    #   host = "0.0.0.0";
    # };
    syncthing = {
      enable = true;
    };
  };
}
