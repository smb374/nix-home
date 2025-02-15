{ pkgs, inputs, ... }:

{
  imports = [
    ./programs.nix.d/alacritty.nix
    ./programs.nix.d/ags.nix
    # ./programs.nix.d/cava.nix
    # ./programs.nix.d/firefox.nix
    ./programs.nix.d/fish.nix
    ./programs.nix.d/foot.nix
    ./programs.nix.d/gpg.nix
    ./programs.nix.d/helix.nix
    ./programs.nix.d/lazygit.nix
    ./programs.nix.d/rofi.nix
    # ./programs.nix.d/sway.nix
    ./programs.nix.d/tmux.nix
    ./programs.nix.d/vscode.nix
    # ./programs.nix.d/waybar.nix
  ];
  programs = {
    bun.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza = {
      enable = true;
      extraOptions = [
        "--color=always"
        "-h"
      ];
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
      signing = {
        key = "0A507FC2325D77EA";
        signByDefault = true;
      };
    };
    imv.enable = true;
    java.enable = true;
    jq.enable = true;
    lf.enable = true;
    neovim = {
      enable = true;
      # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    };
    obs-studio = {
      enable = true;
    };
    ripgrep.enable = true;
    # sagemath = {
    #   enable = true;
    # };
    yazi.enable = true;
    zathura.enable = true;
  };
}
