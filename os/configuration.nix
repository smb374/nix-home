# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }: {
  imports = [ ];

  # Enable flakes.
  nix.settings = {
    accept-flake-config = true;
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    trusted-users = [ "root" "poyehchen" ];
  };
  # Allow Unfree
  nixpkgs.config.allowUnfree = true;

  # Settings

  boot.kernelPackages = pkgs.linuxPackages_zen;

  console = { keyMap = "us"; };

  environment.systemPackages = with pkgs; [
    catppuccin-sddm-corners
    curl
    greetd.tuigreet
    qogir-icon-theme
    vim
    wget
  ];

  hardware.opengl.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 8080 ];
    };
    hostName = "smb374-nix";
    networkmanager.enable = true;
  };

  programs = {
    dconf.enable = true;
    fish.enable = true;
    gnupg.agent = {
      enable = true;
      enableBrowserSocket = true;
      enableExtraSocket = true;
      enableSSHSupport = true;
      pinentryFlavor = "curses";
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
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };
  services = {
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    yubikey-agent.enable = true;
  };
  sound.enable = true;

  time.timeZone = "Asia/Taipei";

  users = {
    users.poyehchen = {
      extraGroups = [ "audio" "video" "wheel" ];
      hashedPassword =
        "$y$j9T$YLbNr7cW0qMP8T/0LKDd.1$f81OosH6ml9XqYKa7lAfgViVTybHcj/.dQR2UQTa.v2";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINcjZwi+gFwxNcVnt9i+M+Gyxm0FKGYD3wIn+BEW0pdQ cardno:14_352_902"
      ];
      shell = pkgs.fish;
    };
  };

  system.stateVersion = "23.11";
}

