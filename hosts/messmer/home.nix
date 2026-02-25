# Messmer home-manager configuration
{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home/common.nix
    ../../modules/home/theming.nix
    ../../modules/home/desktop.nix
    ../../modules/home/development.nix
    ../../modules/home/packages.nix
    ../../modules/nvim.nix
    ../../modules/ghostty.nix
    ../../modules/tmux.nix
    ../../modules/eza.nix
    ../../modules/firefox.nix
  ];

  # Messmer-specific: btop config file instead of module
  home.file.".config/btop".source = ../../config/btop;

  # XDG portal config
  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };

  # Messmer-specific packages
  home.packages = with pkgs; [
    # Niri desktop
    niri

    # Theming
    nordic
  ];

  home.stateVersion = "25.05";
}
