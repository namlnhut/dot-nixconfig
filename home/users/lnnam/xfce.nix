{ pkgs, ... }:

let
  xfcePkgs = with pkgs; [
    xfce.xfce4-pulseaudio-plugin # pulseaudio plugin for xfce4 panel
    xfce.xfce4-battery-plugin # battery plugin for xfce4 panel
    xfce.xfce4-clipman-plugin # clipboard manager for xfce4 panel
    xfce.xfce4-whiskermenu-plugin # modern menu for xfce4
    xfce.xfce4-weather-plugin # weather plugin for xfce4 panel
    xfce.xfce4-screenshooter # screenshot tool
    xfce.xfce4-taskmanager # task manager
    xfce.thunar-archive-plugin # archive plugin for thunar
    xfce.thunar-volman # volume manager for thunar
    pavucontrol # pulseaudio volume control
    playerctl # music player controller
    networkmanagerapplet # network manager applet
  ];

  utilityPkgs = with pkgs; [
    arandr # simple GUI for xrandr
    brightnessctl # control laptop display brightness
    flameshot # screenshot tool
    libnotify # notifications
    xclip # clipboard support
    xsel # clipboard support
  ];
in
{
  imports = [
    ./shared.nix
  ];

  home = {
    stateVersion = "24.05";
    packages = xfcePkgs ++ utilityPkgs;
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

  # Simple X session variables
  home.sessionVariables = {
    # Keep the defaults from shared.nix
  };
}
