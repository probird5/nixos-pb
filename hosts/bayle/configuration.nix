{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
    services.xserver.videoDrivers = ["nvidia"];

  ############################################################
  # System identity / locale
  ############################################################
  networking.hostName = "bayle";
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  ############################################################
  # Boot / kernel
  ############################################################
  boot = {
    blacklistedKernelModules = [ "nouveau" ];

    supportedFilesystems = [
      "btrfs"
      "reiserfs"
      "vfat"
      "f2fs"
      "xfs"
      "ntfs"
      "cifs"
    ];
    initrd.kernelModules = [ "nvidia" ];

    kernelParams = [
      # Sleep / power quirks
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      "acpi.power_nocheck=1"
      "ahci.mobile_lpm_policy=1"
    ];

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      systemd-boot.enable = false;

      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
    };
  };

  ############################################################
  # Networking
  ############################################################
  networking = {
    networkmanager.enable = true;

    nameservers = [
      "100.100.100.100"
      "1.1.1.1"
    ];

    search = [ "tail339015.ts.net" ];

    firewall = {
      allowedTCPPorts = [ 22 ];
    };
  };

  ############################################################
  # Services / system daemons
  ############################################################
  services = {
    # Needed for screen share portals
    dbus.enable = true;

    # Disable USB wake to avoid instant-wake-after-suspend
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", TEST=="power/wakeup", ATTR{power/wakeup}="disabled"
    '';

    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = [ "probird5" ];
        UseDns = true;
        X11Forwarding = true;
        PermitRootLogin = "no";
      };
    };

    tailscale.enable = true;

    flatpak.enable = true;

    gvfs.enable = true;
    tumbler.enable = true;
    udisks2.enable = true;

    spice-vdagentd.enable = true;
    greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland";
        user = "probird5";
      };
    };

    emacs = {
      enable = true;
      package = pkgs.emacs;
    };
  };

  ###############
  # Virtualization
  ###############
  virtualisation = {
    docker.enable = true;

    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
      };
    };

    spiceUSBRedirection.enable = true;
  };
  ############################################################
  # X11 input settings (still used by some apps)
  ############################################################
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  ############################################################
  # Graphics / NVIDIA
  ############################################################
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libGL
        libGLU
      ];
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    nvidia = {
      # Stay proprietary until upstream issue is fixed
      open = false;

      powerManagement.enable = true;
      modesetting.enable = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.production;
    };
  };

  ############################################################
  # Audio (PipeWire)
  ############################################################
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  ############################################################
  # Desktop / Hyprland
  ############################################################
  programs = {
    dconf.enable = true;

    zsh.enable = true;

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar
        thunar-archive-plugin
        thunar-volman
      ];
    };

    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
    };

    gamemode.enable = true;
  };

  services.blueman.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      xdg-desktop-portal-hyprland
    ];
  };

  ############################################################
  # Virtualization
  ############################################################


  ############################################################
  # Swap
  ############################################################
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 64 * 1024; # MiB (64 GiB)
    }
  ];

  ############################################################
  # Environment variables
  ############################################################
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.local/share/Steam/compatibilitytools.d";
  };

  ############################################################
  # Users
  ############################################################
  users.users.probird5 = {
    isNormalUser = true;
    description = "probird5";
    shell = pkgs.zsh;

    extraGroups = [
      "networkmanager"
      "audio"
      "wheel"
      "libvirtd"
      "kvm"
      "qemu"
      "flatpak"
      "probird5"
    ];

    packages = with pkgs; [ ];
  };

  ############################################################
  # Nix
  ############################################################
  nix = {
    settings = {
      warn-dirty = false;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  ############################################################
  # Packages
  ############################################################
  environment.systemPackages = with pkgs; [
    vim
    wget

    # Wayland / Hyprland
    wayland
    xwayland
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    hyprpaper
    hyprlock
    waybar
    rofi
    wl-clipboard
    grim
    slurp
    dunst
    libnotify
    brightnessctl

    # Terminals / utils
    alacritty
    kitty
    zsh
    git
    gotop
    neofetch
    playerctl
    pamixer
    pavucontrol
    pciutils

    # Thunar stack
    gvfs
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    xfce.exo

    # Virtualization
    virt-manager
    virt-viewer
    qemu
    swtpm
    virtiofsd
    virtio-win
    win-spice
    spice
    spice-gtk

    # Filesystems / networking
    cifs-utils
    ntfs3g
    nfs-utils

    # NVIDIA / graphics bits
    egl-wayland
    nvidia-vaapi-driver
    vulkan-loader
    pkgs.pkgsi686Linux.vulkan-loader

    # Media
    mpv
    ffmpeg_7
    imagemagick
    libheif

    # Dev
    gcc
    gnumake
    pkg-config
    freetype
    cmake
    libtool
    nixfmt-rfc-style
    wineWowPackages.full

    # Misc / apps
    discord
    syncthing
    appimage-run
    home-manager
    gamescope
    gamescope-wsi
    blueman

    # X11 stuff (if you still need it)
    xclip
    xorg.xorgserver
    xorg.xauth
    xorg.xinit
    xorg.libX11
    xorg.libX11.dev
    xorg.libxcb
    xorg.libXft
    xorg.libXinerama
    xorg.xinput
    xss-lock
    pmutils
    polkit
    seatd

    # Other
    via
    linux-firmware
    microcode-amd
    feh
    dmenu
    slstatus
    wlr-randr
    wayland-utils
    lxappearance
    swaycons
  ];

    fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.symbols-only
  ];




  ############################################################
  # NixOS release compatibility
  ############################################################
  system.stateVersion = "25.05";
}

