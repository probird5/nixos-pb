{ config, lib, pkgs, modulesPath, ... }:

{
  # Ensure cifs-utils is available for mounting CIFS/SMB shares
  environment.systemPackages = [ pkgs.cifs-utils ];

  # Configure the SMB mount
  fileSystems."/home/probird5/Documents/emulation" = {
    device = "//192.168.5.250/emulation";  # Replace with your SMB share's address
    fsType = "cifs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
      "credentials=/home/probird5/.smb_creds"
      "uid=1000"
      "gid=100"
      "rw"
    ];
  };
}

