{ ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        shell = "fish";
        term = "foot-direct";
        title = "foot";
        font = "Maple Mono NF CN:pixelsize=20, Noto Sans CJK JP:pixelsize=20, Noto Sans CJK TC:pixelsize=20";
        letter-spacing = 0;
        dpi-aware = false;
        pad = "5x5";
        bold-text-in-bright = false;
        gamma-correct-blending = false;
      };
      scrollback = {
        lines = 10000;
      };
      cursor = {
        style = "block";
      };
      colors = {
        alpha = 0.78;
        alpha-mode = "matching";
      };
      key-bindings = {
        scrollback-up-page = "Page_Up";
        scrollback-down-page = "Page_Down";
        search-start = "Control+Shift+f";
      };
      search-bindings = {
        cancel = "Escape";
        find-prev = "Shift+F3";
        find-next = "F3 Control+G";
      };
    };
  };
}
