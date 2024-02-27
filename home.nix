{ lib, pkgs, ... }:
{
  imports = [
    # Nix Settings.
    ./modules/nix.nix
    # Big modules
    ./modules/firefox
    ./modules/fish
    ./modules/gpg
    ./modules/hyprland
    # Small modules
    ./modules/cava.nix
    ./modules/dunst.nix
    ./modules/fcitx5.nix
    ./modules/fonts.nix
    ./modules/gtk.nix
    ./modules/lazygit.nix
    ./modules/neovim.nix
    ./modules/qt.nix
    ./modules/rofi.nix
    ./modules/tmux.nix
  ];
  home = {
    # User info
    username = "poyehchen";
    homeDirectory = "/home/poyehchen";
    # Exposed session variables.
    sessionVariables = {
      LESS = "-MRq -z-2 -j2";
    };
    # DO NOT TOUCH!
    stateVersion = "23.11";
  };
  # Packages
  home.packages = with pkgs; [
    cachix
    clang
    dogdns
    fd
    gcc
    gnumake
    gnutar
    light
    nix-prefetch
    nodejs
    unzip
    stdenv
    trash-cli
    tree-sitter
    zig
  ] ++ lib.optionals (!modules.neovim.enable) [
    (python3.withPackages (ps: [
      pip
    ]))
  ];
  # Programs
  programs.home-manager.enable = true;
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza = {
      enable = true;
      enableAliases = true;
      extraOptions = [ "--color=always" "-h" ];
    };
    fzf = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = "fd -t f -H -I --exclude=.git";
    };
    git = {
      enable = true;
      delta.enable = true;
      userName = "Po-Yeh Chen";
      userEmail = "poyehchen@cs.nycu.edu.tw";
    };
    imv.enable = true;
    jq.enable = true;
    lf.enable = true;
    ripgrep.enable = true;
  };
}
