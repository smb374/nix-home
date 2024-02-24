{ ... }:
{
  imports = [
    # Nix settings
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
    ./fonts.nix
    ./foot.nix
    ./gtk.nix
    ./gtklock.nix
    ./lazygit.nix
    ./qt.nix
    ./rofi.nix
    ./tmux.nix
  ];
  home = {
    username = "poyehchen";
    homeDirectory = "/home/poyehchen";
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;
}
