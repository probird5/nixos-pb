# Messmer - Framework Desktop (AMD)
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/common.nix
    ../../modules/system/desktop.nix
    ../../modules/system/amd.nix
    ../../modules/ollama.nix
  ];

  # Host identity
  networking.hostName = "messmer";

  # Desktop session (select compositor at login via tuigreet)
  desktop = {
    enableNiri = true;
  };

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_6_18;
  boot.kernelParams = [
    "resume=/swapfile"
    "mem_sleep_default=deep"
  ];

  # Swap
  swapDevices = [
    {
      device = "/swapfile";
      size = 64 * 1024;
    }
  ];

  # Services
  services.openssh = {
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

  # Virtualization (Podman instead of Docker)
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

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
      "video"
      "render"
    ];
    packages = with pkgs; [ kdePackages.kate ];
  };

  # Additional packages specific to messmer
  environment.systemPackages = with pkgs; [
    hplipWithPlugin
    openresolv
    xwayland-satellite
    toolbox
  ];

  system.stateVersion = "24.11";
}
