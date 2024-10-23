{ config, pkgs, ... }:


{
  # TODO please change the username & home directory to your own
  home.username = "probird5";
  home.homeDirectory = "/home/probird5";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

    imports =
    [ # Include the results of the hardware scan.
      ./config/starship.nix
    ];

  # firefox crashing on wayland
#   home.sessionVariables = {
#    GBM_BACKEND = "";
#  };


  programs.zsh = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
      autoload -Uz compinit
      compinit -d ~/.cache/zcompdump
      zstyle ":completion:*:*:*:*:*" menu select
      zstyle ":completion:*" auto-description "specify: %d"
      zstyle ":completion:*" completer _expand _complete
      zstyle ":completion:*" format "Completing %d"
      zstyle ":completion:*" group-name ""
      zstyle ":completion:*" list-colors "no=00;37:fi=00;37:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00;05;37;41:ex=01;32"
      zstyle ":completion:*" list-prompt "%SAt %p: Hit TAB for more, or the character to insert%s"
      zstyle ":completion:*" matcher-list "m:{a-zA-Z}={A-Za-z}"
      zstyle ":completion:*" rehash true
      zstyle ":completion:*" select-prompt "%SScrolling active: current selection at %p%s"
      zstyle ":completion:*" use-compctl false
      zstyle ":completion:*" verbose true
      zstyle ":completion:*:kill:*" command "ps -u $USER -o pid,%cpu,tty,cputime,cmd"
    '';

    syntaxHighlighting.enable = true;
    oh-my-zsh.enable = true;

    zplug = {
      enable = true;
      plugins = [
     #   { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
      ];
    };
};
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
    spotify
    swappy
    wttrbar
    hashcat
    tree
    genymotion
    android-tools
    openssl
    wlogout
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
