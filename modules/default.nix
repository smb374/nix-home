{ ... }:
{
  imports = [
    ./nix.nix
    # "Big" modules
    ./gpg
    ./hyprland
    # "Small" modules
    ./ags.nix
    ./dunst.nix
    ./fcitx5.nix
    ./foot.nix
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
