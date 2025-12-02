{ config, lib, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
        theme = "TokyoNight Night";
        background-opacity = 0.85;
        cursor-style = "block";
      };
  };
}

