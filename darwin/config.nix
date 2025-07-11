{
  self,
  pkgs,
  uid,
  user,
  unfree,
  flake,
  ...
}:

{
  nix = {
    enable = true;
    settings = {
      sandbox = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  nixpkgs.config.allowUnfree = unfree;

  users = {
    knownUsers = [ user ];
    users.${user} = {
      uid = uid;
      shell = pkgs.fish;
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  programs.fish = {
    enable = true;
    vendor.config.enable = true;
    vendor.functions.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    nh
  ];

  environment.variables = {
    NH_FLAKE = flake;
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
      extraFlags = [
        "--verbose"
      ];
    };
  };

  system = {
    primaryUser = user;
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 6;
  };
}
