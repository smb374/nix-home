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
        numdiff
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
        lxgw-wenkai
        lxgw-wenkai-tc
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
      "asdf-vm"
      "bat"
      "blueman"
      "boost"
      "boost-libs"
      "btop"
      "bun-bin"
      "chromium"
      "clang"
      "cmake"
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
      "glibc-debug"
      "globalprotect-openconnect"
      "go"
      "go-yq"
      "gopls"
      "grim"
      "htop"
      "hyperfine"
      "imagemagick"
      "imv"
      "iw"
      "jq"
      "kitty"
      "lf"
      "lftp"
      "libuv"
      "likwid"
      "linux-wifi-hotspot"
      "lshw"
      "ly"
      "mold"
      "mpc"
      "mpv"
      "nemo"
      "neovim"
      "network-manager-applet"
      "ninja"
      "nmon"
      "nodejs"
      "obs-studio"
      "opam"
      "openmp"
      "openmpi"
      "openmpi-docs"
      "openssl"
      "pavucontrol"
      "poppler"
      "perf"
      "playerctl"
      "python-pynvim"
      "raft"
      "ripgrep"
      "rmpc"
      "rqbit"
      "rustup"
      "rye"
      "sagemath"
      "sassc"
      "slurp"
      "sshfs"
      "sysstat"
      "termshark"
      "tidal-hifi-bin"
      "tinymist"
      "tpm2-openssl"
      "tpm2-pkcs11"
      "tpm2-tools"
      "tpm2-totp"
      "tpm2-tss"
      "traceroute"
      "tree"
      "tree-sitter"
      "typst"
      "unarchiver"
      "unzip"
      "usbutils"
      "uwsm"
      "valgrind"
      "wireless_tools"
      "wireshark-qt"
      "wl-clipboard"
      "x264"
      "x265"
      "yazi"
      "zathura"
      "zathura-pdf-mupdf"
      "zathura-ps"
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
