{ ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "JetBrainsMono NF:pixelsize=20, Noto Sans CJK JP:pixelsize=20, Noto Sans CJK TC:pixelsize=20";
        # font = "FantasqueSansM Nerd Font:pixelsize=22, Noto Sans CJK JP:pixelsize=22, Noto Sans CJK TC:pixelsize=22";
        dpi-aware = true;
        pad = "5x5 center";
      };
      colors.alpha = 0.4;
    };
  };
}
