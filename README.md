# nix-home: my nix configuration

## Install NixOS

Run the following command and type the root password when prompted:

```sh
# Automated partitioning
# Replace $DISK with target disk to install the OS.
nix --experimental-features "nix-command flakes" run \
    "github:smb374/nix-home#auto-partition" \
    --accept-flake-config \
    --no-write-lock-file \
    -- $DISK
# Perform installation
nixos-install --flake "github:smb374/nix-home#smb374-nix" --no-write-lock-file
```

## Configure home

Run the following command to set up home-directory:

```sh
nix run home-manager/master --accept-flake-config -- switch \
    --flake "github:smb374/nix-home#poyehchen" --no-write-lock-file
```
