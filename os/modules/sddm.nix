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
      wayland.enable = true;
      theme = "catppuccin-sddm-corners";
    };
  };
}
