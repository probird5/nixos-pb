{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  services.ollama = {
    enable = true;
    # Optional: load models on startup
    #loadModels = [ ... ];
    acceleration = "cuda";
  };
  services.open-webui.enable = true;

}
