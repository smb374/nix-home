# nix-home: my nix configuration

## Install NixOS

Run the following command and type the root password when prompted:

```sh
# Run disko.
nix --experimental-features "nix-command flakes" \
    run "github:nix-community/disko" -- \
    --mode disko \
    --flake "github:smb374/nix-home/disko#smb374-nix"
# Perform installation
nixos-install --flake "github:smb374/nix-home#smb374-nix" --no-write-lock-file
```

### Custom Profile

There are 3 different default profiles:

- `github:smb374/nix-home#smb374-nix`: use `/dev/sda` as root disk.
- `github:smb374/nix-home#smb374-nix-vda`: use `/dev/vda` as root disk (QEMU).
- `github:smb374/nix-home#smb374-nvme0n1`: use `/dev/nvme0n1` as root disk.

If no profile is suitable, clone this repo and add the desirable profile by yourself:

```nix
{
  # Default profiles
  nixosConfigurations."smb374-nix" = generalOs { };
  nixosConfigurations."smb374-nix-vda" = generalOs {
    device = "/dev/vda";
    isQemu = true; # enable if using in qemu.
  };
  nixosConfigurations."smb374-nix-nvme0n1" =
    generalOs { device = "/dev/nvme0n1"; };
  # Custom profile using generalOs function
  nixosConfigurations."local-general" = generalOs { device = "[Your device]"; };
  # Custom profile using nixpkgs.lib.nixosSystem
  nixosConfigurations."local-custom" =
    nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        disko.nixosModules.disko
        ./os/disko.nix
        { _module.args.device = "[Your device]"; }
        ./os/configuration.nix
        # Uncomment the one that is suitable or make your own.
        # ./os/hardware-configuration.nix
        # ./os/hardware-configuration-qemu.nix
        # Add modules below...
      ];
    };
};
```

Then run the `disko` & `nixos-install` commands with `path:.#profile-name`,
otherwise you will have to commit the changes to use `.#profile-name` in the
repo directory.

## Configure home

Run the following command to set up home-directory:

```sh
nix run home-manager/master --accept-flake-config -- switch \
    --flake "github:smb374/nix-home#poyehchen" --no-write-lock-file
```
