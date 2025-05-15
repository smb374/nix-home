{
  config,
  lib,
  pkgs,
  ...
}:

let
  paru-hm-state = (
    pkgs.writeScriptBin "paru-hm-state" ''
      #!/bin/bash
      PACKAGES="$@"
      touch ~/.local/state/paru-state
      echo $PACKAGES | tr " " "\n" | sort > ~/.local/state/paru-state.new
      diff -u ~/.local/state/paru-state ~/.local/state/paru-state.new > ~/.local/state/paru-state.diff
      INSTALL=$(grep -P "^\+\w+" ~/.local/state/paru-state.diff | tr -d '+' | tr '\n' ' ')
      REMOVE=$(grep -P "^-\w+" ~/.local/state/paru-state.diff | tr -d '-' | tr '\n' ' ')
      [[ -n "$INSTALL" ]] && /sbin/sudo -u poyehchen -- paru -Sy --noconfirm --needed $INSTALL
      [[ -n "$REMOVE" ]] && /sbin/sudo -u poyehchen -- paru -Rs --noconfirm $REMOVE
      mv ~/.local/state/paru-state.new ~/.local/state/paru-state
      rm ~/.local/state/paru-state.diff
    ''
  );
in
{
  options.arch-packages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
  };

  config = {
    home.packages =
      with pkgs;
      [
        paru-hm-state
        # Packages
        cachix
        deadbeef-with-plugins
        discord
        distant
        filezilla
        gst_all_1.gstreamer
        hotspot
        jetbrains-toolbox
        kdePackages.kcachegrind
        kdePackages.massif-visualizer
        kdePackages.okular
        kdePackages.qt6ct
        kdePackages.qtstyleplugin-kvantum
        leetcode-cli
        leetgo
        libsForQt5.qt5ct
        libsForQt5.qtstyleplugin-kvantum
        man-pages
        marp-cli
        meld
        nil
        nix-prefetch
        nix-prefetch-github
        nixfmt-rfc-style
        obsidian
        pipx
        pfetch-rs
        plantuml-c4
        poetry
        postman
        showmethekey
        terraform
        terraform-local
        trash-cli
        typescript-language-server
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
        # Maple Mono (Ligature Variable)
        maple-mono.variable
        # Maple Mono (Ligature TTF hinted)
        maple-mono.truetype-autohint
        # Maple Mono NF (Ligature hinted)
        maple-mono.NF
        # Maple Mono NF CN (Ligature hinted)
        maple-mono.NF-CN
      ];

    arch-packages = [
      "bat"
      "btop"
      "bun-bin"
      "chromium"
      "clang"
      "dog"
      "dua-cli"
      "fastfetch"
      "fd"
      "ffmpeg"
      "freedownloadmanager"
      "gcc"
      "gdb"
      "ghidra"
      "ghostscript"
      "gimp"
      "globalprotect-openconnect"
      "go"
      "go-yq"
      "gopls"
      "grim"
      "htop"
      "hyperfine"
      "imagemagick"
      "iw"
      "kitty"
      "lftp"
      "libuv"
      "lshw"
      "mold"
      "mpc"
      "mpv"
      "nemo"
      "neovim"
      "network-manager-applet"
      "nmon"
      "nodejs"
      "opam"
      "openssl"
      "pavucontrol"
      "poppler"
      "perf"
      "playerctl"
      "python-pynvim"
      "raft"
      "rqbit"
      "rye"
      "sassc"
      "slurp"
      "sshfs"
      "sysstat"
      "termshark"
      "tinymist"
      "traceroute"
      "tree"
      "tree-sitter"
      "typst"
      "unarchiver"
      "unzip"
      "usbutils"
      "valgrind"
      "wireless_tools"
      "wireshark-qt"
      "wl-clipboard"
      "x264"
      "x265"
      "zen-browser-bin"
      "zig"
      "zip"
      "zoxide"
    ];

    home.activation = {
      installArchPackages = lib.hm.dag.entryAfter [ "installPackages" ] ''
        run ${paru-hm-state}/bin/paru-hm-state '${lib.concatStringsSep " " config.arch-packages}'
      '';
    };
  };
}
