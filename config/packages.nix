{ pkgs, ... }:

{
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    with pkgs;
    [
      brightnessctl
      brave
      bun
      cachix
      discord
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
      kdePackages.qt6ct
      kdePackages.qtstyleplugin-kvantum
      killall
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.okular
      light
      pavucontrol
      mpc-cli
      nil
      nix-prefetch
      nixfmt-rfc-style
      networkmanagerapplet
      nmon
      nodejs
      nosql-workbench
      pcmanfm
      pfetch-rs
      polkit_gnome
      poppler_utils
      (python3.withPackages (pp: [
        pp.numpy
        pp.pandas
        pp.pwntools
      ]))
      unzip
      usbutils
      sassc
      serverless
      showmethekey
      slurp
      sshfs
      sysstat
      themechanger
      trash-cli
      tree
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
