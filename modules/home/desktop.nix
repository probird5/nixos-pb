# Desktop configuration files and MIME applications
{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Hyprland helpers
  programs.hyprlock.enable = true;
  wayland.windowManager.hyprland.xwayland.enable = true;

  # Config file sources
  home.file = {
    ".config/hypr".source = ../../config/hypr;
    ".config/waybar".source = ../../config/waybar;
    ".config/alacritty".source = ../../config/alacritty;
    ".config/rofi".source = ../../config/rofi;
    ".config/starship".source = ../../config/starship;
    ".config/niri".source = ../../config/niri;
    ".config/fastfetch".source = ../../config/fastfetch;
    ".zshrc".source = ../../config/zsh/.zshrc;
    "Pictures/backgrounds".source = ../../config/backgrounds;
  };

  # MIME application defaults
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Web
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "application/pdf" = "firefox.desktop";

      # Text/Code
      "text/plain" = "nvim.desktop";
      "text/markdown" = "nvim.desktop";
      "application/json" = "nvim.desktop";
      "application/xml" = "nvim.desktop";

      # Images
      "image/png" = "feh.desktop";
      "image/jpeg" = "feh.desktop";
      "image/webp" = "feh.desktop";
      "image/gif" = "feh.desktop";

      # Video
      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/webm" = "mpv.desktop";

      # Audio
      "audio/mpeg" = "mpv.desktop";
      "audio/flac" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";

      # Archives
      "application/zip" = "xarchiver.desktop";
      "application/x-tar" = "xarchiver.desktop";
      "application/x-7z-compressed" = "xarchiver.desktop";
      "application/x-rar" = "xarchiver.desktop";
    };
  };

  # Desktop packages
  home.packages = with pkgs; [
    # Wayland tools
    wayland
    xwayland
    wayland-utils
    wlr-randr
    wdisplays
    nwg-displays
    nwg-look
    lxappearance

    # Hyprland ecosystem
    hyprcursor
    hypridle
    hyprlock
    hyprpaper
    swayidle
    swaylock
    swaycons
    swww

    # Screenshots
    grim
    slurp
    swappy

    # Terminals
    alacritty
    ghostty

    # Desktop apps
    rofi
    waybar
    swaynotificationcenter
    picom
    brightnessctl
    xprintidle
    wttrbar
    xarchiver
    syspower

    # Media
    mpv
    feh
    shotcut

    # Audio/Bluetooth
    pulsemixer
    bluez
    blueman
    pavucontrol
    pamixer

    # File management
    xfce4-exo
    thunar-archive-plugin

    # Polkit
    kdePackages.polkit-kde-agent-1
  ];
}
