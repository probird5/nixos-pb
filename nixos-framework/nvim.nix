{ config, pkgs, inputs, ... }:

{
  programs.neovim = let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      xclip
      wl-clipboard
    ];

     plugins = with pkgs.vimPlugins; [
      telescope-fzf-native-nvim
      luasnip
      friendly-snippets
      telescope-nvim
      lualine-nvim
      nvim-web-devicons
      tokyonight-nvim
      alpha-nvim
      vim-startify
      mason-lspconfig-nvim
      mason-nvim
      nvim-cmp
      nvim-lspconfig
      cmp-nvim-lsp
      none-ls-nvim
      neodev-nvim
      lua-language-server
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]));
        config = toLuaFile ./nvim/treesitter.lua;
      }

    ];   
    extraLuaConfig = ''
      ${builtins.readFile ./nvim/vim-options.lua}
      ${builtins.readFile ./nvim/telescope.lua}
      ${builtins.readFile ./nvim/tokyonight.lua}
      ${builtins.readFile ./nvim/alpha.lua}
      ${builtins.readFile ./nvim/cmp.lua}
      ${builtins.readFile ./nvim/lsp.lua}
    '';
  };
}

