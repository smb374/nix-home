{ pkgs, ... }:
{
  imports = [
    ./lazygit.nix
  ];
  config = {
    enable = true;
    programs.neovim.enable = true;
    home.packages = with pkgs; [
      nil
      nodejs
      (python3.withPackages (ps: [
        pip
        pynvim
      ]))
    ];
    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
