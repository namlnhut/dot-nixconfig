{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.lnnam = {
    initialHashedPassword = "$y$j9T$.06GPjdV73bQCm20P2hr41$9YCZQVO.vRLw3cCIiYhOPZO4uy8NzwXsxV5KkQxuiK8";
    isNormalUser = true;
    description = "lnnam";
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
      "qemu-libvirtd"
    ];
    openssh.authorizedKeys.keys = [];
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };
  home-manager.users.lnnam =
    import ../../../home/lnnam/${config.networking.hostName}.nix;
}

