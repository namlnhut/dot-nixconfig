{ pkgs, lib, ... }:

let
  nerdFonts = with (pkgs.nerd-fonts); [
    jetbrains-mono
    iosevka
  ];

  fontPkgs = with pkgs; [
    font-awesome # awesome fonts
    material-design-icons # fonts with glyphs
  ] ++ nerdFonts;

  audioPkgs = with pkgs; [
    paprefs # pulseaudio preferences
    pasystray # pulseaudio systray
    pavucontrol # pulseaudio volume control
    playerctl # music player controller
    pulsemixer # pulseaudio mixer
  ];

  packages = with pkgs; [
    brightnessctl # control laptop display brightness
    loupe # image viewer
    grim # screenshots
    grimblast # screenshot program from hyprland
    kooha # screencast recorder
    libnotify # notifications
    nemo # file manager
    wl-clipboard # clipboard support
    wofi # app launcher
  ] ++ fontPkgs ++ audioPkgs;

  wpctl = "${pkgs.wireplumber}/bin/wpctl";
in
{
  imports = [
    ./shared.nix
    ../../programs/foot
    ../../programs/hyprlock
    ../../programs/hyprpaper
    ../../programs/pyprland
    ../../programs/waybar
    ../../services/dunst
    ../../services/hypridle
  ];

  home = {
    inherit packages;
    stateVersion = "24.05";

    sessionVariables = {
      NIXOS_OZONE_WL = 1;
      SHELL = "${lib.exe pkgs.fish}";
      MOZ_ENABLE_WAYLAND = 1;
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      GDK_BACKEND = "wayland,x11";
      QT_QPA_PLATFORM = "wayland;xcb";
    };
  };

  fonts.fontconfig.enable = true;

  # do not restart services on change, as foot server gets killed
  systemd.user.startServices = lib.mkForce "suggest";

  programs.hypr-binds.enable = true;

  # e.g. for slack, etc
  xdg.configFile."electron-flags.conf".text = ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
  '';

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [ "hyprland" ];
      };
      hyprland = {
        default = [ "gtk" "hyprland" ];
      };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    xdgOpenUsePortal = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = (builtins.readFile ../../wm/hyprland/hyprland.conf) + ''
      bindd=,F1,Show keybindings,exec,hypr-binds
      bindd=SUPER,P,App launcher,exec,${lib.exe pkgs.wofi} --show run --style=${../../wm/hyprland/wofi.css} --term=footclient --prompt=Run
      bindd=SUPERSHIFT,A,Take screenshot,exec,${lib.exe pkgs.satty-shot}
      bindd=SUPERCTRL,L,Lock system,exec,${lib.exe pkgs.hyprlock}
      # audio volume bindings
      binddel=,XF86AudioRaiseVolume,Raise volume 󰝝 ,exec,${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%+
      binddel=,XF86AudioLowerVolume,Lower volume 󰝞 ,exec,${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-
      binddl=,XF86AudioMute,Toggle mute 󰝟 ,exec,${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle

      exec-once=${pkgs.pyprland}/bin/pypr
      exec-once=${pkgs.blueman}/bin/blueman-applet
      exec-once=${pkgs.networkmanagerapplet}/bin/nm-applet --sm-disable --indicator
      exec-once=${lib.exe pkgs.pasystray}
    '';
    plugins = [ ];
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    xwayland.enable = true;
  };
}
