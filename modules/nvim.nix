{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true; vimAlias = true; defaultEditor = true;
    extraPackages = with pkgs; [
      git curl wget unzip gnumake gcc ripgrep fd tree-sitter
      nodejs python3 
      lua-language-server 
      stylua
    ];
  };

  # Ensure ~/.config/nvim → /home/probird5/nixos-pb/config/nvim (writable)
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "/home/probird5/nixos-pb/config/nvim";

  # Remove any old /nix/store symlink first (prevents the “file exists” mess)
  home.activation.nvimFix = lib.hm.dag.entryBefore [ "writeBoundary" ] ''
    if [ -e "$HOME/.config/nvim" ]; then
      target="$(readlink -f "$HOME/.config/nvim" || true)"
      case "$target" in /nix/store/*) rm -f "$HOME/.config/nvim" ;; esac
    fi
  '';
}

