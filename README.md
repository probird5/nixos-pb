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
├── flake.nix
├── modules/
│   ├── system/              # System-level modules
│   │   ├── common.nix       # Shared: nix, locale, audio, bluetooth, fonts
│   │   ├── desktop.nix      # Shared: greetd, thunar, gaming, virtualization
│   │   ├── nvidia.nix       # NVIDIA GPU configuration
│   │   └── amd.nix          # AMD GPU/CPU configuration
│   ├── home/                # Home-manager modules
│   │   ├── common.nix       # Shared: git, fzf, zoxide, CLI tools
│   │   ├── theming.nix      # Shared: GTK, Qt, cursors, fonts
│   │   ├── desktop.nix      # Shared: config files, MIME apps, desktop packages
│   │   ├── development.nix  # Shared: languages, dev tools
│   │   └── packages.nix     # Shared: common applications
│   ├── nvim.nix             # Neovim configuration
│   ├── tmux.nix             # Tmux with Tokyo Night
│   ├── ghostty.nix          # Ghostty terminal
│   ├── btop.nix             # System monitor
│   ├── ollama.nix           # Local LLM service
│   ├── opencode.nix         # AI code assistant
│   └── shares.nix           # SMB/CIFS mounts
├── hosts/
│   ├── bayle/               # ~130 lines (was ~430)
│   ├── messmer/             # ~75 lines (was ~250)
│   └── framework/           # ~90 lines (was ~280)
└── config/                  # Application configs (hypr, waybar, nvim, etc.)
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

### Verify Configuration

```bash
nix flake check
```

## Module System

The configuration uses a layered module approach:

### System Modules (`modules/system/`)
- **common.nix**: Nix settings, locale, audio, bluetooth, fonts, common services
- **desktop.nix**: Login manager, file manager, gaming, virtualization (with options)
- **nvidia.nix**: NVIDIA driver, kernel params, packages
- **amd.nix**: AMD driver, microcode, ROCm tools (optional)

### Home Modules (`modules/home/`)
- **common.nix**: Git, shell tools, CLI utilities
- **theming.nix**: GTK/Qt themes, cursors, dconf settings
- **desktop.nix**: Config file sources, MIME apps, desktop packages
- **development.nix**: Languages and dev tools
- **packages.nix**: Common applications

### Host Files
Each host only contains host-specific settings:
- Hostname and networking
- Hardware-specific options
- Service toggles
- Additional packages

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
- Hyprland compositor
- Emacs server, Tailscale
- SSH enabled

### messmer (Framework Desktop)
- AMD GPU with ROCm tools
- Niri compositor, Kernel 6.18
- Podman (Docker-compatible)
- Ollama LLM server

### framework (Framework 13)
- nixos-hardware Framework 13 7040 AMD module
- Niri + Hyprland (both enabled)
- Fingerprint authentication
- Printing support, Tailscale
