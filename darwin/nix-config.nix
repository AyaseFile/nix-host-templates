{ pkgs, nix-mods, ... }:

{
  imports = [
    nix-mods.pkgs
    nix-mods.direnv
  ];

  modules.pkgs = {
    cli.enable = true;
    fonts.enable = true;
    utils.enable = true;
  };

  modules.direnv.enable = true;

  environment.systemPackages = with pkgs; [
    coreutils
    findutils
    rsync
  ];

  homebrew = {
    brews = [
      "pinentry-mac"
    ];
    casks =
      [
        "wezterm@nightly"
      ]
      ++ map (name: {
        inherit name;
        greedy = true;
      }) [ ];
  };
}
