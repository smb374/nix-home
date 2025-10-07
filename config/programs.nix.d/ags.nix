{ pkgs, astalPkg, ... }:

{
  programs.ags = {
    enable = true;
    extraPackages =
      with pkgs;
      [
        gtksourceview
        accountsservice
        gnome-bluetooth
        libgtop
        bluez-tools
        dart-sass
        grimblast
        gpu-screen-recorder
        btop
      ]
      ++ (with astalPkg; [
        apps
        auth
        bluetooth
        hyprland
        mpris
        network
        notifd
        tray
        wireplumber
      ]);
  };
}
