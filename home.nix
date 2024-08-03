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

    programs.zsh = {
    enable = true;
    enableCompletion = true;
    # Optional: Specify a custom .zshrc file or include additional configurations
    };

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 168;
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
    # custom settings
  #  settings = {
   #   add_newline = false;
    #  aws.disabled = true;
     # gcloud.disabled = true;
      #line_break.disabled = true;
    };
  #};

  



  home.file = {
    ".config/starship.toml" = {
      text = ''
        format = """
        [░▒▓](#a3aed2)\
        [ \ue77d ](bg:#a3aed2 fg:#090c0c)\
        [](bg:#769ff0 fg:#a3aed2)\
        $directory\
        [](fg:#769ff0 bg:#394260)\
        $git_branch\
        $git_status\
        [](fg:#394260 bg:#212736)\
        $nodejs\
        $rust\
        $golang\
        $php\
        [](fg:#212736 bg:#1d2230)\
        $time\
        [ ](fg:#1d2230)\
        \n$character"""

        [directory]
        style = "fg:#e3e5e5 bg:#769ff0"
        format = "[ $path ]($style)"
        truncation_length = 3
        truncation_symbol = "…/"

        [directory.substitutions]
        "Documents" = "󰈙 "
        "Downloads" = " "
        "Music" = " "
        "Pictures" = " "

        [git_branch]
        symbol = ""
        style = "bg:#394260"
        format = '[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)'

        [git_status]
        style = "bg:#394260"
        format = '[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)'

        [nodejs]
        symbol = ""
        style = "bg:#212736"
        format = '[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'

        [rust]
        symbol = ""
        style = "bg:#212736"
        format = '[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'

        [golang]
        symbol = ""
        style = "bg:#212736"
        format = '[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'

        [php]
        symbol = ""
        style = "bg:#212736"
        format = '[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'

        [time]
        disabled = false
        time_format = "%R" # Hour:Minute Format
        style = "bg:#1d2230"
        format = '[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)'
      '';
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
