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
    fish.enable = true;
    gpg.enable = true;
    hyprland.enable = true;
    # "Small" modules
    dunst.enable = true;
    fcitx5.enable = true;
    foot.enable = true;
  };
}
