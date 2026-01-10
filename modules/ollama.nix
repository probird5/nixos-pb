{ config, lib, pkgs, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
  };

  services.open-webui = {
  enable = true;
  host = "0.0.0.0";
  port = 8083;
  openFirewall = true;
  };
}

