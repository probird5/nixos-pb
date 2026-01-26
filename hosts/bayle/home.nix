# Bayle home-manager configuration
{
  config,
  pkgs,
  lib,
  ...
}:

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
  ];

  # Override bashrc
  home.file.".bashrc".source = lib.mkForce ./bashrc;

  # Bayle-specific packages
  home.packages = with pkgs; [
    # Browsers

    # Development extras
    goimports-reviser
    clang-tools
    stylua
    prettier
    luajitPackages.luarocks
    luajitPackages.jsregexp

    # Desktop extras
    swaynotificationcenter
    wlogout
    flameshot

    # Android
    genymotion

    # Gaming
    nordic
  ];

  home.stateVersion = "25.05";
}
