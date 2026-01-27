# Common application packages
{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    # Browsers
    brave

    # Productivity
    obsidian
    libreoffice
    vscodium
    _1password-gui

    # Communication
    discord
    spotify

    # Gaming
    steam
    steam-run
    lutris
    gamescope
    protonup-qt

    # System utilities
    gotop
    power-profiles-daemon

    # Virtualization (user tools)
    docker
    docker-compose
    spice-gtk
    spice
    virtiofsd
    ntfs3g
    seatd

    # Misc
    android-tools
    hashcat

    # Qt/X11 libraries
    qt6.qtbase
    qt6.qtwayland
    qt5.qtwayland
    egl-wayland
    xorg.libxcb
    xorg.xcbutil
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm

    # Firmware
    linux-firmware
    microcode-amd
  ];
}
