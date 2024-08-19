# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.supportedFilesystems = [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" ];


#  suspend to RAM (deep) rather than `s2idle`
  boot.kernelParams = [ "mem_sleep_default=deep" ];
  # suspend-then-hibernate
  systemd.sleep.extraConfig = ''
    SuspendState=mem
  '';

 # Setting up virtualization
 virtualisation.libvirtd.enable = true;

 # USB passthrough for virt-manager
 virtualisation.spiceUSBRedirection.enable = true;

 # Enabeling docker
 virtualisation.docker.enable = true;

 # Can't remember why I added this tbh
  nix = {
    settings = {
      warn-dirty = false;
    };
  };
  

  networking.hostName = "nixos-pb"; # Define your hostname.

  # Enabeling Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Overlay for slstatus
  nixpkgs.overlays = [
    (final: prev: {
      slstatus = prev.slstatus.overrideAttrs (oldAttrs: rec {
        src = /home/probird5/config/slstatus;  
      });
    })
  ];


  # steam

    environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\${HOME}/.steam/root/compatibilitytools.d";
  };

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  # Fonts

  fonts.packages = with pkgs; [
  fira-code-nerdfont
];

  # Bluetooth

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # DWM
  services.xserver.enable = true;
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  # Custom config

  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
  src = /home/probird5/config/dwm-config;
};

 # May need to edit session variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };

  # Swap
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 64 * 1024; # size in MiB, 64 GiB = 64 * 1024 MiB
  } ];
 

  # Sound
 # sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Configure Nvidia unstable nixos branch

#    hardware.graphics = {
#    enable = true;
#    enable32Bit = true;
#    extraPackages = with pkgs; [
#      libGL
#      libGLU
      # Add more libraries as needed
#    ];
#  };

 hardware.opengl = {
   enable = true;
   driSupport = true;
   driSupport32Bit = true;

};

  hardware.nvidia.modesetting.enable = true;


  # Thunar
  programs.thunar.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  programs.thunar.plugins = with pkgs.xfce; [
  thunar
  thunar-archive-plugin
  thunar-volman
];

  services.udisks2.enable = true;

 

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.probird5 = {
    isNormalUser = true;
    description = "probird5";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "qemu"];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    docker
    udiskie
    virt-manager
    egl-wayland
    cifs-utils
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    qemu
    gvfs
    alacritty
    pavucontrol
    home-manager
    playerctl
    pamixer
    waybar
    brightnessctl
    zsh
    pciutils
    dunst
    libnotify
    hyprpaper
    mpv
    nerdfonts
    feh
    kitty
    swaycons
    rofi-wayland
    firefox
    wayland
    xwayland
    discord
    wl-clipboard
    _1password-gui
    neofetch
    flameshot
    grim
    slurp
    btop
    gotop
    lxappearance
    dmenu
    nordic
    slstatus
    wlr-randr
    wayland-utils
    gamescope
    git
    gnumake
    gcc
    xorg.xorgserver
    xorg.xauth
    xorg.xinit
    xorg.libX11
    xorg.libX11.dev
    xorg.libxcb
    xorg.libXft
    xorg.libXinerama
    xorg.xinput
    xdg-desktop-portal-gtk
    pkg-config
    freetype
    linux-firmware
    linuxPackages.nvidiaPackages.latest
    libGL
    libglvnd
    xclip
    microcodeAmd
    xss-lock
    hyprlock
    blueman
    pmutils
    spice-gtk
    polkit
    spice
    ntfs3g
  ];

  ### Home manager 
  programs.zsh.enable = true;
  users.users.probird5.shell = pkgs.zsh;

  ## Testing
  services.dbus.enable = true ;


    xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}

