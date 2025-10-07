{ ... }:

{
  imports = [
    ./programs.nix.d/alacritty.nix
    ./programs.nix.d/ags.nix
    # ./programs.nix.d/cava.nix
    # ./programs.nix.d/firefox.nix
    ./programs.nix.d/fish.nix
    ./programs.nix.d/floorp.nix
    ./programs.nix.d/foot.nix
    ./programs.nix.d/gpg.nix
    ./programs.nix.d/helix.nix
    ./programs.nix.d/kitty.nix
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
    ghostty = {
      enable = true;
      settings = {
        font-family = "Maple Mono NF CN Medium";
        font-size = 12;
        theme = "catppuccin-mocha";
        cursor-style = "block";
        shell-integration-features = "no-cursor";
        background-opacity = 0.6;
        background-blur = true;
      };
    };
    git = {
      enable = true;
      delta.enable = true;
      lfs.enable = true;
      userName = "Po-Yeh Chen";
      userEmail = "poyehchen@cs.nycu.edu.tw";
      signing = {
        key = "0A507FC2325D77EA";
        signByDefault = false;
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
    sagemath = {
      enable = true;
    };
    yazi.enable = true;
    zathura.enable = true;
    zed-editor = {
      enable = true;
      installRemoteServer = true;
    };
  };
}
