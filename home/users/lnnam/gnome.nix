{ pkgs, lib, ... }:

let
  gnomePkgs = with pkgs; [
    gnome-tweaks # gnome customization tool
    gnome-extension-manager # manage gnome extensions
    gnomeExtensions.dash-to-dock # dock extension
    gnomeExtensions.appindicator # tray icons
    gnomeExtensions.clipboard-indicator # clipboard manager
    gnomeExtensions.caffeine # prevent screen blanking
    gnomeExtensions.vitals # system monitor
  ];

  utilityPkgs = with pkgs; [
    dconf-editor # advanced gnome settings
    pavucontrol # pulseaudio volume control
    playerctl # music player controller
  ];
in
{
  imports = [
    ./shared.nix
  ];

  home = {
    stateVersion = "24.05";
    packages = gnomePkgs ++ utilityPkgs;
  };

  # GNOME dconf settings
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "gnome-terminal";
      name = "Open Terminal";
    };

    # Shell extensions
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "clipboard-indicator@tudmotu.com"
        "caffeine@patapon.info"
        "Vitals@CoreCoding.com"
      ];
    };

    # Dash to Dock settings
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      dash-max-icon-size = 48;
      show-trash = false;
      show-mounts = false;
    };
  };

  # GTK theme configuration
  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
}
