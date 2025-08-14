{ host, nix-mods, ... }:

let
  user = "<user>";
  stateVersion = "25.05";
  unfree = false;
  privileged = false;
  ssh = true;
  tty = false;
  flake = "/etc/nixos";
in
{
  imports = [
    nix-mods.lxc
    nix-mods.pkgs
  ];

  modules.lxc = {
    enable = true;
    inherit
      user
      host
      stateVersion
      unfree
      privileged
      ssh
      tty
      flake
      ;
  };

  modules.pkgs.cli.enable = true;
}
