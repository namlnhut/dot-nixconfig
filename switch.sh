#! /usr/bin/env bash

# Shows the output of every command
set +x

# Parse command-line flags
BACKUP_ENABLED=false

while [[ $1 == -* ]]; do
  case $1 in
    -b|--backup)
      BACKUP_ENABLED=true
      shift
      ;;
    -h|--help)
      # Just shift and let the default case handle showing help
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

CONFIG_NAME=$1

activate_hm() {
  if [ "$BACKUP_ENABLED" = true ]; then
    backup_configs "$CONFIG_NAME" || {
      read -p "[PROMPT] Backup failed. Continue anyway? (y/n) " -n 1 -r
      echo
      if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "[ABORT] Switch cancelled"
        exit 1
      fi
    }
  fi

  result/activate
}

# Get WM type from config name
get_wm_type() {
  local config=$1
  case $config in
    *xmonad*) echo "xmonad" ;;
    *hyprland*) echo "hyprland" ;;
    *niri*) echo "niri" ;;
    *gnome*) echo "gnome" ;;
    *xfce*) echo "xfce" ;;
    *) echo "unknown" ;;
  esac
}

# Get directories to backup for specific WM
get_backup_dirs() {
  local wm=$1
  case $wm in
    xmonad)
      echo "polybar rofi dunst autorandr alacritty picom"
      ;;
    hyprland)
      echo "hyprland waybar swaync foot hyprlock hyprpaper rofi"
      ;;
    niri)
      echo "niri waybar swaync foot"
      ;;
    xfce)
      echo "xfce4"
      ;;
    gnome)
      echo "dconf"
      ;;
    *)
      echo ""
      ;;
  esac
}

# Main backup function
backup_configs() {
  local config_name=$1
  local wm_type=$(get_wm_type "$config_name")

  if [ "$wm_type" = "unknown" ]; then
    echo "[INFO] Not a WM configuration, skipping backup"
    return 0
  fi

  local timestamp=$(date +%Y-%m-%d-%H-%M-%S)
  local backup_root="$HOME/.config-backups"
  local backup_dir="$backup_root/$config_name/backup-$timestamp"

  echo "[INFO] Creating backup for $config_name..."
  echo "[INFO] Backup location: $backup_dir"

  mkdir -p "$backup_dir"

  # Backup common configs (nvim, git, etc.)
  local common_dirs="nvim fish tmux"

  # Backup WM-specific configs
  local wm_dirs=$(get_backup_dirs "$wm_type")

  local all_dirs="$common_dirs $wm_dirs"
  local backed_up=""
  local backup_size=0

  for dir in $all_dirs; do
    if [ -d "$HOME/.config/$dir" ]; then
      echo "  Backing up $dir..."
      cp -r "$HOME/.config/$dir" "$backup_dir/"
      backed_up="$backed_up $dir"
    fi
  done

  # Create metadata file
  cat > "$backup_dir/metadata.txt" << EOF
CONFIG: $config_name
WM_TYPE: $wm_type
TIMESTAMP: $(date '+%Y-%m-%d %H:%M:%S')
BACKED_UP_DIRS:$backed_up
STATUS: success
EOF

  # Calculate backup size
  backup_size=$(du -sh "$backup_dir" | cut -f1)
  echo "[INFO] Backup created successfully (size: $backup_size)"

  # Cleanup old backups (keep last 5)
  cleanup_old_backups "$config_name" 5

  return 0
}

# Cleanup old backups
cleanup_old_backups() {
  local config_name=$1
  local keep_count=${2:-5}
  local backup_root="$HOME/.config-backups/$config_name"

  if [ ! -d "$backup_root" ]; then
    return 0
  fi

  local backup_count=$(find "$backup_root" -maxdepth 1 -type d -name "backup-*" | wc -l)

  if [ "$backup_count" -gt "$keep_count" ]; then
    echo "[INFO] Cleaning up old backups (keeping last $keep_count)..."
    find "$backup_root" -maxdepth 1 -type d -name "backup-*" | \
      sort | \
      head -n -$keep_count | \
      xargs rm -rf
  fi
}

rebuild_xmonad_edp() {
  nom build .#homeConfigurations.xmonad-edp.activationPackage
  activate_hm
}

rebuild_xmonad_hdmi() {
  nom build .#homeConfigurations.xmonad-hdmi.activationPackage
  activate_hm
}

rebuild_hyprland_edp() {
  nom build .#homeConfigurations.hyprland-edp.activationPackage
  activate_hm
}

rebuild_hyprland_hdmi() {
  nom build .#homeConfigurations.hyprland-hdmi.activationPackage
  activate_hm
}

