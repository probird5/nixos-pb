
# NixOS configuration

This repository contains my NixOS configuration using flakes. It is organized to keep both system and user configurations modular, making it easier to manage and update.

## Repository Structure

- **`flake.nix`**: The main entry point for defining the NixOS configuration and inputs using flakes.
- **`flake.lock`**: Lock file to ensure reproducibility by pinning dependencies.
- **`nixos-frame/`**: Placeholder for future configurations or separate NixOS setups.
- **`nixos-pb/`**: Main configuration directory for the `nixos-pb` machine.
  - **`configuration.nix`**: Primary configuration file that imports modules and defines system settings.
  - **`hardware-configuration.nix`**: Auto-generated hardware-specific configuration, defining detected hardware settings.
  - **`home.nix`**: home-manager configuration file for managing user-specific applications and settings.
  - **`nixos-pb.nix`**: Main NixOS configuration entry point that imports `configuration.nix` and sets up the machine-specific environment.
  - **`config/`**: Directory for additional configuration modules or files.
    - **`starship.nix`**: Configuration for the Starship prompt, specifying appearance and behavior.

## Getting Started

### 1. Cloning the Repository

Clone this repository to your local machine:

```bash
git clone https://github.com/probird5/nixos-pb
cd nixos-pb
```

### 2. Building the Configuration

To apply the configuration on your machine, use nixos-rebuild with the `--flake` option:

```bash
# Switch to the configuration defined in this repository
sudo nixos-rebuild switch --flake .#nixos-pb
```

## Notes

    home-manager Integration: This setup assumes home-manager is managed within the flake for user-level configuration.

    Reproducibility: The flake.lock file ensures a stable and reproducible setup by locking dependencies.

## Issue with neovim
I had an issue where installing `lua-language-server` via mason did not work on nixos, had to install it via home-manager which solved the issue
