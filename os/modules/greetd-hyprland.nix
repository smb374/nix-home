{ pkgs, ... }: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r -c Hyprland";
      };
    };
  };
  # programs = {
  #   hyprland = {
  #     enable = true;
  #     xwayland.enable = true;
  #   };
  # };
}
