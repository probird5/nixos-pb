# NVIDIA GPU configuration
{ config, pkgs, lib, ... }:

{
  # Video driver
  services.xserver.videoDrivers = [ "nvidia" ];

  # Kernel configuration
  boot = {
    blacklistedKernelModules = [ "nouveau" ];
    initrd.kernelModules = [ "nvidia" ];
    kernelParams = [
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      "acpi.power_nocheck=1"
      "ahci.mobile_lpm_policy=1"
    ];
  };

  # NVIDIA hardware settings
  hardware.nvidia = {
    open = false;
    powerManagement.enable = true;
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  # XDG portals for Hyprland
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    xdg-desktop-portal-hyprland
  ];

  # NVIDIA-specific packages
  environment.systemPackages = with pkgs; [
    egl-wayland
    nvidia-vaapi-driver
    vulkan-loader
    pkgsi686Linux.vulkan-loader
  ];
}
