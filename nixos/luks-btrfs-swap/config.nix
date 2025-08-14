{ host, nix-mods, ... }:

let
  user = "<user>";
  stateVersion = "25.05";
  useZen = true;
  unfree = true;
  ssh = true;
  tty = false;
  secureboot = false;
  flake = "/etc/nixos";
in
{
  imports = [
    nix-mods.nixos
    nix-mods.luks
    nix-mods.btrfs
    nix-mods.secureboot
    nix-mods.pkgs
    ./hardware-config.nix
  ];

  modules.nixos = {
    enable = true;
    inherit
      user
      host
      stateVersion
      useZen
      unfree
      ssh
      tty
      flake
      ;
  };

  modules.luks.enable = true;

  modules.btrfs.enable = true;

  modules.secureboot.enable = secureboot;

  modules.pkgs.cli.enable = true;
}
