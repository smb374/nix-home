{ device ? "/dev/sda", ... }: {
  disko.devices = {
    disk.main = {
      device = device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            priority = 1;
            name = "NIXEFI";
            start = "1MiB";
            end = "1GiB";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          root = {
            name = "nixos";
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/root" = {
                  mountpoint = "/";
                  mountOptions = [ "compress=zstd" ];
                };
                "/home" = {
                  mountpoint = "/home";
                  mountOptions = [ "compress=zstd" ];
                };
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/swap" = {
                  mountpoint = "/.swap";
                  mountOptions = [ "noatime" ];
                  swap.swapfile.size = "4G";
                };
              };
            };
          };
        };
      };
    };
  };
}
