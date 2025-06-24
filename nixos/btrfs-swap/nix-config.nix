{ flake, nix-mods, ... }:

{
  imports = [
    nix-mods.pkgs
    nix-mods.secureboot
  ];

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--nogcroots";
    };
    flake = flake;
  };

  modules.pkgs.cli.enable = true;

  modules.secureboot.enable = false;
}
