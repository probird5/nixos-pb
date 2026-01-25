# Framework 13 (7040 AMD)
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/common.nix
    ../../modules/system/desktop.nix
    ../../modules/system/amd.nix
    ./tailscale.nix
  ];

  # Host identity
  networking = {
    hostName = "nixos-framework";
    nameservers = [
      "192.168.5.18"
      "192.168.0.1"
    ];
  };

  # Desktop session (both compositors available)
  desktop = {
    sessionCommand = "start-hyprland";
    enableHyprland = true;
    enableNiri = true;
  };

  # Kernel
  boot.kernelParams = [ "resume=/swapfile" ];

  # Swap
  swapDevices = [
    {
      device = "/swapfile";
      size = 64 * 1024;
    }
  ];

  # Framework-specific hardware
  hardware.framework.amd-7040.preventWakeOnAC = true;

  # nix-ld for running unpatched binaries
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      libglvnd
      libdrm
      xorg.libX11
      xorg.libXext
      xorg.libXrandr
      xorg.libXrender
      xorg.libXcursor
      xorg.libXi
      xorg.libXxf86vm
      xorg.libXinerama
      libxkbcommon
      wayland
      freetype
      fontconfig
      zlib
      openssl
      curl
      alsa-lib
      pulseaudio
    ];
  };

  # Printing
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  # Fingerprint authentication
  services.fprintd.enable = true;
  security.pam.services.hyprlock.fprintAuth = true;
  security.pam.services.login.fprintAuth = true;
  security.pam.services.sudo.fprintAuth = true;

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
    packages = with pkgs; [ kdePackages.kate ];
  };

  # Additional packages specific to framework
  environment.systemPackages = with pkgs; [
    hplipWithPlugin
    openresolv
    ffmpeg
    xwayland-satellite
  ];

  system.stateVersion = "24.11";
}
