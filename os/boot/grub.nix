{ ... }:

{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = false;
      device = "nodev";
      fsIdentifier = "uuid";
    };
  };
}