rebuild_hyprland_hdmi_mutable() {
  nom build .#homeConfigurations.hyprland-hdmi-mutable.activationPackage
  activate_hm
}

rebuild_niri_edp() {
  nom build .#homeConfigurations.niri-edp.activationPackage
  activate_hm
}

rebuild_niri_hdmi() {
  nom build .#homeConfigurations.niri-hdmi.activationPackage
  activate_hm
}

# lnnam user configurations
rebuild_lnnam_xfce() {
  nom build .#homeConfigurations.lnnam-xfce.activationPackage
  activate_hm
}

rebuild_lnnam_xmonad() {
  nom build .#homeConfigurations.lnnam-xmonad.activationPackage
  activate_hm
}

rebuild_lnnam_niri() {
  nom build .#homeConfigurations.lnnam-niri.activationPackage
  activate_hm
}

rebuild_lnnam_hyprland() {
  nom build .#homeConfigurations.lnnam-hyprland.activationPackage
  activate_hm
}

rebuild_lnnam_gnome() {
  nom build .#homeConfigurations.lnnam-gnome.activationPackage
  activate_hm
}

rebuild_msi() {
  sudo nixos-rebuild switch --flake .#msi-gl63
}

rebuild_thinkpad() {
  sudo nixos-rebuild switch --flake .#thinkpad-x1
}

rebuild_tongfang() {
  # nix build .#nixosConfigurations.tongfang-amd.config.system.build.toplevel
  # sudo result/bin/switch-to-configuration switch
  sudo nixos-rebuild switch --flake .#tongfang-amd
}

rebuild_tongfang_vm() {
  nixos-rebuild build-vm --flake .#tongfang-amd
}

case $CONFIG_NAME in
  # Original gvolpe configurations
  "niri")
    rebuild_niri_hdmi;;
  "niri-edp")
    rebuild_niri_edp;;
  "xmedp")
    rebuild_xmonad_edp;;
  "xmhdmi")
    rebuild_xmonad_hdmi;;
  "hpedp")
    rebuild_hyprland_edp;;
  "hphdmi")
    rebuild_hyprland_hdmi;;
  "hphdmi-mutable")
    rebuild_hyprland_hdmi_mutable;;
  # lnnam user home configurations
  "lnnam-xfce")
    rebuild_lnnam_xfce;;
  "lnnam-xmonad")
    rebuild_lnnam_xmonad;;
  "lnnam-niri")
    rebuild_lnnam_niri;;
  "lnnam-hyprland")
    rebuild_lnnam_hyprland;;
  "lnnam-gnome")
    rebuild_lnnam_gnome;;
  # System configurations
  "msi")
    rebuild_msi;;
  "thinkpad")
    rebuild_thinkpad;;
  "tongfang")
    rebuild_tongfang;;
  "vm")
    rebuild_tongfang_vm;;
  # Utilities
  "update-fish")
    fish -c fish_update_completions;;
  "update-nix-index")
    nix-index --filter-prefix '/bin/';;
  *)
    echo "Usage: ./switch.sh [-b] [OPTION]"
    echo ""
    echo "Flags:"
    echo "  -b, --backup    Create timestamped backup before switching"
    echo ""
    echo "Examples:"
    echo "  ./switch.sh lnnam-xmonad           - Switch without backup"
    echo "  ./switch.sh -b lnnam-hyprland      - Backup then switch"
    echo ""
    echo "lnnam user configurations:"
    echo "  lnnam-xfce      - Switch to XFCE desktop environment"
    echo "  lnnam-xmonad    - Switch to XMonad window manager"
    echo "  lnnam-niri      - Switch to Niri compositor"
    echo "  lnnam-hyprland  - Switch to Hyprland compositor"
    echo "  lnnam-gnome     - Switch to GNOME desktop environment"
    echo ""
    echo "System configurations:"
    echo "  msi             - Rebuild msi-gl63 system"
    echo "  thinkpad        - Rebuild thinkpad-x1 system"
    echo "  tongfang        - Rebuild tongfang-amd system"
    echo "  vm              - Build tongfang-amd VM"
    echo ""
    echo "Original gvolpe configurations:"
    echo "  niri            - Switch to Niri (hdmi)"
    echo "  niri-edp        - Switch to Niri (edp)"
    echo "  xmedp           - Switch to XMonad (edp)"
    echo "  xmhdmi          - Switch to XMonad (hdmi)"
    echo "  hpedp           - Switch to Hyprland (edp)"
    echo "  hphdmi          - Switch to Hyprland (hdmi)"
    echo "  hphdmi-mutable  - Switch to Hyprland (hdmi, mutable)"
    echo ""
    echo "Utilities:"
    echo "  update-fish     - Update fish completions"
    echo "  update-nix-index - Update nix-index"
    ;;
esac
