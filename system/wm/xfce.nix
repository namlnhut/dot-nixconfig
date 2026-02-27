{ pkgs, ... }:

{
  # Enable the X11 windowing system.
  services = {
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    # GUI interface
    xserver = {
      enable = true;

      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };

      # Enable the XFCE Desktop Environment.
      displayManager.lightdm.enable = true;
      desktopManager.xfce.enable = true;
    };
  };
}
