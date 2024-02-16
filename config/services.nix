{ ... }: {
  imports = [ ./services.nix.d/dunst.nix ];
  services = {
    cliphist.enable = true;
    gpg-agent = {
      enable = true;
      enableExtraSocket = true;
      enableScDaemon = true;
      enableSshSupport = true;
      pinentryFlavor = "qt";
    };
  };
}
