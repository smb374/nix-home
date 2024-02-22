{ lib, disko }:
{
  generalOs =
    { device ? "/dev/sda" # Root disk
    , isQemu ? false # Is QEMU VM?
    , bootLoader ? "grub-removable" # Bootloader selection
    , extraModules ? [ ] # Extra modules to load
    }:
    let
      bootModule = {
        grub = ../os/boot/grub.nix;
        grub-removable = ../os/boot/grub-removable.nix;
        systemd = ../os/boot/systemd-boot.nix;
      };
    in
    lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        disko.nixosModules.disko
        ../os/disko.nix
        { _module.args.device = device; }
        ../os/configuration.nix
        ../os/hardware/general.nix
        (bootModule.${bootLoader} or bootModule.grub-removable)
      ] ++ (if isQemu then [ ../os/hardware/qemu.nix ] else [ ])
      ++ extraModules;
    };
  genDiskoConfigs = disks:
    builtins.foldl'
      (acc: x: acc // { "${x}" = import ../os/disko.nix { device = "/dev/${x}"; }; })
      { }
      disks;
}
