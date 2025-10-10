{ inputs, ... }:
{
  imports = [
    ./configuration.nix
    inputs.sops-nix.nixosModules.sops
  ];
}
