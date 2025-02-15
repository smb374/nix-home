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
    ollama = {
      enable = true;
      acceleration = "cuda";
      host = "0.0.0.0";
    };
    syncthing = {
      enable = true;
    };
  };
}
