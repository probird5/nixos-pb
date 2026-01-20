# Development tools and languages
{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Languages
    go
    rustup
    python3
    nodejs_22
    lua

    # Go tools
    golangci-lint

    # Tools
    opencode
    claude-code
    lazydocker
    lazygit

    # Nix
    nil

    # Build tools
    pkg-config
    bind

    # Remote access
    sshfs
    freerdp
    remmina
    gnomeExtensions.remmina-search-provider
  ];
}
