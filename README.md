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

- `github:smb374/nix-home#nix-general`: General OS with `/dev/sda`.
- `github:smb374/nix-home#nix-qemu`: QEMU Virtual Machine with VirtIO disk (`/dev/vda`).
- `github:smb374/nix-home#smb374-nix`: My laptop.

If no profile is suitable, clone this repo and add the desirable profile by yourself.

Then run the `disko` & `nixos-install` commands with `path:.#profile-name`,
otherwise you will have to commit the changes to use `.#profile-name` in the
repo directory.

## Configure home

Run the following command to set up home-directory:

```sh
nix run home-manager/master --accept-flake-config -- switch \
    --flake "github:smb374/nix-home#poyehchen" --no-write-lock-file
```
