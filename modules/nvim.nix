{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      # Core utilities
      git
      curl
      wget
      unzip
      gnumake
      gcc
      ripgrep
      fd
      tree-sitter
      nodejs
      python3

      # LSP servers
      lua-language-server        # Lua
      clang-tools                # C/C++ (clangd)
      nixd                       # Nix
      vscode-langservers-extracted # HTML/CSS/JSON/ESLint
      gopls                      # Go
      pyright                    # Python
      bash-language-server       # Bash
      yaml-language-server       # YAML
      rust-analyzer              # Rust
      typescript-language-server # JavaScript/TypeScript
      marksman                   # Markdown

      # Formatters and linters
      stylua                     # Lua formatter
      gofumpt                    # Go formatter
      gotools                    # goimports
      golangci-lint              # Go linter
      ruff                       # Python linter/formatter
      shfmt                      # Bash formatter
      shellcheck                 # Bash linter
      rustfmt                    # Rust formatter
      prettierd                  # Fast prettier daemon
      nodePackages.prettier      # JS/TS/JSON/YAML/MD formatter
      nixfmt-rfc-style           # Nix formatter
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

