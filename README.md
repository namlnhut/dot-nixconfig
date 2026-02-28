<div align="center">

<img alt="NixOS" src="https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/logo/nix-snowflake-colours.svg" width="140px"/>

# NixOS Config

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

### System & Home Manager Rebuild

**System and Home Manager are managed separately** for better control:

```bash
cd ~/Sync/Config/Nix/nix-config

# 1. Rebuild system configuration ONLY (no home-manager)
sudo nixos-rebuild switch --flake .#msi-gl63
# Or use: ./switch.sh msi

# 2. Switch home-manager configuration for your preferred environment
./switch.sh lnnam-xmonad     # XMonad window manager
./switch.sh lnnam-hyprland   # Hyprland compositor
./switch.sh lnnam-niri       # Niri scrollable compositor
./switch.sh lnnam-gnome      # GNOME desktop
./switch.sh lnnam-xfce       # XFCE desktop
```

**Benefits of this approach:**
- System changes (kernel, services, packages) are separate from user environment
- Quickly switch between different window managers without system rebuild
- More granular control over what gets updated

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

### NixOS Configurations (System Level)

**Note:** These configure system-level services only. Use `switch.sh` for home-manager.

- `msi-gl63` - MSI GL63 laptop (system configuration only)
  - Change system WM services by editing `selectedWM` in `system/machine/msi-gl63/default.nix`
  - Rebuild with: `sudo nixos-rebuild switch --flake .#msi-gl63`
  - Then apply user config: `./switch.sh lnnam-<wm>`

**Original gvolpe systems** (maintained for reference):
- `dell-xps` - Dell XPS 15 9560
- `thinkpad-x1` - ThinkPad X1 Carbon
- `tongfang-amd` - Tongfang AMD laptop
- `xmod` - Custom configuration

### Standalone Home Configurations

**Note:** Use these configurations with the `switch.sh` script to manage your user environment.

**lnnam user configurations:**
- `lnnam-xfce` - XFCE desktop environment
- `lnnam-xmonad` - XMonad window manager
- `lnnam-niri` - Niri scrollable compositor
- `lnnam-hyprland` - Hyprland dynamic tiling compositor
- `lnnam-gnome` - GNOME desktop environment

**Original gvolpe configurations:**
- `hyprland-edp` - Hyprland for laptop display
- `hyprland-hdmi` - Hyprland for external display
- `hyprland-hdmi-mutable` - Hyprland (mutable dotfiles)
- `xmonad-edp` - XMonad for laptop display
- `xmonad-hdmi` - XMonad for external display
- `niri-edp` - Niri for laptop display
- `niri-hdmi` - Niri for external display

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

### Separated System & Home Manager

This configuration uses **separated system and home-manager** for better control:

- ✅ **Granular control**: System and user configurations managed independently
- ✅ **Fast WM switching**: Use `./switch.sh lnnam-<wm>` to switch window managers without system rebuild
- ✅ **System-only updates**: `nixos-rebuild` only handles system-level configuration
- ✅ **Automatic backups**: Files are backed up with `.backup` extension when conflicts occur (in switch.sh)
- ✅ **Mutable dotfiles**: Symlinks point to `~/Sync/Config/Nix/nix-config/home/` for easy editing

Key configuration files:
- `outputs/os.nix` - NixOS system configurations (home-manager module NOT imported)
- `outputs/hm.nix` - Standalone home-manager configurations
- `system/machine/msi-gl63/default.nix:6` - **`selectedWM` variable controls system-level WM services**
- `switch.sh` - Script to switch between home-manager configurations
- `home/users/lnnam/shared.nix:53` - **`dotfiles.path`** configured for correct symlinks

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
   git clone https://github.com/namlnhut/dot-nixconfig.git /mnt/etc/nixos/nix-config
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

1. Clone this repository:
   ```bash
   git clone https://github.com/namlnhut/dot-nixconfig.git ~/Sync/Config/Nix/nix-config
   cd ~/Sync/Config/Nix/nix-config
   ```

