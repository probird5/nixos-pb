
{pkgs, lib, ...}:

{
vim = {
lsp.enable = true;
theme = {
  enable = true;
  name = "tokyonight";
  style = "night";

 };

 statusline.lualine.enable = true;
 telescope.enable = true;
 autocomplete.nvim-cmp.enable = true;
  languages = {
    enableTreesitter = true;
    nix.enable = true;
    rust.enable = true;
    };
 };
 }
