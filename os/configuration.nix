# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Enable flakes.
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "poyehchen" ];
  };
  # Allow Unfree
  nixpkgs.config.allowUnfree = true;

  # Settings

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
    kernelPackages = pkgs.linuxPackages_zen;
  };

  console = {
    keyMap = "us";
  };

  environment.systemPackages = with pkgs; [
    catppuccin-sddm-corners
    curl
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
    # hyprland = {
    #   enable = true;
    #   xwayland.enable = true;
    # };
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
    # xserver = {
    #   enable = true;
    #   displayManager = {
    #     sddm = {
    #       enable = true;
    #       settings = {
    #         Theme.CursorTheme = "Qogir-dark";
    #       };
    #     };
    #   };
    # };
    yubikey-agent.enable = true;
  };
  sound.enable = true;

  time.timeZone = "Asia/Taipei";

  users = {
    users.poyehchen = {
      extraGroups = [ "audio" "video" "wheel" ];
      hashedPassword = "$y$j9T$YLbNr7cW0qMP8T/0LKDd.1$f81OosH6ml9XqYKa7lAfgViVTybHcj/.dQR2UQTa.v2";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINcjZwi+gFwxNcVnt9i+M+Gyxm0FKGYD3wIn+BEW0pdQ cardno:14_352_902"
      ];
      shell = pkgs.fish;
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}

