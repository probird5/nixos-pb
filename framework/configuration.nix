# NixOS configuration
{ config, pkgs, ... }:

{
  ###############
  # Imports
  ###############
  imports = [
    ./hardware-configuration.nix
    # ../shared/shares.nix
    ./wireguard.nix
    ./tailscale.nix
  ];
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    libglvnd libdrm
    xorg.libX11 xorg.libXext xorg.libXrandr xorg.libXrender
    xorg.libXcursor xorg.libXi xorg.libXxf86vm xorg.libXinerama
    libxkbcommon wayland
    freetype fontconfig
    zlib openssl curl
    alsa-lib pulseaudio
  ];
  ###############
  # Nix / Nixpkgs
  ###############
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  ###############
  # Host & Locale
  ###############
  networking.hostName = "nixos-framework";
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  ###############
  # Boot
  ###############
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = false;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
      efi.efiSysMountPoint = "/boot";
    };

    supportedFilesystems = [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" ];
    kernelParams = [ "resume=/swapfile" ];
  };

  swapDevices = [{
    device = "/swapfile";
    size = 64 * 1024; # 64GiB in MiB
  }];

  ###############
  # Hardware
  ###############
  hardware = {
    cpu.amd.updateMicrocode = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    steam-hardware.enable = true;

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ libGL libGLU ];
    };

    framework.amd-7040.preventWakeOnAC = true;
  };



  services.fwupd.enable = true;
  services.pulseaudio.enable = false;

  ###############
  # Networking
  ###############
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
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

  ###############
  # Display / Desktop & Services
  ###############
  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    # Printing (run once: sudo hp-setup -i -a)
    printing = {
      enable = true;
      drivers = [ pkgs.hplipWithPlugin ];
    };

    # Flatpak
    flatpak.enable = true;

    # File management helpers
    gvfs.enable = true;
    tumbler.enable = true;

    # Disks
    udisks2.enable = true;

    # DBus (useful for a bunch of desktop services)
    dbus.enable = true;

    # Spice guest agent (for VMs)
    spice-vdagentd.enable = true;

    # Login manager -> tuigreet launching Hyprland
    greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "probird5";
      };
    };
  };

  programs = {
    # Wayland compositor
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    # Thunar + plugins
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar thunar-archive-plugin thunar-volman ];
    };

    # Steam / Gaming
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;

    # Desktop bits
    dconf.enable = true;
    firefox.enable = true;

    # Shell
    zsh.enable = true;
  };

  ###############
  # Audio (PipeWire)
  ###############
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true; # Uncomment if needed
  };

  ###############
  # XDG Portals
  ###############
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  ###############
  # Fonts
  ###############
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.symbols-only
  ];

  ###############
  # Users
  ###############
  users.users.probird5 = {
    isNormalUser = true;
    description = "probird5";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "audio" "wheel" "libvirtd" "kvm" "qemu" "flatpak" ];
    packages = with pkgs; [
      kdePackages.kate
      # thunderbird
    ];
  };

  ###############
  # Environment
  ###############
  environment = {
    systemPackages = with pkgs; [
      bluez
      wl-clipboard
      xclip
      virt-manager
      virt-viewer
      win-virtio
      win-spice
      cifs-utils
      qemu
      gvfs
      home-manager
      ryzenadj
      vulkan-tools
      mesa
      hplipWithPlugin
      openresolv
    ];

    sessionVariables = {
      NIXOS_OZONE_WL = 1;
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };

  ###############
  # State Version
  ###############
  system.stateVersion = "24.11";
}

