# Desktop environment configuration
{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.desktop = {
    enableHyprland = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Hyprland compositor";
    };
    enableNiri = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Niri compositor";
    };
    enableMango = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable MangoWC compositor";
    };
  };

  config = {
    # Login manager - session picker from installed compositors
    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --sessions /usr/share/wayland-sessions --remember-session";
        user = "probird5";
      };
    };

    # Thunar file manager
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar
        thunar-archive-plugin
        thunar-volman
      ];
    };

    # Gaming
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    programs.gamemode.enable = true;
    hardware.steam-hardware.enable = true;

    # Desktop programs
    programs.dconf.enable = true;
    # Firefox is configured via home-manager in modules/firefox.nix

    # Compositors (conditional)
    programs.hyprland = lib.mkIf config.desktop.enableHyprland {
      enable = true;
      xwayland.enable = true;
    };
    programs.niri = lib.mkIf config.desktop.enableNiri {
      enable = true;
    };
    programs.mango = lib.mkIf config.desktop.enableMango {
      enable = true;
    };

    # XDG Portals
    xdg.portal.enable = true;

    # Virtualization
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu.swtpm.enable = true;
      };
      spiceUSBRedirection.enable = true;
    };

    # Desktop system packages
    environment.systemPackages = with pkgs; [
      # Wayland essentials
      wayland
      xwayland
      waybar
      rofi

      # Hyprland/Niri tools
      hyprpaper
      hyprlock
      grim
      slurp

      # File manager extras
      xfce.thunar-volman
      thunar-archive-plugin
      xfce4-exo

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

      # Desktop utilities
      playerctl
      pamixer
      pavucontrol
      brightnessctl
      libnotify
      blueman

      # Gaming
      gamescope
      gamescope-wsi
    ];
  };
}
