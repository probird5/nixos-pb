{
  description = "NixOS configuration";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; #unstable url
    #nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager"; #unstable url
     #url = "github:nix-community/home-manager/release-24.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, nixos-hardware, sops-nix, ... }: {
    nixosConfigurations = {
      # TODO please change the hostname to your own
      nixos-pb = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./nixos-pb/nixos-pb.nix
          sops-nix.nixosModules.sops
          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.probird5 = import ./nixos-pb/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
      
      nixos-framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos-framework/nixos-framework.nix
	  nixos-hardware.nixosModules.framework-13-7040-amd

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
	    home-manager.backupFileExtension = "backup";

            home-manager.users.probird5 = import ./nixos-framework/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };
  };
}
