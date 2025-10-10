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
    ./config/starship.nix
    ./config/rofi.nix
  ];

  # firefox crashing on wayland
  #   home.sessionVariables = {
  #    GBM_BACKEND = "";
  #  };
  wayland.windowManager.hyprland.xwayland.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      cd = "z";
      cdi = "zi";
      cat = "bat";
    };
  };

  home.sessionVariables = {
    PATH = "${config.home.homeDirectory}/.config/emacs/bin:${config.home.homeDirectory}/scripts:$PATH";
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "librewolf";
    TERMINAL = "alacritty";
    FILEMANAGER = "thunar";
  };

  home.file.".bashrc".source = lib.mkForce ./bashrc;

  xdg.configFile.nvim.source = ../shared/nvim;

  programs.zoxide.enable = true;

  # Additional Zsh configuration
  programs.hyprlock.enable = true;

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 24;
    "Xft.dpi" = 120;
    "Xcursor.theme" = "Nordzy-cursors";
  };

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
    gtk2 = {
      configLocation = "${config.home.homeDirectory}/.gtkrc-2.0";
    };
  };
  qt.enable = true;

  # platform theme "gtk" or "gnome"
  qt.platformTheme = "gtk";

  # fzf

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

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    p7zip
    steam
    lutris
    remmina
    gnomeExtensions.remmina-search-provider
    tmux
    xprintidle
    fzf
    go
    unzip
    stylua
    lua
    luajitPackages.luarocks
    ripgrep
    neovim
    wdisplays
    alsa-utils
    protonup-qt
    qt6.qtbase
    qt6.qtwayland
    xorg.libxcb
    xorg.xcbutil
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
    picom
    font-awesome
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    pulsemixer
    python3
    nodejs_22
    clang-tools
    fd
    luajitPackages.jsregexp
    fastfetch
    obsidian
    flameshot
    starship
    lf
    trash-cli
    swww
    lz4
    swayidle
    swaylock
    hyprcursor
    nwg-look
    hypridle
    jq
    firefox
    librewolf
    spotify
    swappy
    wttrbar
    hashcat
    tree
    genymotion
    android-tools
    openssl
    wlogout
    bash-completion
    rustup
    zoxide
    bat
    yazi
    shotcut
    freerdp3
    sshfs
    killall
    swaynotificationcenter
    golangci-lint
    goimports-reviser
    libreoffice
  ];

  # basic configuration of git
  programs.git = {
    enable = true;
    userName = "probird5";
    userEmail = "52969604+probird5@users.noreply.github.com";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
  };
  #};
  # testing

  xdg = {
    portal = {
      enable = true;
      config.common.default = "*";
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
      ];
    };

    userDirs = {
      enable = true;
      extraConfig = {
        XDG_EMULATION_DIR = "${config.home.homeDirectory}/Documents/emulation";
      };
    };
  };

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
