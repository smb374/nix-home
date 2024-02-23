{ ... }:
{
  imports = [
    ./nix.nix
    # "Big" modules
    ./firefox
    ./fish
    ./gpg
    ./hyprland
    # "Small" modules
    ./ags.nix
    ./cava.nix
    ./dunst.nix
    ./fcitx5.nix
    ./foot.nix
    ./gtklock.nix
    ./lazygit.nix
    ./rofi.nix
  ];
  home = {
    username = "poyehchen";
    homeDirectory = "/home/poyehchen";
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;
}
