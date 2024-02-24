{ ... }:
{
  imports = [ ./modules ];
  # Enable modules
  #
  # Some modules are enable by other modules
  # You can also enable those here such that
  # when the modules remain enabled when the
  # parent one is disabled.
  modules = {
    # "Big" modules
    firefox.enable = true;
    fish.enable = true;
    gpg.enable = true;
    hyprland.enable = true;
    # "Small" modules
    cava.enable = true;
    dunst.enable = true;
    fcitx5.enable = true;
    fonts.enable = true;
    foot.enable = true;
    gtk.enable = true;
    qt.enable = true;
    lazygit.enable = true;
    rofi.enable = true;
    tmux.enable = true;
  };
}