2. Update hardware-configuration.nix for your machine:
   ```bash
   sudo nixos-generate-config --show-hardware-config > system/machine/msi-gl63/hardware-configuration.nix
   ```

3. (Optional) Choose your preferred window manager by editing `system/machine/msi-gl63/default.nix`:
   ```nix
   selectedWM = "xmonad";  # or "niri", "gnome", "hyprland", "xfce"
   ```

4. Build system configuration:
   ```bash
   sudo nixos-rebuild switch --flake .#msi-gl63
   ```

5. Apply home-manager configuration:
   ```bash
   ./switch.sh lnnam-xmonad  # Or your preferred WM
   # With backup: ./switch.sh -b lnnam-xmonad
   ```

System and Home Manager are now separated for better control!

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

## :arrows_counterclockwise: Switching Between Window Managers

### Two-Step Process

This configuration separates system and user configurations for better control:

#### Step 1: System Configuration (Optional)

If you want to change system-level WM services, edit `system/machine/msi-gl63/default.nix` (line 6):

```nix
# Choose your window manager: "xmonad" | "niri" | "gnome" | "hyprland" | "xfce"
selectedWM = "niri";  # This controls system-level services
```

Then rebuild:
```bash
sudo nixos-rebuild switch --flake .#msi-gl63
# Or: ./switch.sh msi
```

This updates:
- ✅ System-level WM packages (display managers, system services)
- ✅ X11/Wayland configuration
- ❌ **Does NOT** update user dotfiles or home-manager

#### Step 2: Home Manager Configuration (Required)

To actually switch your user environment, use the switch script:

```bash
cd ~/Sync/Config/Nix/nix-config

./switch.sh lnnam-xmonad     # Switch to XMonad
./switch.sh lnnam-niri       # Switch to Niri
./switch.sh lnnam-gnome      # Switch to GNOME
./switch.sh lnnam-hyprland   # Switch to Hyprland
./switch.sh lnnam-xfce       # Switch to XFCE

# With backup (recommended)
./switch.sh -b lnnam-hyprland
```

This updates:
- ✅ User dotfiles and configurations
- ✅ WM-specific programs (waybar, polybar, etc.)
- ✅ Application settings
- ✅ Creates backups with `.backup` extension (if `-b` flag used)

### Available Window Managers

| WM | Type | System Config | Home Config |
|----|------|---------------|-------------|
| **XMonad** | Tiling (X11) | `"xmonad"` | `lnnam-xmonad` |
| **Niri** | Scrollable (Wayland) | `"niri"` | `lnnam-niri` |
| **GNOME** | Desktop (Wayland) | `"gnome"` | `lnnam-gnome` |
| **Hyprland** | Dynamic Tiling (Wayland) | `"hyprland"` | `lnnam-hyprland` |
| **XFCE** | Desktop (X11) | `"xfce"` | `lnnam-xfce` |

### Switch Script Commands

