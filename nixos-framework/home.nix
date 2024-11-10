{ config, pkgs, ... }:


{
  # TODO please change the username & home directory to your own
  home.username = "probird5";
  home.homeDirectory = "/home/probird5";

    imports =
    [ # Include the results of the hardware scan.
      ./starship.nix
      ./hyprland.nix
      #./nvim.nix
    ];


  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

};

  # Additional Zsh configuration
  programs.hyprlock.enable = true;

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 24;
    "Xft.dpi" = 120;
    "Xcursor.theme" = "Nordzy-cursors";
  };

xdg.configFile.nvim.source = ./nvim;



gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
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


  # fzf


  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    historyWidgetOptions = [
      "--height" "40%"
      "--layout=reverse"
      "--border"
    ];
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    sysstat
    brave
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    p7zip
    steam
    lutris
    brave
    remmina
    gnomeExtensions.remmina-search-provider
    tmux
    neovim
    vim
    xprintidle
    fzf
    go
    unzip
    stylua
    lua
    #luajitPackages.luarocks
    ripgrep
    wdisplays
    nwg-displays
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
    nerdfonts
    font-awesome
    pulsemixer
    cargo
    python3
    nodejs_22
    clang-tools
    fd
    #luajitPackages.jsregexp
    lua-language-server
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
    spotify
    swappy
    wttrbar
    hashcat
    tree
    genymotion
    android-tools
    openssl
    wlogout
    wget
    docker
    alacritty
    pavucontrol
    waybar
    brightnessctl
    zsh
    hyprpaper
    mpv
    feh
    swaycons
    rofi-wayland
    wayland
    xwayland
    discord
    wl-clipboard
    gcc
    flameshot
    grim
    slurp
    btop
    gotop
    lxappearance
    nordic
    wlr-randr
    wayland-utils
    gamescope
    git
    gnumake
    gcc
    linux-firmware
    microcodeAmd
    hyprlock
    blueman
    spice-gtk
    polkit
    spice
    ntfs3g
    seatd
    qt5.qtwayland
    qt6.qtwayland
    libsForQt5.polkit-kde-agent
    egl-wayland
    pulseaudioFull
    _1password-gui
    virtiofsd
    pamixer
    vscodium
    golangci-lint
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "probird5";
    userEmail = "probird5";
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
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    userDirs = {
      enable = true;
    };
};




  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
