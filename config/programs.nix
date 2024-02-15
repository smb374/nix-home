{ ... }: {
  imports = [
    ./programs.nix.d/fish.nix
    ./programs.nix.d/gpg.nix
    ./programs.nix.d/rofi.nix
    ./programs.nix.d/tmux.nix
  ];
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
    lazygit.enable = true;
    lf.enable = true;
    neovim.enable = true;
    ripgrep.enable = true;
  };
}
