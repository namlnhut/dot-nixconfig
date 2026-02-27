{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.lnnam = {
    initialHashedPassword = "$y$j9T$Ola4P98lGS8ViMwDBOiSD1$c7DjNIjy0SToAIRT2mnIj9jkvTR4hGmede0Kf3kpkE6";
    isNormalUser = true;
    description = "m3tam3re";
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "flatpak"
      "audio"
      "video"
      "plugdev"
      "input"
      "kvm"
      "qemu-libvirtd"];
    ];
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };
  home-manager.users.lnnam =
    import ../../../home/lnnam/${config.networking.hostName}.nix;
}

