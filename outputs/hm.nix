{ extraHomeConfig, inputs, system, pkgs, ... }:

let
  modules' = [
    inputs.neovim-flake.homeManagerModules.${system}.default
    inputs.nix-index.homeManagerModules.${system}.default
    { nix.registry.nixpkgs.flake = inputs.nixpkgs; }
    extraHomeConfig
  ];

  mkHome = { hidpi, mut ? false, mods ? [ ] }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = pkgs.xargs;
      modules = modules' ++ mods ++ [
        { inherit hidpi; dotfiles.mutable = mut; }
      ];
    };

  mkXmonadHome = { hidpi }: mkHome {
    inherit hidpi;
    mods = [ ../home/wm/xmonad ];
  };

  mkHyprlandHome = { hidpi, mut ? false }: mkHome {
    inherit hidpi mut;
    mods = [
      inputs.hypr-binds-flake.homeManagerModules.${system}.default
      ../home/wm/hyprland
    ];
  };

  mkNiriHome = { hidpi, mut ? false }: mkHome {
    inherit hidpi mut;
    mods = [ ../home/wm/niri ];
  };
in
{
  niri-edp = mkNiriHome { hidpi = false; mut = true; };
  niri-hdmi = mkNiriHome { hidpi = true; mut = true; };
  hyprland-edp = mkHyprlandHome { hidpi = false; };
  hyprland-hdmi = mkHyprlandHome { hidpi = true; };
  hyprland-hdmi-mutable = mkHyprlandHome { hidpi = true; mut = true; };
  xmonad-edp = mkXmonadHome { hidpi = false; };
  xmonad-hdmi = mkXmonadHome { hidpi = true; };

  # lnnam user configurations
  lnnam-xmonad = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = pkgs.xargs;
    modules = modules' ++ [
      ../home/users/lnnam/xmonad.nix
      { hidpi = false; dotfiles.mutable = true; }
    ];
  };

  lnnam-xfce = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = pkgs.xargs;
    modules = modules' ++ [
      ../home/users/lnnam/xfce.nix
      { hidpi = false; dotfiles.mutable = true; }
    ];
  };

  lnnam-niri = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = pkgs.xargs;
    modules = modules' ++ [
      ../home/users/lnnam/niri.nix
      { hidpi = false; dotfiles.mutable = true; }
    ];
  };

  lnnam-hyprland = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = pkgs.xargs;
    modules = modules' ++ [
      ../home/users/lnnam/hyprland.nix
      { hidpi = false; dotfiles.mutable = true; }
    ];
  };

  lnnam-gnome = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = pkgs.xargs;
    modules = modules' ++ [
      ../home/users/lnnam/gnome.nix
      { hidpi = false; dotfiles.mutable = true; }
    ];
  };
}
