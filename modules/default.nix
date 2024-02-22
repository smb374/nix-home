{ ... }:
{
  imports = [
    ./nix.nix
    ./hyprland
    ./ags.nix
    ./gtklock.nix
    ./rofi.nix
  ];
  home = {
    username = "poyehchen";
    homeDirectory = "/home/poyehchen";
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;
}
