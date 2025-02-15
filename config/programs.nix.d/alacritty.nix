{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        import = [
          "${pkgs.alacritty-theme}/catppuccin_mocha.toml"
        ];
      };
      window = {
        opacity = 0.4;
      };
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font Mono";
        };
        size = 14;
      };
    };
  };
}
