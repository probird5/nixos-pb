# Theming configuration (GTK, Qt, cursors, icons)
{ config, pkgs, lib, ... }:

{
  # X resources (DPI, cursor)
  xresources.properties = {
    "Xcursor.size" = 24;
    "Xft.dpi" = 120;
    "Xcursor.theme" = "Nordzy-cursors";
  };

  # GTK theming
  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Nordzy";
      package = pkgs.nordzy-icon-theme;
    };
    cursorTheme = {
      name = "Nordzy-cursors";
      package = pkgs.nordzy-cursor-theme;
      size = 32;
    };
    gtk2.configLocation = "${config.home.homeDirectory}/.gtkrc-2.0";
  };

  # Qt theming
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  # dconf settings for Niri/GNOME apps
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Dracula";
      icon-theme = "Nordzy";
    };
  };

  # Font packages
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    font-awesome
    inter
  ];
}
