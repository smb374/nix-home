{ pkgs, inputs, ... }:

{
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    with pkgs;
    [
      alacritty-theme
      brightnessctl
      brave
      bun
      cachix
      cargo
      chromium
      discord
      dogdns
      eslint
      fastfetch
      fd
      ffmpeg-full
      filezilla
      floorp
      gcc
      gdb
      ghidra-bin
      gimp-with-plugins
      gnumake
      gnutar
      go
      gopls
      grim
      gtklock
      helix
      iaito
      imagemagick
      kdePackages.okular
      kdePackages.qt6ct
      kdePackages.qtstyleplugin-kvantum
      killall
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
      light
      lxqt.pavucontrol-qt
      man-pages
      marp-cli
      meld
      mpc-cli
      mpv
      nil
      nix-prefetch
      nix-prefetch-github
      nixfmt-rfc-style
      nemo
      networkmanagerapplet
      nmon
      nodejs
      nosql-workbench
      pcmanfm
      pfetch-rs
      playerctl
      poppler_utils
      (python3.withPackages (pp: [
        pp.numpy
        pp.pandas
        pp.pwntools
      ]))
      qbittorrent
      radare2
      rustc
      rust-analyzer
      ueberzugpp
      unzip
      usbutils
      sassc
      serverless
      showmethekey
      slurp
      sshfs
      sysstat
      themechanger
      tinymist
      trash-cli
      tree
      tree-sitter
      typescript-language-server
      typst
      wayshot
      wl-clipboard
      x264
      x265
      yq-go
      zed-editor
      zig
      zip
      zoxide
    ]
    ++ [
      # Custom packages
      (pkgs.callPackage ./packages.nix.d/fetch.nix { })
      (pkgs.writeShellScriptBin "start_ueberzug" ''
        rm -f /tmp/ueberzugpp.pid
        touch /tmp/ueberzugpp.pid
        UB_PID_FILE="/tmp/ueberzugpp.pid"
        ueberzugpp layer -o wayland --silent --no-stdin --use-escape-codes --pid-file "$UB_PID_FILE"
      '')
      (pkgs.writeShellScriptBin "start_music" ''
        # pkill ueberzug
        # start_ueberzug
        ncmpcpp
      '')
      inputs.wallust.packages.${pkgs.system}.wallust
    ]
    ++ [
      # Fonts
      fantasque-sans-mono
      jetbrains-mono
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      stix-two
    ];
}
