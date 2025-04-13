# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }:

{
  imports = [ ];
  # Enable flakes.
  nix.package = pkgs.lix;
  nix.settings = {
    accept-flake-config = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    trusted-users = [
      "root"
      "poyehchen"
    ];
  };
  # Allow Unfree
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     dmraid = prev.dmraid.overrideAttrs (oA: {
  #       patches = oA.patches ++ [
  #         (prev.fetchpatch2 {
  #           url = "https://raw.githubusercontent.com/NixOS/nixpkgs/f298cd74e67a841289fd0f10ef4ee85cfbbc4133/pkgs/os-specific/linux/dmraid/fix-dmevent_tool.patch";
  #           hash = "sha256-MmAzpdM3UNRdOk66CnBxVGgbJTzJK43E8EVBfuCFppc=";
  #         })
  #       ];
  #     });
  #   })
  # ];

  # Settings

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=0
  '';

  console = {
    keyMap = "us";
  };

  environment.systemPackages =
    with pkgs;
    [
      curl
      docker-compose
      fd
      file
      gcc
      git
      glib
      gnutar
      pciutils
      # qemu_full
      qemu
      qemu_kvm
      qemu-utils
      qemu-user
      qogir-icon-theme
      traceroute
      unzip
      usbutils
      vim
      wget
      yubikey-personalization
    ]
    ++ [ dmraid ];
  environment.variables = {
    MPD_HOST = "127.0.0.1";
  };
  services.udev.packages = with pkgs; [
    yubikey-personalization
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      lxgw-wenkai-tc
      # Maple Mono (Ligature Variable)
      maple-mono.variable
      # Maple Mono (Ligature TTF hinted)
      maple-mono.truetype-autohint
      # Maple Mono (Ligature TTF unhinted)
      maple-mono.truetype
      # Maple Mono (Ligature OTF)
      maple-mono.opentype
      # Maple Mono (Ligature WOFF2)
      maple-mono.woff2
      # Maple Mono NF (Ligature hinted)
      maple-mono.NF
      # Maple Mono NF (Ligature unhinted)
      maple-mono.NF-unhinted
      # Maple Mono CN (Ligature hinted)
      maple-mono.CN
      # Maple Mono CN (Ligature unhinted)
      maple-mono.CN-unhinted
      # Maple Mono NF CN (Ligature hinted)
      maple-mono.NF-CN
      # Maple Mono NF CN (Ligature unhinted)
      maple-mono.NF-CN-unhinted

      # Maple Mono (No-Ligature Variable)
      maple-mono.NL-Variable
      # Maple Mono (No-Ligature TTF hinted)
      maple-mono.NL-TTF-AutoHint
      # Maple Mono (No-Ligature TTF unhinted)
      maple-mono.NL-TTF
      # Maple Mono (No-Ligature OTF)
      maple-mono.NL-OTF
      # Maple Mono (No-Ligature WOFF2)
      maple-mono.NL-Woff2
      # Maple Mono NF (No-Ligature hinted)
      maple-mono.NL-NF
      # Maple Mono NF (No-Ligature unhinted)
      maple-mono.NL-NF-unhinted
      # Maple Mono CN (No-Ligature hinted)
      maple-mono.NL-CN
      # Maple Mono CN (No-Ligature unhinted)
      maple-mono.NL-CN-unhinted
      # Maple Mono NF CN (No-Ligature hinted)
      maple-mono.NL-NF-CN
      # Maple Mono NF CN (No-Ligature unhinted)
      maple-mono.NL-NF-CN-unhinted

      # Maple Mono Normal (Ligature Variable)
      maple-mono.Normal-Variable
      # Maple Mono Normal (Ligature TTF hinted)
      maple-mono.Normal-TTF-AutoHint
      # Maple Mono Normal (Ligature TTF unhinted)
      maple-mono.Normal-TTF
      # Maple Mono Normal (Ligature OTF)
      maple-mono.Normal-OTF
      # Maple Mono Normal (Ligature WOFF2)
      maple-mono.Normal-Woff2
      # Maple Mono Normal NF (Ligature hinted)
      maple-mono.Normal-NF
      # Maple Mono Normal NF (Ligature unhinted)
      maple-mono.Normal-NF-unhinted
      # Maple Mono Normal CN (Ligature hinted)
      maple-mono.Normal-CN
      # Maple Mono Normal CN (Ligature unhinted)
      maple-mono.Normal-CN-unhinted
      # Maple Mono Normal NF CN (Ligature hinted)
      maple-mono.Normal-NF-CN
      # Maple Mono Normal NF CN (Ligature unhinted)
      maple-mono.Normal-NF-CN-unhinted

      # Maple Mono Normal (No-Ligature Variable)
      maple-mono.NormalNL-Variable
      # Maple Mono Normal (No-Ligature TTF hinted)
      maple-mono.NormalNL-TTF-AutoHint
      # Maple Mono Normal (No-Ligature TTF unhinted)
      maple-mono.NormalNL-TTF
      # Maple Mono Normal (No-Ligature OTF)
      maple-mono.NormalNL-OTF
      # Maple Mono Normal (No-Ligature WOFF2)
      maple-mono.NormalNL-Woff2
      # Maple Mono Normal NF (No-Ligature hinted)
      maple-mono.NormalNL-NF
      # Maple Mono Normal NF (No-Ligature unhinted)
      maple-mono.NormalNL-NF-unhinted
      # Maple Mono Normal CN (No-Ligature hinted)
      maple-mono.NormalNL-CN
      # Maple Mono Normal CN (No-Ligature unhinted)
      maple-mono.NormalNL-CN-unhinted
      # Maple Mono Normal NF CN (No-Ligature hinted)
      maple-mono.NormalNL-NF-CN
      # Maple Mono Normal NF CN (No-Ligature unhinted)
      maple-mono.NormalNL-NF-CN-unhinted
    ];
    fontconfig.defaultFonts = {
      serif = [
        "Noto Serif CJK TC"
        "Noto Serif"
      ];
      sansSerif = [
        "Noto Sans CJK TC"
        "Noto Sans"
      ];
    };
  };

  hardware.graphics.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [
        22
        80
        443
      ];
      allowedTCPPortRanges = [
        {
          from = 1024;
          to = 65535;
        }
      ];
    };
    hostName = "smb374-nix";
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
  };

  programs = {
    appimage = {
      enable = true;
      binfmt = true;
    };
    dconf.enable = true;
    fish.enable = true;
    gnupg.agent = {
      enable = true;
      enableBrowserSocket = true;
      enableExtraSocket = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
    htop.enable = true;
    mtr.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        acl
        alsa-lib
        at-spi2-atk
        at-spi2-core
        atk
        attr
        bzip2
        cairo
        cups
        curl
        dbus
        expat
        fontconfig
        freetype
        fuse
        fuse3
        gdk-pixbuf
        glib
        gtk3
        icu
        libGL
        libappindicator-gtk3
        libdrm
        libglvnd
        libnotify
        libpulseaudio
        libsodium
        libssh
        libunwind
        libusb1
        libuuid
        libxkbcommon
        libxml2
        mesa
        nspr
        nss
        openssl
        pango
        pipewire
        stdenv.cc.cc
        systemd
        util-linux
        vulkan-loader
        xz
        zlib
      ];
    };
    uwsm.enable = true;
    virt-manager.enable = true;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.loginLimits = [
      {
        domain = "@users";
        item = "rtprio";
        type = "-";
        value = 1;
      }
    ];
  };
  services = {
    gvfs.enable = true;
    openssh.enable = true;
    # open-webui = {
    #   enable = true;
    #   port = 3000;
    #   openFirewall = true;
    # };
    mympd = {
      enable = true;
      settings = {
        http_host = "0.0.0.0";
        http_port = 6680;
      };
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
      wireplumber = {
        enable = true;
        extraConfig.pipewire = {
          "context.properties" = {
            "default.clock.rate" = 192000;
            "default.clock.allowed-rates" = [
              44100
              48000
              88200
              96000
              176400
              192000
              352800
              384000
              705600
              768000
            ];
          };
        };
        extraConfig.bluetoothEnhancements = {
          "monitor.bluez.properties" = {
            "bluez5.enable-sbc-xq" = true;
            "bluez5.enable-msbc" = true;
            "bluez5.enable-hw-volume" = true;
            "bluez5.codecs" = [
              "sbc"
              "sbc_xq"
              "aac"
              "ldac"
              "aptx"
              "aptx_hd"
              "aptx_ll"
              "aptx_ll_duplex"
            ];
            "bluez5.roles" = [
              "a2dp_sink"
              "a2dp_source"
              "bap_sink"
              "bap_source"
              "hsp_hs"
              "hsp_ag"
              "hfp_hf"
              "hfp_ag"
            ];
          };
        };
      };
    };
    samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "workgroup" = "MYDESKTOP";
          "server string" = "smb374-nix";
          "netbios name" = "smb374-nix";
          "security" = "user";
          "guest account" = "nobody";
          "map to guest" = "bad user";
          "server min protocol" = "SMB2_02";
          "server smb encrypt" = "desired";
        };
        "myvideo" = {
          "path" = "/home/poyehchen/Videos";
          "public" = "no";
          "valid users" = "poyehchen";
          "writable" = "yes";
        };
      };
    };
    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
    tailscale.enable = true;
    udisks2.enable = true;
    yubikey-agent.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  users = {
    users.poyehchen = {
      extraGroups = [
        "audio"
        "libvirtd"
        "video"
        "wheel"
        "docker"
        "networkmanager"
      ];
      hashedPassword = "$y$j9T$YLbNr7cW0qMP8T/0LKDd.1$f81OosH6ml9XqYKa7lAfgViVTybHcj/.dQR2UQTa.v2";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINcjZwi+gFwxNcVnt9i+M+Gyxm0FKGYD3wIn+BEW0pdQ cardno:14_352_902"
      ];
      shell = pkgs.fish;
    };
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=5s
  '';

  system.stateVersion = "24.05";
}
