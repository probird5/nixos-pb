{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      git curl wget unzip gnumake gcc
      ripgrep fd tree-sitter
      nodejs python3
      lua-language-server stylua
    ];
  };

  # Make ~/.config/nvim a *writable* out-of-store symlink
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "~/.config/nvim";

  # Optional one-time cleanup if ~/.config/nvim pointed into /nix/store before
  home.activation.nvimFixReadonly = lib.hm.dag.entryBefore [ "writeBoundary" ] ''
    if [ -L "$HOME/.config/nvim" ]; then
      target="$(readlink -f "$HOME/.config/nvim" || true)"
      case "$target" in
        /nix/store/*) rm -f "$HOME/.config/nvim" ;;
      esac
    fi
  '';

  # Optional: auto-sync plugins after switch
  home.activation.nvimLazySync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if command -v nvim >/dev/null 2>&1; then
      nvim --headless "+Lazy! sync" +qa || true
    fi
  '';
}

