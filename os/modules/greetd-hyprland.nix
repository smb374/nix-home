{ pkgs, lib, ... }:

{
  environment.systemPackages = [
    pkgs.tuigreet
  ];
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet -r --remember-session --cmd Hyprland";
      };
    };
  };
  boot.kernelParams = [ "console=tty1" ];
  systemd.services.greetd = {
    unitConfig = {
      After = lib.mkOverride 0 [ "multi-user.target" ];
    };
    serviceConfig = {
      Type = "idle";
    };
  };
}
