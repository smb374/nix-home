{ ... }:

{
  imports = [
    ./programs.nix.d/ags.nix
    ./programs.nix.d/cava.nix
    # ./programs.nix.d/firefox.nix
    ./programs.nix.d/fish.nix
    ./programs.nix.d/foot.nix
    ./programs.nix.d/gpg.nix
    ./programs.nix.d/lazygit.nix
    ./programs.nix.d/rofi.nix
    # ./programs.nix.d/sway.nix
    ./programs.nix.d/tmux.nix
    ./programs.nix.d/waybar.nix
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
    };
    imv.enable = true;
    jq.enable = true;
    lf.enable = true;
    neovim.enable = true;
    ripgrep.enable = true;
  };
}
