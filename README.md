<div align="center">

<img alt="NixOS" src="https://raw.githubusercontent.com/NixOS/nixos-artwork/9d2cdedd73d64a068214482902adea3d02783ba8/logo/nix-snowflake-rainbow.svg" width="140px"/>

# :space_invader: NixOS Config :space_invader:

[![ci-badge](https://img.shields.io/static/v1?label=Built%20with&message=nix&color=blue&style=flat&logo=nixos&link=https://nixos.org&labelColor=111212)](https://lnhutnam.github.io)
[![Home](https://github.com/namlnhut/dot-nixconfig/actions/workflows/home.yml/badge.svg)](https://github.com/namlnhut/dot-nixconfig/actions/workflows/home.yml)
[![NixOS](https://github.com/namlnhut/dot-nixconfig/actions/workflows/nixos.yml/badge.svg)](https://github.com/namlnhut/dot-nixconfig/actions/workflows/nixos.yml)
[![garnix](https://img.shields.io/endpoint?url=https%3A%2F%2Fgarnix.io%2Fapi%2Fbadges%2Fnamlnhut%2Fdot-nixconfig%3Fbranch%3Dmain)](https://garnix.io)

My current — and always evolving — [NixOS](https://nixos.org/) and [Home Manager](https://github.com/nix-community/home-manager/) configurations.

</div>

## :pray: Acknowledgments

This configuration is based on the excellent work by [Gabriel Volpe (@gvolpe)](https://github.com/gvolpe).

**Original repository:** [gvolpe/nix-config](https://github.com/gvolpe/nix-config)

Special thanks to Gabriel for creating such a well-structured, modular, and comprehensive NixOS configuration that serves as an excellent foundation for learning and building upon. His work has been invaluable in helping me understand the power and flexibility of NixOS and Nix flakes.

## :desktop_computer: My Configurations

This repository contains configurations for multiple window managers and desktop environments, all managed declaratively with Nix.

### Supported Systems

- **msi-gl63** - My main MSI GL63 laptop

### Available Environments

#### :globe_with_meridians: Desktop Environments

**XFCE** - Traditional, lightweight desktop
- XFCE panel with plugins (pulseaudio, battery, clipman, whiskermenu)
- Thunar file manager
- LightDM display manager

**GNOME** - Modern, polished desktop
- GNOME Shell with extensions (dash-to-dock, appindicator, vitals)
- GTK4 applications
- GDM display manager

#### :window: Window Managers

**XMonad** - Tiling window manager (X11)
- Haskell-based configuration
- Polybar status bar
- Rofi launcher, Dunst notifications
- Alacritty terminal

**Hyprland** - Dynamic tiling Wayland compositor
- Modern Wayland compositor
- Waybar status bar
- Wofi launcher, Foot terminal
- Full animations and effects

**Niri** - Scrollable tiling Wayland compositor
- Unique scrollable workspace paradigm
- Waybar status bar
- Fuzzel launcher, Kitty terminal
- SwayNC notifications

## :rocket: Quick Start

### Switch Home Manager Configuration

Use the convenient switch script:

```bash
cd nix-config

# Switch to XFCE
./switch.sh lnnam-xfce

# Switch to XMonad
./switch.sh lnnam-xmonad

# Switch to Niri
./switch.sh lnnam-niri

# Switch to Hyprland
./switch.sh lnnam-hyprland

# Switch to GNOME
./switch.sh lnnam-gnome
```

### Rebuild System Configuration

```bash
cd nix-config

# Rebuild MSI GL63 system
./switch.sh msi

# Or manually
sudo nixos-rebuild switch --flake .#msi-gl63
```

### Manual Home Manager Switch

```bash
home-manager switch --flake .#lnnam-xfce
home-manager switch --flake .#lnnam-xmonad
home-manager switch --flake .#lnnam-niri
home-manager switch --flake .#lnnam-hyprland
home-manager switch --flake .#lnnam-gnome
```

## :page_facing_up: Structure

[![diagram](imgs/diagram.png)](https://excalidraw.com/#json=HN_V0f2FpcX4YZPR-FKzO,MJR6ILT6va5BZ0r5Yo41Zw)

### Directory Layout

```
nix-config/
├── flake.nix              # Main flake configuration
├── switch.sh              # Convenient switch script
├── home/                  # Home Manager configurations
│   ├── users/
│   │   └── lnnam/        # My user configurations
│   │       ├── shared.nix      # Shared settings
│   │       ├── xfce.nix        # XFCE config
│   │       ├── xmonad.nix      # XMonad config
│   │       ├── niri.nix        # Niri config
│   │       ├── hyprland.nix    # Hyprland config
│   │       └── gnome.nix       # GNOME config
│   ├── wm/               # Window manager configs
│   ├── programs/         # Program configurations
│   └── services/         # Service configurations
├── system/               # NixOS system configurations
│   ├── configuration.nix # Main system config
│   ├── machine/
│   │   └── msi-gl63/    # MSI GL63 laptop config
│   │       ├── default.nix
│   │       └── hardware-configuration.nix
│   └── wm/              # System-level WM configs
│       ├── xfce.nix
│       ├── xmonad.nix
│       ├── niri.nix
│       ├── hyprland.nix
│       └── gnome.nix
└── outputs/             # Flake outputs
    ├── os.nix          # NixOS configurations
    └── hm.nix          # Home Manager configurations
```

## :package: Flake Outputs

<details>
<summary>Expand to see available outputs</summary>

### Home Configurations

**lnnam user configurations:**
- `lnnam-xfce` - XFCE desktop environment
- `lnnam-xmonad` - XMonad window manager
- `lnnam-niri` - Niri scrollable compositor
- `lnnam-hyprland` - Hyprland dynamic tiling compositor
- `lnnam-gnome` - GNOME desktop environment

**Original gvolpe configurations** (maintained for reference):
- `hyprland-edp` - Hyprland for laptop display
- `hyprland-hdmi` - Hyprland for external display
- `hyprland-hdmi-mutable` - Hyprland (mutable dotfiles)
- `xmonad-edp` - XMonad for laptop display
- `xmonad-hdmi` - XMonad for external display
- `niri-edp` - Niri for laptop display
- `niri-hdmi` - Niri for external display

### NixOS Configurations

**My systems:**
- `msi-gl63` - MSI GL63 laptop (XMonad by default)

**Original gvolpe systems** (maintained for reference):
- `dell-xps` - Dell XPS 15 9560
- `thinkpad-x1` - ThinkPad X1 Carbon
- `tongfang-amd` - Tongfang AMD laptop
- `xmod` - Custom configuration

### Packages

```console
$ nix flake show
├───homeConfigurations
│   ├───lnnam-gnome: Home Manager configuration
│   ├───lnnam-hyprland: Home Manager configuration
│   ├───lnnam-niri: Home Manager configuration
│   ├───lnnam-xfce: Home Manager configuration
│   ├───lnnam-xmonad: Home Manager configuration
│   ├───hyprland-edp: Home Manager configuration
│   ├───hyprland-hdmi: Home Manager configuration
│   ├───hyprland-hdmi-mutable: Home Manager configuration
│   ├───niri-edp: Home Manager configuration
│   ├───niri-hdmi: Home Manager configuration
│   ├───xmonad-edp: Home Manager configuration
│   └───xmonad-hdmi: Home Manager configuration
├───nixosConfigurations
│   ├───msi-gl63: NixOS configuration
│   ├───dell-xps: NixOS configuration
│   ├───thinkpad-x1: NixOS configuration
│   ├───tongfang-amd: NixOS configuration
│   └───xmod: NixOS configuration
└───packages
    └───x86_64-linux
        ├───bazecor: package
        ├───metals: package
        ├───metals-updater: package
        ├───neovim: package
        └───...
```

</details>

## :wrench: Configuration Details

### System Features

- **Locale**: English (US) with Vietnamese regional formats
- **Timezone**: Asia/Ho_Chi_Minh
- **Bootloader**: systemd-boot with UEFI
- **Audio**: PipeWire with ALSA/PulseAudio compatibility
- **Network**: NetworkManager with OpenVPN support
- **Virtualization**: Docker with auto-pruning
- **Nix**: Flakes enabled, automatic garbage collection

### User Setup

- **User**: lnnam
- **Shell**: Fish
- **Groups**: wheel, networkmanager, docker, scanner, lp
- **Home Manager**: Separate configurations per environment

### Binary Caches

- **cache.nixos.org** - Official NixOS cache
- **cache.garnix.io** - Garnix CI cache (free builds)
- **namlnhut.cachix.org** - Personal Cachix cache

## :hammer_and_wrench: Installation

### Fresh NixOS Install

1. Boot from NixOS installation media
2. Partition and format your disk
3. Generate hardware configuration:
   ```bash
   nixos-generate-config --root /mnt
   ```
4. Clone this repository:
   ```bash
   git clone https://github.com/namlnhut/nix-config.git /mnt/etc/nixos/nix-config
   ```
5. Copy your hardware-configuration.nix:
   ```bash
   cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/nix-config/system/machine/msi-gl63/
   ```
6. Install:
   ```bash
   nixos-install --flake /mnt/etc/nixos/nix-config#msi-gl63
   ```

### Existing NixOS System

1. Clone this repository
2. Update hardware-configuration.nix for your machine
3. Build and switch:
   ```bash
   sudo nixos-rebuild switch --flake .#msi-gl63
   ```
4. Install Home Manager configuration:
   ```bash
   home-manager switch --flake .#lnnam-xmonad
   ```

## :computer: Environment Details

### Common Components

| Component | Program |
|-----------|---------|
| Editor | [NeoVim](https://neovim.io/) |
| Shell | [Fish](https://fishshell.com/) |
| Browser | [Firefox](https://www.mozilla.org/firefox/) |
| File Manager | Nautilus (XMonad), Nemo (Wayland), Thunar (XFCE) |
| Terminal Font | [JetBrainsMono Nerd Font](https://www.jetbrains.com/lp/mono/) |

### XFCE Setup

- **Display Manager**: LightDM
- **Panel**: XFCE Panel with plugins
- **Launcher**: Whisker Menu
- **Terminal**: XFCE Terminal
- **Screenshot**: Flameshot

### XMonad Setup

- **Status Bar**: Polybar
- **Launcher**: Rofi
- **Terminal**: Alacritty
- **Compositor**: Picom
- **Notifications**: Dunst
- **Screen Locker**: Multilockscreen

### Niri Setup

- **Status Bar**: Waybar
- **Launcher**: Fuzzel
- **Terminal**: Kitty
- **Notifications**: SwayNC
- **Wallpaper**: Waypaper + Hyprlax
- **Special Tools**: niri-scratchpad, nfsm

### Hyprland Setup

- **Status Bar**: Waybar
- **Launcher**: Wofi
- **Terminal**: Foot
- **Notifications**: Dunst
- **Screen Locker**: Hyprlock
- **Idle Manager**: Hypridle
- **Plugins**: Pyprland

### GNOME Setup

- **Display Manager**: GDM
- **Extensions**: Dash to Dock, AppIndicator, Vitals, Caffeine
- **File Manager**: Nautilus
- **Terminal**: GNOME Terminal

## :arrows_counterclockwise: Switching Between Environments

The switch.sh script makes it easy to switch between different environments:

```bash
# List all available options
./switch.sh

# Home Manager configurations
./switch.sh lnnam-xfce       # Switch to XFCE
./switch.sh lnnam-xmonad     # Switch to XMonad
./switch.sh lnnam-niri       # Switch to Niri
./switch.sh lnnam-hyprland   # Switch to Hyprland
./switch.sh lnnam-gnome      # Switch to GNOME

# System rebuild
./switch.sh msi              # Rebuild msi-gl63 system

# Utilities
./switch.sh update-fish      # Update fish completions
./switch.sh update-nix-index # Update nix-index database
```

## :gear: Customization

### Adding a New Machine

1. Generate hardware configuration:
   ```bash
   sudo nixos-generate-config --dir ./system/machine/my-machine
   ```

2. Create machine configuration:
   ```nix
   # system/machine/my-machine/default.nix
   { pkgs, ... }: {
     imports = [
       ./hardware-configuration.nix
       ../../wm/xmonad.nix  # Choose your WM
     ];

     networking.hostName = "my-machine";
     # Add machine-specific settings
   }
   ```

3. Add to outputs/os.nix:
   ```nix
   hosts = [ ... "my-machine" ];
   ```

### Changing Window Manager

Edit your machine's default.nix:
```nix
imports = [
  ./hardware-configuration.nix
  ../../wm/xfce.nix     # or xmonad.nix, niri.nix, hyprland.nix, gnome.nix
];
```

## :books: Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
- [Original gvolpe/nix-config](https://github.com/gvolpe/nix-config) - The foundation of this config

## :memo: LICENSE

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this project except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
