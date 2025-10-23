{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      git
      curl
      wget
      unzip
      gnumake
      gcc
      ripgrep
      clang-tools
      nixd
      vscode-langservers-extracted
      fd
      tree-sitter
      nodejs
      python3
      lua-language-server
      stylua
    ];
  };

  # Writable: ~/.config/nvim → /home/probird5/nixos-pb/config/nvim
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "/home/probird5/nixos-pb/config/nvim";

  # Cleanup old store symlink before linking
  home.activation.nvimFix = lib.hm.dag.entryBefore [ "writeBoundary" ] ''
    if [ -e "$HOME/.config/nvim" ]; then
      target="$(readlink -f "$HOME/.config/nvim" || true)"
      case "$target" in
        /nix/store/*)
          echo "Removing old read-only ~/.config/nvim symlink ($target)"
          rm -f "$HOME/.config/nvim"
          ;;
      esac
    fi
  '';
}

