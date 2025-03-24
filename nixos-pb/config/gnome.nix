{ config, lib, pkgs, modulesPath, ... }:

{
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
  };
}
