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
          family = "Liga SFMono Nerd Font";
        };
        size = 14;
      };
    };
  };
}
