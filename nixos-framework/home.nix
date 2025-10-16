{ config, pkgs, ... }:

{
  ########################
  # Home / Imports
  ########################
  home.username = "probird5";
  home.homeDirectory = "/home/probird5";

  imports = [
    # ./nvim.nix
    ../modules/nvim.nix
  ];

  ########################
  # Shells & CLI
  ########################
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      cd  = "z";
      cdi = "zi";
      cat = "bat";
    };
  };

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

  programs.zoxide.enable = true;

  programs.git = {
    enable = true;
    userName  = "probird5";
    userEmail = "52969604+probird5@users.noreply.github.com";
  };

  programs.starship.enable = true;

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
    platformTheme = "gtk";
  };

  ########################
  # Editors / Config
  ########################

  ########################
  # Homefile Override 
  ########################
  home.file.".config/hypr".source = ../config/hypr;
  home.file.".config/waybar".source = ../config/waybar;
  home.file.".config/alacritty".source = ../config/alacritty;
  home.file.".config/btop".source = ../config/btop;
  home.file.".config/rofi".source = ../config/rofi;
  home.file.".config/ghostty".source = ../config/ghostty;
  home.file.".config/starship".source = ../config/starship;
  home.file.".zshrc".source = ../config/zsh/.zshrc;
  home.file."Pictures/backgrounds".source = ../config/backgrounds;


  ########################
  # XDG Portals & User Dirs
  ########################
  xdg = {
    portal = {
      enable = true;
      config.common.default = "*";
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };
    userDirs.enable = true;
  };

  ########################
  # User Packages
  ########################
  home.packages = with pkgs; [
    # System / Monitoring
    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils
    p7zip
    unzip
    lz4
    jq
    tree
    fastfetch
    ripgrep
    fd
    bat
    btop
    gotop
    wl-clipboard
    wget
    openssl
    pkg-config
    bind

    # Development
    go
    rustup
    golangci-lint
    nil
    nodejs_22
    python3
    clang-tools
    lua
    lua-language-server
    gnumake
    gcc
    neovim

    # Wayland / Desktop
    wayland
    xwayland
    wayland-utils
    wlr-randr
    wdisplays
    nwg-displays
    hyprcursor
    hypridle
    hyprlock
    hyprpaper
    swayidle
    swaylock
    swaycons
    grim
    slurp
    swappy
    wttrbar
    picom
    alacritty
    ghostty
    lf
    trash-cli
    nwg-look
    lxappearance
    brightnessctl
    rofi-wayland
    waybar
    hyprpaper

    # Audio / Bluetooth
    pulsemixer
    pavucontrol
    pamixer

    # Networking / VM
    docker
    spice-gtk
    spice
    ntfs3g
    seatd
    virtiofsd

    # Applications
    firefox
    brave
    obsidian
    vscodium
    spotify
    libreoffice
    _1password-gui
    remmina
    gnomeExtensions.remmina-search-provider
    discord
    mpv
    feh
    shotcut
    swww

    # Gaming
    steam
    lutris
    gamescope
    protonup-qt

    # Fonts / Themes
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
    font-awesome
    nordic

    # Miscellaneous utilities
    xprintidle
    wttrbar
    genymotion
    android-tools
    hashcat
    yazi

    # Low-level (system-level; included per your list)
    linux-firmware
    microcodeAmd

    # Qt / Xorg Libraries
    qt6.qtbase
    qt6.qtwayland
    qt5.qtwayland
    egl-wayland
    xorg.libxcb
    xorg.xcbutil
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm

    # Polkit Agent
    libsForQt5.polkit-kde-agent
  ];

  ########################
  # Home Manager
  ########################
  programs.home-manager.enable = true;

  ########################
  # Compatibility / State
  ########################
  home.stateVersion = "25.05";
}

