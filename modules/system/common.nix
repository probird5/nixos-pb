# Common system configuration shared across all hosts
{ config, pkgs, lib, ... }:

{
  # Nix settings
  nix.settings = {
    warn-dirty = false;
    experimental-features = [ "nix-command" "flakes" ];
  };
  nixpkgs.config.allowUnfree = true;

  # Locale & timezone
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  # Boot loader (GRUB + EFI)
  boot.loader = {
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

  # Supported filesystems
  boot.supportedFilesystems = [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" ];

  # Networking base
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };

  # Audio (PipeWire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.pulseaudio.enable = false;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Graphics base
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ libGL libGLU ];
  };

  # Common services
  services = {
    dbus.enable = true;
    flatpak.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
    udisks2.enable = true;
    spice-vdagentd.enable = true;
    fwupd.enable = true;

    xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Environment variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  # Shell
  programs.zsh.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.symbols-only
  ];

  # Common system packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    wl-clipboard
    xclip
    home-manager
    bluez
    gvfs
    cifs-utils
  ];
}
