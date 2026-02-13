# Desktop environment configuration
{
  config,
  options,
  pkgs,
  lib,
  ...
}:

let
  # Check if MangoWC module is available (only loaded for hosts that import it)
  hasMango = builtins.hasAttr "mango" (options.programs or { });

  # Use the NixOS displayManager session infrastructure.
  # Hyprland, Niri, and MangoWC modules all register themselves via
  # services.displayManager.sessionPackages when enabled, so the merged
  # wayland-sessions directory is available at sessionData.desktops.
  sessionDir = config.services.displayManager.sessionData.desktops;
in
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

  config = lib.mkMerge (
    [
      {
        # Let NixOS know we are using a display manager (for sessionData)
        services.displayManager.enable = true;

        # Login manager - session picker from installed compositors
        services.greetd = {
          enable = true;
          settings.default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet --time --sessions ${sessionDir}/share/wayland-sessions --remember-session";
            user = "greeter";
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
      }

    ]
    ++ lib.optional hasMango (
      # MangoWC (only when its module is available)
      lib.mkIf config.desktop.enableMango {
        programs.mango.enable = true;
      }
    )
  );
}
