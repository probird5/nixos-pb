# NVIDIA GPU configuration
{
  config,
  pkgs,
  lib,
  ...
}:

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

  # XDG portals for compositors
  xdg.portal = {
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-wlr
    ];
    config = {
      # Hyprland session: use hyprland portal for screencopy, gtk for file picker
      Hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Screenshot" = "hyprland";
        "org.freedesktop.impl.portal.ScreenCast" = "hyprland";
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
      };
      # MangoWC (wlroots) session: use wlr portal for screencopy, gtk for file picker
      wlroots = {
        default = [
          "wlr"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Screenshot" = "wlr";
        "org.freedesktop.impl.portal.ScreenCast" = "wlr";
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
      };
      # Fallback
      common = {
        default = [ "gtk" ];
      };
    };
  };

  # NVIDIA-specific packages
  environment.systemPackages = with pkgs; [
    egl-wayland
    nvidia-vaapi-driver
    vulkan-loader
    pkgsi686Linux.vulkan-loader
  ];
}
