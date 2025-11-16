{
  pkgs,
  lib,
  inputs,
  ...
}:

{
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    with pkgs;
    [
      adw-gtk3
      alacritty-theme
      alsa-utils
      app2unit
      appimage-run
      aubio
      # awscli2
      bat
      beamPackages.erlang
      beamPackages.elixir
      brightnessctl
      brave
      btop
      bun
      cachix
      cargo-flamegraph
      cargo-lambda
      cargo-nextest
      cargo-show-asm
      # carla
      chromium
      claude-code
      # clang
      cmake
      # deadbeef-with-plugins
      darkly
      darkly-qt5
      ddcutil
      discord
      distant
      dogdns
      dua
      easyeffects
      fastfetch
      fd
      ffmpeg-full
      filezilla
      (lib.meta.hiPrio gcc)
      gdb
      gemini-cli-bin
      ghidra-bin
      ghostscript
      gimp
      glas
      gleam
      # globalprotect-openconnect
      gnumake
      gnutar
      go
      gopls
      gpauth
      gpclient
      grim
      gst_all_1.gstreamer
      gtklock
      hotspot
      hyperfine
      iaito
      imagemagick
      iw
      jalv
      jetbrains-toolbox
      kdePackages.kcachegrind
      kdePackages.massif-visualizer
      kdePackages.okular
      # kdePackages.qt6ct
      kdePackages.qtstyleplugin-kvantum
      kid3
      killall
      leetcode-cli
      leetgo
      lftp
      libev
      libgcc
      libgccjit
      libnotify
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
      libuv
      light
      llvmPackages_20.clang-tools
      llvmPackages_20.clang
      lshw
      lxqt.pavucontrol-qt
      # lxqt.pcmanfm-qt
      man-pages
      marp-cli
      meld
      meson
      mold
      mpc
      mpv
      nil
      ninja
      nix-prefetch
      nix-prefetch-github
      nix-tree
      nixfmt-rfc-style
      nemo
      # networkmanagerapplet
      nmon
      nodejs
      nodePackages.aws-cdk
      nosql-workbench
      obsidian
      omnix
      opam
      openapi-generator-cli
      openssl
      # pcmanfm
      perf
      pipx
      pfetch-rs
      plantuml-c4
      playerctl
      poetry
      poppler-utils
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
      qjackctl
      qt6ct-kde
      radare2
      redis
      rust-bin.stable.latest.complete
      uget
      unar
      ueberzugpp
      unzip
      usbutils
      raft-cowsql
      sassc
      scc
      serverless
      showmethekey
      slurp
      sshfs
      swappy
      sysstat
      terraform
      terraform-local
      themechanger
      tidal-hifi
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
      xmake
      xfce.thunar
      yq-go
      zig
      zip
      zls
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
      (pkgs.catppuccin-papirus-folders.override { accent = "lavender"; })
      (pkgs.catppuccin-gtk.override {
        accents = [
          "lavender"
        ];
        variant = "mocha";
      })
    ]
    ++ [
      # Fonts
      fantasque-sans-mono
      jetbrains-mono
      material-symbols
      nerd-fonts.caskaydia-cove
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      stix-two
    ];
}
