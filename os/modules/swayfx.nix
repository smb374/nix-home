{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtwayland
    kdePackages.qtwayland
  ];
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
    extraPackages = with pkgs; [
      swayidle
      swaylock-fancy
    ];
    extraSessionCommands = ''
      # SDL:
      export SDL_VIDEODRIVER=wayland
      # QT (needs qt5.qtwayland in systemPackages):
      export QT_QPA_PLATFORM=wayland-egl
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      # Fix for some Java AWT applications (e.g. Android Studio),
      # use this if they aren't displayed properly:
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
  };
}
