{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  # TODO please change the username & home directory to your own
  home.username = "probird5";
  home.homeDirectory = "/home/probird5";


  imports = [
    # Include the results of the hardware scan.
    ../../modules/nvim.nix
    ../../modules/ghostty.nix
    ../../modules/tmux.nix
  ];

  wayland.windowManager.hyprland.xwayland.enable = true;


  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    historyWidgetOptions = [
      "--height"
      "40%"
      "--layout=reverse"
      "--border"
    ];
  };


  home.file.".bashrc".source = lib.mkForce ./bashrc;

  services.swww.enable = true;
  programs.zoxide.enable = true;
  programs.starship.enable = true;


  programs.git = {
    enable = true;
    userName = "probird5";
    userEmail = "52969604+probird5@users.noreply.github.com";
  };

  ########################
  # Hyprland helpers
  ########################
  programs.hyprlock.enable = true;

  ########################
  # Theming / Fonts / DPI
  ########################
  xresources.properties = {
    "Xcursor.size" = 24;
    "Xft.dpi"      = 120;
    "Xcursor.theme" = "Nordzy-cursors";
  };

  gtk = {
    enable = true;
    theme = {
      name    = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name    = "Nordzy";
      package = pkgs.nordzy-icon-theme;
    };
    cursorTheme = {
      name    = "Nordzy-cursors";
      package = pkgs.nordzy-cursor-theme;
      size    = 32;
    };
    gtk2.configLocation = "${config.home.homeDirectory}/.gtkrc-2.0";
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

# added this for niri since theming didn't work
    dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Dracula";
      icon-theme = "Nordzy";
    };
  };
  ########################
  # Homefile Override 
  ########################
  home.file.".config/hypr".source = ../../config/hypr;
  home.file.".config/waybar".source = ../../config/waybar;
  home.file.".config/alacritty".source = ../../config/alacritty;
  home.file.".config/btop".source = ../../config/btop;
  home.file.".config/rofi".source = ../../config/rofi;
  home.file.".config/starship".source = ../../config/starship;
  home.file.".config/niri".source = ../../config/niri;
  home.file.".zshrc".source = ../../config/zsh/.zshrc;
  home.file."Pictures/backgrounds".source = ../../config/backgrounds;

  # Packages that should be installed to the user profile.
home.packages = with pkgs; [

  # System / Hardware
  sysstat
  lm_sensors
  ethtool
  pciutils
  usbutils
  alsa-utils
  killall
  openssl

  # Archives / Compression
  p7zip
  unzip
  lz4

  # CLI utilities
  fd
  fzf
  ripgrep
  jq
  tree
  fastfetch
  bat
  zoxide
  trash-cli
  bash-completion
  wttrbar

  # Shell / Terminal
  tmux
  starship
  lf
  yazi
  xprintidle

  # Development
  go
  golangci-lint
  goimports-reviser
  rustup
  clang-tools
  python3
  nodejs_22
  lua
  stylua
  prettier
  luajitPackages.luarocks
  luajitPackages.jsregexp

  # Wayland / Desktop
  wdisplays
  swww
  picom
  nwg-look
  hyprcursor
  hypridle
  swayidle
  swaylock
  swaynotificationcenter
  wlogout
  swappy
  flameshot

  # Fonts / Icons
  font-awesome
  nerd-fonts.fira-code
  nerd-fonts.fira-mono
  nerd-fonts.jetbrains-mono
  nerd-fonts.symbols-only

  # Audio / Music
  pulsemixer
  spotify

  # Browsers
  firefox
  librewolf

  # Applications
  obsidian
  shotcut
  libreoffice

  # Remote / Networking
  remmina
  freerdp
  sshfs
  gnomeExtensions.remmina-search-provider

  # Gaming
  steam
  steam-run
  lutris
  protonup-qt

  # Security / Reversing
  hashcat

  # Android
  android-tools
  genymotion

  # Qt / X11 support
  qt6.qtbase
  qt6.qtwayland
  xorg.libxcb
  xorg.xcbutil
  xorg.xcbutilimage
  xorg.xcbutilkeysyms
  xorg.xcbutilrenderutil
  xorg.xcbutilwm
];


    xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "application/pdf" = "firefox.desktop"; # or "firefox.desktop"
      "text/plain" = "nvim.desktop";
      "text/markdown" = "nvim.desktop";
      "application/json" = "nvim.desktop";
      "application/xml" = "nvim.desktop";
      "image/png" = "feh.desktop";   # or "feh.desktop"
      "image/jpeg" = "feh.desktop";
      "image/webp" = "feh.desktop";
      "image/gif" = "feh.desktop";
      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";  # .mkv
      "video/webm" = "mpv.desktop";
      "audio/mpeg" = "mpv.desktop";        # .mp3
      "audio/flac" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";
      "application/zip" = "xarchiver.desktop";
      "application/x-tar" = "xarchiver.desktop";
      "application/x-7z-compressed" = "xarchiver.desktop";
      "application/x-rar" = "xarchiver.desktop";
    };
  };


  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
