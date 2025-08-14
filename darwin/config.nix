{
  self,
  pkgs,
  nix-mods,
  ...
}:

let
  uid = 501;
  user = "<user>";
  rev = self.rev or self.dirtyRev or null;
  unfree = false;
  flake = "<flake>";
in
{
  imports = [
    nix-mods.darwin
    nix-mods.pkgs
    nix-mods.direnv
  ];

  modules.darwin = {
    enable = true;
    inherit
      uid
      user
      rev
      unfree
      flake
      ;
  };

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
    casks = [
      "wezterm@nightly"
    ]
    ++ map (name: {
      inherit name;
      greedy = true;
    }) [ ];
  };
}
