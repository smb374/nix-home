{ pkgs, ... }:
let
  qtctAppearance = {
    custom_palette = false;
    icon_theme = "Papirus-Dark";
    standard_dialogs = "gtk3";
    style = "kvantum-dark";
  };
in
{
  imports = [
    ./xdg.nix.d/configfiles/hyprland.nix
    ./xdg.nix.d/portal.nix
  ];
  xdg = {
    enable = true;
    configFile = {
      "fish/themes/Catppuccin Mocha.theme".source = ./sources/fish/catppuccin_mocha.theme;
    };
  };
}