```bash
# System configurations
./switch.sh msi              # Rebuild msi-gl63 system only

# Home Manager configurations
./switch.sh lnnam-xmonad     # Switch to XMonad
./switch.sh lnnam-niri       # Switch to Niri
./switch.sh lnnam-gnome      # Switch to GNOME
./switch.sh lnnam-hyprland   # Switch to Hyprland
./switch.sh lnnam-xfce       # Switch to XFCE

# With backup flag
./switch.sh -b lnnam-hyprland

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

2. Create machine configuration (system-level only):
   ```nix
   # system/machine/my-machine/default.nix
   { pkgs, inputs, ... }:

   let
     # Choose your window manager: "xmonad" | "niri" | "gnome" | "hyprland" | "xfce"
     selectedWM = "xmonad";

     wmConfigs = {
       xmonad = ../../wm/xmonad.nix;
       niri = ../../wm/niri.nix;
       gnome = ../../wm/gnome.nix;
       hyprland = ../../wm/hyprland.nix;
       xfce = ../../wm/xfce.nix;
     };

     currentWM = wmConfigs.${selectedWM};
   in
   {
     imports = [
       ./hardware-configuration.nix
       currentWM  # System-level WM configuration only
     ];

     networking.hostName = "my-machine";

     # Boot loader
     boot = {
       kernelPackages = pkgs.linuxPackages_latest;
       loader = {
         systemd-boot.enable = true;
         efi.canTouchEfiVariables = true;
       };
     };

     # Additional system-level configuration
     time.timeZone = "Asia/Ho_Chi_Minh";
     i18n.defaultLocale = "en_US.UTF-8";

     system.stateVersion = "24.11";
   }
   ```

3. Add to outputs/os.nix:
   ```nix
   hosts = [ ... "my-machine" ];
   ```

4. Build system:
   ```bash
   sudo nixos-rebuild switch --flake .#my-machine
   ```

5. Apply home-manager configuration:
   ```bash
   ./switch.sh lnnam-xmonad  # Or your preferred WM
   ```

### Changing Window Manager

The configuration uses a **two-level approach**:

#### Level 1: System Configuration (Optional)

Change system-level WM services in `system/machine/msi-gl63/default.nix`:

```nix
# system/machine/msi-gl63/default.nix
{ pkgs, inputs, ... }:

let
  # Choose your window manager: "xmonad" | "niri" | "gnome" | "hyprland" | "xfce"
  selectedWM = "niri";  # Controls system-level services only

  wmConfigs = {
    xmonad = ../../wm/xmonad.nix;
    niri = ../../wm/niri.nix;
    gnome = ../../wm/gnome.nix;
    hyprland = ../../wm/hyprland.nix;
    xfce = ../../wm/xfce.nix;
  };

  currentWM = wmConfigs.${selectedWM};
in
{
  imports = [
    ./hardware-configuration.nix
    currentWM  # System-level only (display managers, system services)
  ];

  # ... rest of system config
}
```

Rebuild system:
```bash
sudo nixos-rebuild switch --flake .#msi-gl63
```

#### Level 2: User Configuration (Required)

Apply home-manager configuration:

```bash
./switch.sh lnnam-niri       # Switch to Niri user environment
./switch.sh -b lnnam-niri    # With backup
```

**Benefits of this approach:**
- ✅ System and user configs are independent
- ✅ Fast user environment switching without system rebuild
- ✅ Can test different WMs without affecting system stability
- ✅ Rollback user changes independently from system

## :wrench: Troubleshooting

### File Conflicts When Switching WMs

When you see errors like:
```
Existing file '/home/lnnam/.config/foo' would be clobbered
```

**Solution:** Use the `-b` flag with switch.sh to automatically backup conflicting files:

```bash
./switch.sh -b lnnam-hyprland
```

This will backup existing files with `.backup` extension before creating new symlinks.

Check backed up files:
```bash
find ~/.config ~/.mozilla -name "*.backup" -type f 2>/dev/null
```

### Symlinks Not Pointing to Correct Path

If symlinks point to `~/workspace/nix-config/` instead of `~/Sync/Config/Nix/nix-config/`:

**Solution:** This is configured in `home/users/lnnam/shared.nix:53`:
```nix
dotfiles.path = "${homeDirectory}/Sync/Config/Nix/nix-config/home";
```

Rebuild home-manager to apply:
```bash
./switch.sh lnnam-xmonad  # Or your current WM
```

### Check Current WM Configuration

To see which WM is currently selected:
```bash
cat system/machine/msi-gl63/default.nix | grep selectedWM
```

To verify symlinks are correct:
```bash
# For Niri
ls -la ~/.config/niri/config.kdl

# For Hyprland
ls -la ~/.config/hypr/

# For XMonad
ls -la ~/.config/xmonad/
```

## :books: Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
- [Original gvolpe/nix-config](https://github.com/gvolpe/nix-config) - The foundation of this config

## :memo: LICENSE

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this project except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
