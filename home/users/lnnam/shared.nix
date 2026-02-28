{ pkgs, lib, ... }:

let
  username = "lnnam";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  packages = with pkgs; [
    any-nix-shell # fish support for nix shell
    audacious # simple music player
    bottom # alternative to htop & ytop
    dig # dns command-line tool
    docker-compose # docker manager
    duf # disk usage/free utility
    eza # a better `ls`
    fd # "find" for files
    gimp # gnu image manipulation program
    hyperfine # command-line benchmarking tool
    insomnia # rest client with graphql support
    jmtpfs # mount mtp devices
    killall # kill processes by name
    libreoffice # office suite
    lnav # log file navigator on the terminal
    md-toc # # generate ToC in markdown files
    ncdu # disk space info (a better du)
    nitch # minimal system information fetch
    nix-output-monitor # nom: monitor nix commands
    nix-search # faster nix search client
    nyancat # the famous rainbow cat!
    ripgrep # fast grep
    socat # multipurpose relay (SOcket CAT)
    spotify # music player
    systemctl-tui # manage systemctl services and their logs
    telegram-desktop # telegram messaging client
    tree # display files in a tree view
    unzip # uncompress files
    vlc # media player
    xsel # clipboard support (also for neovim)
    zip # compress files
  ];
in
{
  programs.home-manager.enable = true;

  imports = lib.concatMap import [
    ../../modules
    ../../themes
    ../../shared/programs.nix
    ../../shared/services.nix
  ];

  xdg = {
    inherit configHome;
    enable = true;
  };

  home = {
    inherit username homeDirectory packages;

    changes-report.enable = true;

    # Backup existing files when home-manager would overwrite them
    # Option 1: Simple backup - adds .backup extension to conflicting files
    backupFileExtension = "backup";

    # Option 2: Custom backup command (comment out backupFileExtension above to use this)
    # This example moves files to a backup directory with timestamp
    # backCommand = ''
    #   BACKUP_DIR="${homeDirectory}/.config-backups/$(${pkgs.coreutils}/bin/date +%Y%m%d_%H%M%S)"
    #   ${pkgs.coreutils}/bin/mkdir -p "$BACKUP_DIR"
    #   ${pkgs.coreutils}/bin/mv "$1" "$BACKUP_DIR/$(${pkgs.coreutils}/bin/basename "$1")"
    #   ${pkgs.coreutils}/bin/echo "Backed up $1 to $BACKUP_DIR"
    # '';

    sessionVariables = {
      BROWSER = "${lib.exe pkgs.firefox}";
      DISPLAY = ":0";
      EDITOR = "nvim";
      # https://github.com/NixOS/nixpkgs/issues/24311#issuecomment-980477051
      GIT_ASKPASS = "";
    };
  };

  # garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # restart the corresponding systemd services on change
  systemd.user.startServices = "sd-switch";

  # notifications about home-manager news
  news.display = "silent";
}
