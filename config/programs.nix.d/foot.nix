{ ... }:

{
  programs.foot = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "JetBrainsMono NF:pixelsize=22, Noto Sans CJK JP:pixelsize=22, Noto Sans CJK TC:pixelsize=22";
        dpi-aware = true;
        pad = "5x5 center";
      };
      colors.alpha = 0.4;
    };
  };
}
