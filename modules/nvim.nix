{ config, pkgs, inputs, ... }:

{

  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
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

      {
        plugin = alpha-nvim;
        config = toLuaFile ./nvim/lua/plugins/alpha.lua;
      }
      {
        plugin = nvim-autopairs;
        config = toLuaFile ./nvim/lua/plugins/autopairs.lua;
      }
      {
        plugin = lualine-nvim;
        config = toLuaFile ./nvim/lua/plugins/lualine.lua;
      }

      {
        plugin = neo-tree-nvim;
        config = toLuaFile ./nvim/lua/plugins/neo-tree.lua;
      }
      {
        plugin = oil-nvim;
        config = toLuaFile ./nvim/lua/plugins/oil.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ./nvim/lua/plugins/telescope.lua;

      }
      {
        plugin = vim-tmux-navigator;
        config = toLuaFile ./nvim/lua/plugins/tmux-navigator.lua;
      }
      {
        plugin = tokyonight-nvim;
        config = toLuaFile ./nvim/lua/plugins/tokyonight.lua;
      }

      neodev-nvim

      nvim-cmp 
      {
        plugin = nvim-cmp;
        config = toLuaFile ./nvim/plugin/cmp.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ./nvim/plugin/telescope.lua;
      }

      telescope-fzf-native-nvim

      cmp_luasnip
      cmp-nvim-lsp

      luasnip
      friendly-snippets


      lualine-nvim
      nvim-web-devicons

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]));
        config = toLuaFile ./nvim/lua/plugins/treesitter.lua;
      }

      vim-nix

      # {
      #   plugin = vimPlugins.own-onedark-nvim;
      #   config = "colorscheme onedark";
      # }
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/lua/vim-options.lua}
    '';

    # extraLuaConfig = ''
    #   ${builtins.readFile ./nvim/options.lua}
    #   ${builtins.readFile ./nvim/plugin/lsp.lua}
    #   ${builtins.readFile ./nvim/plugin/cmp.lua}
    #   ${builtins.readFile ./nvim/plugin/telescope.lua}
    #   ${builtins.readFile ./nvim/plugin/treesitter.lua}
    #   ${builtins.readFile ./nvim/plugin/other.lua}
    # '';
  };

}
