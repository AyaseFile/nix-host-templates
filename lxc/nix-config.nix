{ flake, nix-mods, ... }:

{
  imports = [ nix-mods.pkgs ];

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
}
