{ pkgs, inputs, ... }:

{
  imports = [
    # Hardware scan
    ./hardware-configuration.nix
    ../../wm/niri.nix
  ];

  # Home Manager configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = pkgs.xargs;

    users.lnnam = {
      imports = [
        inputs.neovim-flake.homeManagerModules.${pkgs.system}.default
        inputs.nix-index.homeManagerModules.${pkgs.system}.default
        inputs.hypr-binds-flake.homeManagerModules.${pkgs.system}.default
        ../../../home/wm/niri
      ];

      hidpi = false;
      dotfiles.mutable = true;
      nix.registry.nixpkgs.flake = inputs.nixpkgs;
    };
  };

  # Bootloader
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "msi-gl63";
  };

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };

  # Enable sound with pipewire
  hardware.pulseaudio.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Additional system packages specific to this machine
  environment.systemPackages = with pkgs; [
    firefox
    vim
    neovim
    git
    tealdeer
    xclip
    bat
    openssh
  ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    allowSFTP = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
