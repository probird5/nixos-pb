{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    # Tools lazy and your plugins commonly need
    extraPackages = with pkgs; [
      git curl wget unzip gnumake gcc
      ripgrep fd tree-sitter
      nodejs python3
      lua-language-server stylua
    ];
  };

  # Point HM at your *writable* repo folder (not the Nix store).
  # This should be a path in your home checkout, e.g., ../shared/nvim
  xdg.configFile."nvim".source =
  lib.file.mkOutOfStoreSymlink "../config/nvim";

  # Optional: after switching, auto-sync plugins headlessly
  home.activation.nvimLazySync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if command -v nvim >/dev/null 2>&1; then
      # Sync once after deploy; comment this out if you prefer manual control
      nvim --headless "+Lazy! sync" +qa || true
    fi
  '';
}

