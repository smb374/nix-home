{ ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  services.hypridle.enable = true;
}
