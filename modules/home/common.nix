# Common home-manager configuration
{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "probird5";
  home.homeDirectory = "/home/probird5";

  # Git
  programs.git = {
    enable = true;
    settings = {
      user.name = "probird5";
      user.email = "52969604+probird5@users.noreply.github.com";
    };
  };

  # FZF
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

  # Shell tools
  programs.zoxide.enable = true;
  programs.starship.enable = true;
  programs.home-manager.enable = true;

  # Wallpaper service
  services.swww.enable = true;

  # XDG user directories
  xdg.userDirs.enable = true;

  # Common CLI packages
  home.packages = with pkgs; [
    # System utilities
    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils
    killall
    wavemon
    wpaperd
    dillo
    qutebrowser

    # Archives
    p7zip
    unzip
    lz4

    # CLI tools
    ripgrep
    fd
    bat
    jq
    tree
    fastfetch
    wget
    openssl
    trash-cli
    yazi
    lf
    bluetui

    # Shell
    tmux
    starship
    bash-completion
  ];
}
