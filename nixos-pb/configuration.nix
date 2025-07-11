# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.sops-nix.nixosModules.sops
    ../shared/shares.nix
#    ./config/gnome.nix
#    ./ollama.nix
  ];

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.supportedFilesystems = [
    "btrfs"
    "reiserfs"
    "vfat"
    "f2fs"
    "xfs"
    "ntfs"
    "cifs"
  ];
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

# Name servers
networking.nameservers = [ "100.100.100.100" "1.1.1.1" ];
networking.search = [ "tail339015.ts.net"];

  # sops
  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/probird5/.config/sops/age/keys.txt";

  sops.secrets = {
    "syncthing_user".owner = "probird5";
    "syncthing_password".owner = "probird5";
  };

  sops.templates = {
    "syncuser".content = ''${config.sops.placeholder."syncthing_user"}'';
    "syncpassword".content = ''${config.sops.placeholder."syncthing_password"}'';
  };

  # Needed this to fix a sleep bug.

  boot.kernelParams = [
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "acpi.power_nocheck=1"
    "ahci.mobile_lpm_policy=1"
  ];

  hardware.nvidia.powerManagement.enable = true;

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", TEST=="power/wakeup", ATTR{power/wakeup}="disabled"
  '';

  # Firewall configuration

  networking.firewall.allowedTCPPorts = [22];
  # Making sure to use the proprietary drivers until the issue above is fixed upstream
  hardware.nvidia.open = false;

  # Setting up virtualization
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  # Enabeling docker
  virtualisation.docker.enable = true;

  # Can't remember why I added this tbh
  nix = {
    settings = {
      warn-dirty = false;
    };
  };

  networking.hostName = "nixos-pb"; # Define your hostname.

  ## Virtualization from youtube video https://www.youtube.com/watch?v=rCVW8BGnYIc

  programs.dconf.enable = true;

  # Enabeling Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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

  # steam

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.local/share/Steam/compatibilitytools.d";

  };

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
  programs.steam.remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play

  # Bluetooth

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  #flatpak
  services.flatpak.enable = true;

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

  # May need to edit session variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };

  # Swap
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 64 * 1024; # size in MiB, 64 GiB = 64 * 1024 MiB
    }
  ];

  # Sound

  # Enable PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable PulseAudio
  # commented out since unstable doesn't require it
  #sound.enable = true;

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
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

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

  # Define a user account.
  users.users.probird5 = {
    isNormalUser = true;
    description = "probird5";
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    pipewire
    wireplumber
    xdg-desktop-portal-hyprland
    docker
    udiskie
    virt-manager
    virt-viewer
    win-virtio
    win-spice
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
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    feh
    kitty
    swaycons
    rofi-wayland
    wayland
    xwayland
    discord
    wl-clipboard
    neofetch
    flameshot
    grim
    slurp
    btop
    gotop
    lxappearance
    dmenu
    #nordic
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
    #linuxPackages.nvidiaPackages.latest
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
    seatd
    qt5.qtwayland
    qt6.qtwayland
    libsForQt5.polkit-kde-agent
    nvidia-vaapi-driver
    egl-wayland
    pulseaudioFull
    vulkan-loader # Vulkan support for 64-bit applications
    pkgs.pkgsi686Linux.vulkan-loader # Vulkan support for 32-bit applications
    swtpm
    virtiofsd
    via
    gamescope-wsi
    ffmpeg_7
    greetd.tuigreet
    syncthing
    nixfmt-rfc-style
    sops
    nfs-utils
    appimage-run
    cmake
    libtool
    imagemagick 
    libheif
    xfce.exo
  #  (callPackage ./packages/zen.nix {})
  ];

  ### Home manager
  programs.zsh.enable = true;
  users.users.probird5.shell = pkgs.zsh;

  services.greetd = {
    enable = true;
    vt = 3;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
      };
    };
  };

### Enable ssh

services.openssh = {
  enable = true;
  ports = [ 22 ];
  settings = {
    PasswordAuthentication = true;
    AllowUsers = ["probird5"]; # Allows all users by default. Can be [ "user1" "user2" ]
    UseDns = true;
    X11Forwarding = true;
    PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
  };
};


  ## Needed for screenshare
  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  ## Tailscale
  services.tailscale.enable = true;

  services.emacs = {
    enable = true;
    package = pkgs.emacs; # replace with emacs-gtk, or a version provided by the community overlay if desired.
  };


  ## Syncthing

services.syncthing = {
  enable = true;
  dataDir = "/home/probird5/Documents";
  openDefaultPorts = true;
  configDir = "/home/probird5/.config/syncthing";
  user = "probird5";
  group = "users";
  guiAddress = "127.0.0.1:8384";
  settings = {
    devices = {
      "nixos-framework" = {
        id = "W5FDVW4-VY4EMJF-QMDEBMI-TK32XMP-3B657BF-KXO4GQF-PXVH5HD-EP6PWQR";
      };
    };
    folders = {
      "Documents" = {
        path = "/home/probird5/Documents";
        devices = [ "nixos-framework" ]; # Link folder to the defined device
        versioning = {
          type = "staggered";
          params = {
            cleanInterval = "3600";
            maxAge = "15768000";
          };
        };
      };
    };
  };
};

  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
