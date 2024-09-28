{ pkgs, ... }:

{
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    with pkgs;
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
      brave
      bun
      cachix
      (catppuccin-kvantum.override {
        accent = "Lavender";
        variant = "Mocha";
      })
      dogdns
      fastfetch
      fd
      floorp
      gcc
      gdb
      gnumake
      gnutar
      grim
      gtklock
      imagemagick
      killall
      libsForQt5.okular
      light
      lxqt.pavucontrol-qt
      mpc-cli
      nil
      nix-prefetch
      nixfmt-rfc-style
      networkmanagerapplet
      nmon
      nodejs
      pcmanfm
      pfetch-rs
      polkit_gnome
      python3
      unzip
      usbutils
      sassc
      showmethekey
      slurp
      sshfs
      sysstat
      trash-cli
      tree-sitter
      typst
      wayshot
      wl-clipboard
      zig
      zip
      zoxide
    ]
    ++ [
      # Custom packages
      (pkgs.callPackage ./packages.nix.d/fetch.nix { })
    ]
    ++ [
      # Fonts
      jetbrains-mono
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
          "FantasqueSansMono"
        ];
      })
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      stix-two
    ];
}
