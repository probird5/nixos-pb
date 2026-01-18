# Framework home-manager configuration
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
    ../../modules/btop.nix
    ../../modules/opencode.nix
  ];

  # Framework-specific packages
  home.packages = with pkgs; [
    # AI/Dev tools
    opencode
    claude-code
    lazydocker
    lazygit

    # Gaming
    bottles
    niri

    # Desktop
    xwayland-satellite
    libnotify

    # Theming
    nordic
  ];

  home.stateVersion = "25.05";
}
