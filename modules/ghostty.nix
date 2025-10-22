{ config, lib, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
        #theme = "tokyonight_night";
      };
  };
}

