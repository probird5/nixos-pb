# AMD GPU/CPU configuration
{ config, pkgs, lib, ... }:

{
  options.amd = {
    enableRocm = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable ROCm tools for GPU monitoring";
    };
  };

  config = {
    # Video driver
    services.xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
    };

    # CPU microcode
    hardware.cpu.amd.updateMicrocode = true;
    hardware.enableRedistributableFirmware = true;

    # AMD-specific packages
    environment.systemPackages = with pkgs; [
      vulkan-tools
      mesa
      ryzenadj
      amdgpu_top
    ] ++ lib.optionals config.amd.enableRocm [
      rocmPackages.rocminfo
      rocmPackages.rocm-smi
    ];
  };
}
