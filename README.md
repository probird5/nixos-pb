# NixOS Configuration

A flake-based NixOS configuration managing three machines with home-manager integration, featuring Wayland compositors, development tools, and gaming support.

## Machines

| Host | Description | GPU | Compositor |
|------|-------------|-----|------------|
| **bayle** | Custom Desktop PC | NVIDIA | Hyprland |
| **messmer** | Framework Desktop | AMD | Niri / Hyprland |
| **framework** | Framework 13 (7040 AMD) | AMD | Niri / Hyprland |

## Repository Structure

```
nixos-pb/
├── flake.nix           # Flake inputs and outputs
├── hosts/              # Per-machine configurations
│   ├── bayle/          # NVIDIA desktop
│   ├── messmer/        # AMD desktop
│   └── framework/      # Framework laptop
├── modules/            # Reusable NixOS/home-manager modules
│   ├── nvim.nix        # Neovim configuration
│   ├── tmux.nix        # Tmux with Tokyo Night theme
│   ├── ghostty.nix     # Ghostty terminal
│   ├── btop.nix        # System monitor with ROCm
│   ├── ollama.nix      # Local LLM service
│   ├── opencode.nix    # AI code assistant config
│   └── shares.nix      # SMB/CIFS mounts
└── config/             # Application configs
    ├── hypr/           # Hyprland compositor
    ├── niri/           # Niri compositor
    ├── waybar/         # Status bar
    ├── nvim/           # Neovim (Lua)
    ├── rofi/           # App launcher
    ├── starship/       # Shell prompt
    ├── zsh/            # Shell config
    └── backgrounds/    # Wallpapers
```

## Features

### Desktop Environment
- **Compositors**: Hyprland and Niri (Wayland)
- **Panel**: Waybar with custom modules
- **Launcher**: Rofi with Dracula theme
- **File Manager**: Thunar with plugins
- **Theme**: Dracula GTK, Nordzy icons/cursors

### Development
- **Editors**: Neovim (custom Lua config), VSCodium
- **Terminal**: Ghostty, Alacritty (Tokyo Night theme)
- **Languages**: Go, Rust, Python, Node.js, Lua, Nix
- **Tools**: Tmux, Git, ripgrep, fd, fzf, lazygit

### Gaming & Virtualization
- Steam with Proton, Gamemode, Gamescope
- Lutris, Bottles, Protonup-qt
- QEMU/KVM with virt-manager
- Docker/Podman support

### Services
- Tailscale (bayle, framework)
- Ollama with Open WebUI (messmer)
- PipeWire audio
- Bluetooth with blueman

## Usage

### Clone

```bash
git clone https://github.com/probird5/nixos-pb
cd nixos-pb
```

### Build and Switch

```bash
# Apply configuration for a specific host
sudo nixos-rebuild switch --flake .#bayle
sudo nixos-rebuild switch --flake .#messmer
sudo nixos-rebuild switch --flake .#framework
```

### Update Flake Inputs

```bash
nix flake update
```

## Flake Inputs

| Input | Source |
|-------|--------|
| nixpkgs | nixos-unstable |
| home-manager | nix-community (unstable) |
| nixos-hardware | NixOS/nixos-hardware |
| nvf | NotAShelf/nvf |

## Host Details

### bayle (Custom PC)
- NVIDIA proprietary drivers (production)
- 64GB swap, GRUB bootloader
- Emacs server, Flatpak
- Android tools, Genymotion

### messmer (Framework Desktop)
- AMD GPU with ROCm tools
- Kernel 6.18
- Podman with Docker compatibility
- Ollama LLM server (port 11434)

### framework (Framework 13)
- nixos-hardware Framework 13 7040 AMD module
- Fingerprint authentication (fprintd)
- Hyprlock with fingerprint support
- Power-optimized configuration

## Notes

- Home-manager is integrated as a NixOS module
- Neovim config is symlinked writable from this repo
- All hosts share common modules with machine-specific overrides
- Tokyo Night theme used consistently across terminal apps
