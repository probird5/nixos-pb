# NixOS Configuration

A flake-based NixOS configuration managing three machines with home-manager integration, featuring Wayland compositors, development tools, and gaming support.

## Machines

| Host | Description | GPU | Compositor |
|------|-------------|-----|------------|
| **bayle** | Custom Desktop PC | NVIDIA | Hyprland / MangoWC |
| **messmer** | Framework Desktop | AMD | Niri |
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
├── shells/
│   └── rust/                # Rust development shell (flake with Windows cross-compile)
├── hosts/
│   ├── bayle/               # ~130 lines (was ~430)
│   ├── messmer/             # ~75 lines (was ~250)
│   └── framework/           # ~90 lines (was ~280)
└── config/                  # Application configs (hypr, mango, waybar, nvim, etc.)
    ├── mango/               # MangoWC compositor config
    │   ├── config.conf      # Main config (monitors, layouts, keybinds, theming)
    │   ├── autostart.sh     # Startup script (swww wallpaper)
    │   ├── change-wallpaper.sh  # Random wallpaper switcher
    │   └── hypridle.conf    # Idle/lock/suspend config
```

## Features

### Desktop Environment
- **Compositors**: Hyprland, Niri, and [MangoWC](https://github.com/DreamMaoMao/mangowc) (Wayland)
- **Panel**: Waybar with custom modules
- **Launcher**: Rofi with Dracula theme
- **File Manager**: Thunar with plugins
- **Theme**: Dracula GTK, Nordzy icons/cursors

### Development
- **Editors**: Neovim (custom Lua config with LSP, see [config/nvim/README.md](config/nvim/README.md)), VSCodium
- **Terminal**: Ghostty, Alacritty (Tokyo Night theme)
- **Languages**: Go, Rust, Python, Node.js, Lua, Nix
- **Tools**: Tmux, Git, ripgrep, fd, fzf, lazygit
- **Dev Shells**: Rust (see `shells/rust.nix`)

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

### Development Shells

Flake-based development environments with all necessary tools:

```bash
# Rust development (with Windows cross-compilation)
nix develop ~/nixos-pb/shells/rust

# Or copy flake to your project
cp -r ~/nixos-pb/shells/rust/* ./
nix develop
```

**Rust shell includes:**
- Rust stable with `x86_64-pc-windows-gnu` target
- rust-analyzer, rust-src
- MinGW-w64 linker for Windows builds
- Wine64 for testing Windows binaries

```bash
# Build for Windows
cargo build --target x86_64-pc-windows-gnu

# Test with Wine
wine64 target/x86_64-pc-windows-gnu/debug/your_binary.exe
```

**For LSP support**, create `.cargo/config.toml` in your project:

```toml
[build]
target = "x86_64-pc-windows-gnu"

[target.x86_64-pc-windows-gnu]
linker = "x86_64-w64-mingw32-gcc"
```

This tells rust-analyzer to analyze for Windows, resolving `winapi` imports.

You can also use `direnv` with a `.envrc` file for automatic shell activation:

```bash
# In your project directory
echo "use flake" > .envrc
direnv allow
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
| mangowc | DreamMaoMao/mangowc |

## Host Details

### bayle (Custom PC)
- NVIDIA proprietary drivers (production)
- Hyprland + MangoWC compositors
- Emacs server, Tailscale
- SSH enabled

### messmer (Framework Desktop)
- AMD GPU with ROCm tools
- Niri compositor
- Kernel 6.18
- Podman (Docker-compatible)
- Ollama LLM server

### framework (Framework 13)
- nixos-hardware Framework 13 7040 AMD module
- Niri + Hyprland (both enabled)
- Fingerprint authentication
- Printing support, Tailscale

## MangoWC Configuration

[MangoWC](https://github.com/DreamMaoMao/mangowc) is a wlroots-based Wayland compositor, added as a flake input and enabled on **bayle** alongside Hyprland. The configuration lives in `config/mango/` and is deployed to `~/.config/mango` via Home Manager.

### Config Files

| File | Purpose |
|------|---------|
| `config.conf` | Main config: monitors, layouts, keybinds, window rules, theming |
| `autostart.sh` | Launches swww daemon and sets a random wallpaper on startup |
| `change-wallpaper.sh` | Randomly picks a wallpaper with swww wipe transition (bound to `SUPER+w`) |
| `hypridle.conf` | Idle management: hyprlock at 5min, DPMS off at 5.5min, suspend at 10min |

### Monitor Setup

- **DP-2**: Main landscape 4K (3840x2160) at 120Hz with VRR
- **DP-3**: Vertical portrait 4K (3840x2160) at 60Hz, rotated 270 degrees
- **eDP-1**: Laptop fallback (2880x1920) at 120Hz, scaled 1.6x

### Layouts

- **Tile** (master-stack): Used on DP-2 (tags 1-8) with 55/45 master ratio
- **Vertical scroller**: Used on DP-3 for the portrait monitor, windows occupy 1/3 screen height
- **Monocle**: Used on tag 9 (DP-2) for fullscreen gaming

### Theming

Dracula color scheme matching the rest of the desktop:
- Focus border: `#bd93f9` (purple)
- Inactive border: `#6272a4` (muted blue)
- Urgent: `#ff5555` (red)
- Background: `#1a1a2e`

### Key Bindings

| Binding | Action |
|---------|--------|
| `SUPER+Return` | Ghostty terminal |
| `SUPER+q` | Close window |
| `SUPER+p` | Rofi launcher |
| `SUPER+h/j/k/l` | Focus direction (vim keys) |
| `SUPER+SHIFT+h/j/k/l` | Swap windows |
| `SUPER+CTRL+h/j/k/l` | Resize windows |
| `SUPER+1-9` | Switch tag |
| `SUPER+SHIFT+1-9` | Move window to tag |
| `SUPER+ALT+h/l` | Focus monitor |
| `SUPER+d` | Toggle fullscreen |
| `SUPER+m` | Toggle maximize |
| `SUPER+v` | Toggle floating |
| `SUPER+Tab` | Overview |
| `SUPER+w` | Random wallpaper |
| `Print` | Screenshot (grim + slurp + swappy) |

### Enabling MangoWC

MangoWC is toggled per-host in `modules/system/desktop.nix` via the `desktop.enableMango` option. To enable it on a host, import the `mangowc.nixosModules.mango` flake module and set:

```nix
desktop.enableMango = true;
```

The compositor will appear as a session option in greetd/tuigreet.
