{ config, lib, ... }:

{
  options.arch-packages = {
    type = lib.types.listOf lib.types.str;
  };

  config = {
    arch-packages = [
      "htop"
      "traceroute"
    ];

    home.activation = {
      installArchPackages = lib.hm.dag.entryAfter [ "installPackages" ] ''
        run sudo pacman -Sy --noconfirm --needed ${lib.concatStringsSep " " config.arch-packages}
      '';
    };
  };
}
