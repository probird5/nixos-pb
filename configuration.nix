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

  

  networking.hostName = "nixos-pb"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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

  # Setting up virtualization
  virtualisation.libvirtd.enable = true;

  # steam

    environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\${HOME}/.steam/root/compatibilitytools.d";
  };

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  # Fonts

  fonts.fonts = with pkgs; [
  fira-code-nerdfont
];


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
  src = /home/probird5/dwm-config;
};


  environment.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };

  # I was editing this to see if gnome would work
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

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

  # Configure Nvidia

    hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libGL
      libGLU
      # Add more libraries as needed
    ];
  };

  hardware.nvidia.modesetting.enable = true;


  specialisation = {
    gaming-time.configuration = {

      hardware.nvidia = {
        prime.sync.enable = lib.mkForce true;
        prime.offload = {
          enable = lib.mkForce false;
          enableOffloadCmd = lib.mkForce false;
        };
      };

    };
  };

  boot.kernelParams = [ "nvidia-drm.fbdev=1" ];

  # Nvidia Prime config
  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    intelBusId = "PCI:00:02:0";
    nvidiaBusId = "PCI:01:00:0";
  };

  # Thunar
  programs.thunar.enable = true;

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
    virt-manager
    egl-wayland
    cifs-utils
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    qemu
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
    obsidian
    neovim
    dmenu
    nordic
    slstatus
    wlr-randr
    wayland-utils
    gamescope
    protonup-ng
    git
    gnumake
    gcc
    xorg.xorgserver
    xorg.xauth
    xorg.xinit
    pkg-config
    xorg.libX11.dev
    xorg.libXft
    xorg.libXinerama
    freetype
    linux-firmware
    starship
    microcodeIntel
    linuxPackages.nvidiaPackages.latest
    starship
    libGL
    libglvnd
  ];

  ### Home manager 
  programs.zsh.enable = true;
  users.users.probird5.shell = pkgs.zsh;

  # slstatus

  nixpkgs.overlays = [
  (final: prev: {
    slstatus = prev.slstatus.overrideAttrs (old: { 
      src = /home/probird5/slstatus;  # Update with path to your slstatus folder
    });
  })
];



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}

