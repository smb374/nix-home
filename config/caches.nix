{ ... }: {
  caches.cachix = [
    {
      name = "nix-community";
      sha256 = "0m6kb0a0m3pr6bbzqz54x37h5ri121sraj1idfmsrr6prknc7q3x";
    }
    {
      name = "devenv";
      sha256 = "1wkgb3igqjp7x5x9bg3dz3c368mxlch3v665kynfj9c4l633llwj";
    }
  ];
}
