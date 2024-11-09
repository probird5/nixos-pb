{ lib, config, ... }:

let
  username = "probird5";  # Define the username here
  mainMod = "SUPER";      # Define the main modifier here
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

        ################
        ### Monitors ###
        ################
        monitor = eDP-1, preferred, auto, 1.5

        #################
        ### Programs ####
        #################
        $terminal = alacritty
        $fileManager = thunar
        $menu = rofi -show drun -show-icons -theme /home/${username}/.config/rofi/theme.rasi

        ######################
        ### Look and Feel ###
        ######################
        general {
          gaps_in = 5
          gaps_out = 20
          border_size = 2
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)
          resize_on_border = false
          allow_tearing = false
          layout = dwindle
        }

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

        dwindle {
          pseudotile = true
          preserve_split = true
        }

        misc {
          disable_hyprland_logo = true
          vrr = 1
        }

        ##################
        ### Input Setup ###
        ##################
        input {
          kb_layout = us
          follow_mouse = 1
          sensitivity = 0
          touchpad {
            natural_scroll = true
            clickfinger_behavior = 1
            disable_while_typing = true
          }
        }

        gestures {
          workspace_swipe = false
        }

        ##################
        ### Keybindings ###
        ##################
        $mainMod = ${mainMod}

        bind = $mainMod, RETURN, exec, alacritty
        bind = $mainMod SHIFT, C, killactive,
        bind = $mainMod SHIFT, Q, exit,
        bind = $mainMod, V, togglefloating,
        bind = $mainMod, P, exec, $menu
        bind = $mainMod, N, pseudo, # dwindle
        bind = $mainMod, B, togglesplit, # dwindle
        bind = , Print, exec, grim -g "$(slurp -d)" - | swappy -f -

        # Move focus with mainMod + arrow keys
        bind = $mainMod, left, movefocus, l
        bind = $mainMod, right, movefocus, r
        bind = $mainMod, up, movefocus, u
        bind = $mainMod, down, movefocus, d
        bind = $mainMod, H, movefocus, l
        bind = $mainMod, L, movefocus, r
        bind = $mainMod, K, movefocus, u
        bind = $mainMod, J, movefocus, d

        # Master layout keybindings
        bind = $mainMod, J, movefocus, next
        bind = $mainMod, K, movefocus, prev

        # Switch workspaces with mainMod + [0-9]
        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 0, movetoworkspace, 10

        # Resize windows
        bind = $mainMod CTRL, left, resizeactive, -20 0
        bind = $mainMod CTRL, right, resizeactive, 20 0
        bind = $mainMod CTRL, up, resizeactive, 0 -20
        bind = $mainMod CTRL, left, resizeactive, -20 0

        bind = $mainMod CTRL, H, resizeactive, 20 0
        bind = $mainMod CTRL, L, resizeactive, 0 -20
        bind = $mainMod CTRL, K, resizeactive, 0 20
        bind = $mainMod CTRL, J, resizeactive, 0 20


        # Example special workspace
        bind = $mainMod, S, togglespecialworkspace, magic
        bind = $mainMod SHIFT, S, movetoworkspace, special:magic

        ########################
        ### Volume and Media ###
        ########################
        bind = , XF86MonBrightnessUp, exec, brightnessctl s +5%
        bind = , XF86MonBrightnessDown, exec, brightnessctl s 5%-
        bind = , XF86AudioRaiseVolume, exec, pamixer -i 5
        bind = , XF86AudioLowerVolume, exec, pamixer -d 5
        bind = , XF86AudioMicMute, exec, pamixer --default-source -m
        bind = , XF86AudioMute, exec, pamixer -t
        bind = , XF86AudioPlay, exec, playerctl play-pause
        bind = , XF86AudioPause, exec, playerctl play-pause
        bind = , XF86AudioNext, exec, playerctl next
        bind = , XF86AudioPrev, exec, playerctl previous

        ##################
        ### Window Rules ##
        ##################
        windowrulev2 = fullscreen, class:^steam_app\\d+$
        windowrulev2 = monitor 1, class:^steam_app_\\d+$
        windowrulev2 = workspace 10, class:^steam_app_\\d+$
        windowrulev2 = float, title:^(Picture-in-Picture|Firefox)$
        windowrulev2 = size 800 450, title:^(Picture-in-Picture|Firefox)$
        windowrulev2 = pin, title:^(Picture-in-Picture|Firefox)$
        windowrulev2 = suppressevent maximize, class:.*
      ''
    ];
  };
}

