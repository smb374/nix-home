{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ lact ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Replaced 'driSupport32Bit'
  };
  systemd = {
    packages = with pkgs; [ lact ];
    services.lactd.wantedBy = [ "multi-user.target" ];
    tmpfiles.rules =
      let
        rocmEnv = pkgs.symlinkJoin {
          name = "rocm-combined";
          paths = with pkgs.rocmPackages; [
            rocblas
            hipblas
            clr
          ];
        };
      in
      [
        "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
      ];
  };
}
