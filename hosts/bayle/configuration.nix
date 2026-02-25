# Bayle - Custom Desktop PC (NVIDIA)
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/common.nix
    ../../modules/system/desktop.nix
    ../../modules/system/nvidia.nix
  ];

  # Host identity
  networking.hostName = "bayle";

  # Desktop session (select compositor at login via tuigreet)
  desktop = {
    enableHyprland = true;
    enableMango = true;
  };

  # Networking
  networking.nameservers = [
    "100.100.100.100"
    "1.1.1.1"
  ];
  networking.search = [ "tail339015.ts.net" ];
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Swap
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 64 * 1024;
    }
  ];

  # nix-ld for running unpatched binaries
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      openssl
      curl
      libgcc
      icu
    ];
  };

  # Services
  services = {
    tailscale.enable = true;
    blueman.enable = true;

    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = [ "probird5" ];
        UseDns = true;
        X11Forwarding = true;
        PermitRootLogin = "no";
      };
    };

    emacs = {
      enable = true;
      package = pkgs.emacs;
    };

    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", TEST=="power/wakeup", ATTR{power/wakeup}="disabled"
    '';
  };

  # Virtualization
  virtualisation.docker.enable = true;

  # User configuration
  users.users.probird5 = {
    isNormalUser = true;
    description = "probird5";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "audio"
      "wheel"
      "libvirtd"
      "kvm"
      "qemu"
      "flatpak"
      "docker"
    ];
  };

  # Additional packages specific to bayle
  environment.systemPackages = with pkgs; [
    # Terminals
    kitty

    # Media
    ffmpeg_7
    imagemagick
    libheif

    # Dev tools
    gcc
    gnumake
    cmake
    libtool
    nixfmt-rfc-style
    wineWowPackages.full

    # Misc
    gotop
    neofetch
    syncthing
    appimage-run
    via

    # X11 extras
    xorg.xorgserver
    xorg.xauth
    xorg.xinit
    xorg.libX11
    xorg.libX11.dev
    xorg.libxcb
    xorg.libXft
    xorg.libXinerama
    xorg.xinput
    xss-lock
    pmutils
    polkit
    seatd
    dmenu
    slstatus
    feh
  ];

  system.stateVersion = "25.05";
}
