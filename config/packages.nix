{ pkgs, ... }:

{
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs;
    [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
      brightnessctl
      bun
      cachix
      (catppuccin-kvantum.override {
        accent = "Lavender";
        variant = "Mocha";
      })
      dogdns
      fd
      gcc
      gnumake
      gnutar
      gtklock
      hyprpaper
      light
      nil
      nix-prefetch
      nodejs
      python3
      unzip
      sassc
      slurp
      trash-cli
      tree-sitter
      wayshot
      wl-clipboard
      zig
    ] ++ [
      # Fonts
      jetbrains-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" "FantasqueSansMono" ]; })
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
}
