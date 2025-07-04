{ nix-mods, ... }:

{
  imports = [ nix-mods.pkgs ];

  modules.pkgs.cli.enable = true;
}
