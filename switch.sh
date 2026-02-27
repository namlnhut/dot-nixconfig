#! /usr/bin/env bash

# Shows the output of every command
set +x

activate_hm() {
  result/activate
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

case $1 in
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
    echo "Usage: ./switch.sh [OPTION]"
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
