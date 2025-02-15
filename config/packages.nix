{ pkgs, inputs, ... }:

{
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    with pkgs;
    [
      alacritty-theme
      # awscli2
      bat
      brightnessctl
      brave
      btop
      bun
      cachix
      cargo-flamegraph
      cargo-lambda
      cargo-nextest
      cargo-show-asm
      chromium
      # clang
      clang-tools
      discord
      dogdns
      dua
      fastfetch
      fd
      ffmpeg-full
      filezilla
      floorp
      gcc
      gdb
      ghidra-bin
      ghostscript
      gimp
      gnumake
      gnutar
      go
      gopls
      grim
      gtklock
      hotspot
      hyperfine
      iaito
      imagemagick
      iw
      kdePackages.kcachegrind
      kdePackages.massif-visualizer
      kdePackages.okular
      kdePackages.qt6ct
      kdePackages.qtstyleplugin-kvantum
      killall
      leetcode-cli
      leetgo
      lftp
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
      light
      linuxKernel.packages.linux_zen.perf
      lxqt.pavucontrol-qt
      # lxqt.pcmanfm-qt
      man-pages
      marp-cli
      meld
      mold
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
      nodePackages.aws-cdk
      nosql-workbench
      obsidian
      openapi-generator-cli
      openssl
      # pcmanfm
      pipx
      pfetch-rs
      plantuml-c4
      playerctl
      poetry
      poppler_utils
      postman
      (python3.withPackages (pp: [
        pp.numpy
        pp.pandas
        pp.pip
        pp.polars
        pp.pwntools
        pp.scipy
      ]))
      qbittorrent
      radare2
      rust-bin.stable.latest.complete
      unar
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
      terraform
      terraform-local
      tinymist
      trash-cli
      tree
      tree-sitter
      typescript-language-server
      typst
      valgrind
      wayshot
      wirelesstools
      wireshark
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
