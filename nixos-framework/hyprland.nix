{ lib, config, ... }:

let
  username = "probird5"; # Define your username here
  modifier = "SUPER";     # Define any other variables as needed
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = lib.concatStringsSep "" [
      ''
        # Environment Variables
        env = LIBVA_DRIVER_NAME,nvidia
        env = XDG_SESSION_TYPE,wayland
        env = __GLX_VENDOR_LIBRARY_NAME,nvidia
        env = ELECTRON_OZONE_PLATFORM_HINT,auto
        env = XDG_CURRENT_DESKTOP, Hyprland
        env = XDG_SESSION_DESKTOP, Hyprland
        env = GDK_BACKEND, wayland, x11
        env = GBM_BACKEND,nvidia-drm
        env = NVD_BACKEND,direct

        #####################
        ### Autostart Apps ##
        #####################
        exec-once = waybar &
        exec-once = hyprctl setcursor Nordzy-cursors 24
        exec-once = hypridle &
        exec = "/home/${username}/.config/hypr/scripts/wallpaper.sh"

        #######################
        ### General Settings ##
        #######################
        general {
          gaps_in = 5
          gaps_out = 20
          border_size = 2
          layout = dwindle
          resize_on_border = false
          allow_tearing = false
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)
        }

        ##############################
        ### Input Configuration ######
        ##############################
        input {
          kb_layout = us
          follow_mouse = 1
          touchpad {
            natural_scroll = true
            disable_while_typing = true
            scroll_factor = 0.8
          }
          sensitivity = 0
          accel_profile = flat
        }

        ####################
        ### Window Rules ###
        ####################
        windowrulev2 = fullscreen,class:^steam_app\\d+$
        windowrulev2 = monitor 1,class:^steam_app_\\d+$
        windowrulev2 = workspace 10,class:^steam_app_\\d+$
        workspace = 9, border:false, rounding:false
        windowrulev2 = float, title:^(Picture-in-Picture|Firefox)$
        windowrulev2 = size 800 450, title:^(Picture-in-Picture|Firefox)$
        windowrulev2 = pin, title:^(Picture-in-Picture|Firefox)$

        #######################
        ### Monitor Settings ##
        #######################
        monitor = eDP-1, preferred, auto, 1.5

        ########################
        ### Decorations ########
        ########################
        decoration {
          rounding = 10
          active_opacity = 1.0
          inactive_opacity = 1.0
          drop_shadow = true
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
          blur {
            enabled = true
            size = 3
            passes = 1
            vibrancy = 0.1696
          }
        }

        ####################
        ### Animations #####
        ####################
        animations {
          enabled = true
          bezier = myBezier, 0.05, 0.9, 0.1, 1.05
          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
        }

        #############################
        ### Keybindings ############
        #############################
        bind = ${modifier},Return,exec,alacritty
        bind = ${modifier}SHIFT,Return,exec,rofi -show drun -show-icons
        bind = ${modifier}SHIFT,C,killactive
        bind = ${modifier}SHIFT,Q,exit
        bind = ${modifier},V,togglefloating
        bind = ${modifier},P,pseudo
        bind = ${modifier}SHIFT,SPACE,movetoworkspace,special
        bind = ${modifier},SPACE,togglespecialworkspace
        bind = ${modifier}SHIFT,1,movetoworkspace,1
        bind = ${modifier}SHIFT,2,movetoworkspace,2
        bind = ${modifier},1,workspace,1
        bind = ${modifier},2,workspace,2

        # Additional custom keybindings
        bind = ${modifier},W,exec,firefox
        bind = ${modifier},T,exec,thunar
        bind = ${modifier},F,fullscreen
        bind = ${modifier}SHIFT,F,togglefloating
        bind = ${modifier},D,exec,discord
        bind = ${modifier},M,exec,spotify
        bind = ${modifier},Q,killactive
        bind = ${modifier}SHIFT,left,movewindow,l
        bind = ${modifier}SHIFT,right,movewindow,r

        ##############################
        ### Workspace and Focus ######
        ##############################
        bind = ${modifier},left,movefocus,l
        bind = ${modifier},right,movefocus,r
        bind = ${modifier},up,movefocus,u
        bind = ${modifier},down,movefocus,d

        #####################
        ### Misc Options ###
        #####################
        misc {
          disable_hyprland_logo = true
        }
      ''
    ];
  };
}

