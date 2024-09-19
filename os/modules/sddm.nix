{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    catppuccin-sddm
    catppuccin-sddm-corners
  ];

  services = {
    xserver.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = false;
      theme = "catppuccin-sddm-corners";
    };
  };
}
