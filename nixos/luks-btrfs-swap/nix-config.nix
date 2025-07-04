{ nix-mods, ... }:

{
  imports = [
    nix-mods.pkgs
    nix-mods.secureboot
  ];

  modules.pkgs.cli.enable = true;

  modules.secureboot.enable = false;
}
