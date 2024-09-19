{ pkgs, ... }:

{
  services.xserver.desktopManager.gnome = {
    enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-tour
    cheese # webcam tool
    gedit # text editor
    gnome-music
    gnome-terminal
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ];

  environment.systemPackages = with pkgs.gnomeExtensions; [
    blur-my-shell
    pop-shell
  ];
}
