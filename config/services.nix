{ ... }: {
  imports = [ ./services.nix.d/dunst.nix ];
  services = {
    gpg-agent = {
      enable = true;
      enableExtraSocket = true;
      enableScDaemon = true;
      enableSshSupport = true;
      pinentryFlavor = "qt";
    };
  };
}
