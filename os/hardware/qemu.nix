{ modulesPath, ... }:

{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  boot.initrd.availableKernelModules = [
    "virtio_blk"
    "virtio_pci"
    "virtio_scsi"
  ];
  boot.initrd.kernelModules = [
    "virtio_blk"
    "virtio_pci"
    "virtio_scsi"
  ];
  boot.kernelModules = [ "kvm-amd" ];
}
