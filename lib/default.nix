{ lib, disko }:

{
  generalOs =
    {
      device ? "/dev/sda", # Root disk
      isQemu ? false, # Is QEMU VM?
      bootLoader ? "grub-removable", # Bootloader selection
      extraModules ? [ ], # Extra modules to load
      timeZone ? "Asia/Taipei" # System Timezone
    }:
    let
      bootModule = {
        grub = ../os/boot/grub.nix;
        grub-removable = ../os/boot/grub-removable.nix;
        systemd = ../os/boot/systemd-boot.nix;
      };
    in lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        disko.nixosModules.disko
        ../os/disko.nix
        ({ config, ... }: { config.os.disko.device = device; })
        ../os/configuration.nix
        ({time.timeZone = timeZone;})
        ../os/hardware/general.nix
        (bootModule.${bootLoader} or bootModule.grub-removable)
      ] ++ (if isQemu then [ ../os/hardware/qemu.nix ] else [ ])
        ++ extraModules;
    };
}
