{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-config = {
      url = "github:AyaseFile/nix-config/main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nur-packages.follows = "nur-packages";
    };
    nur-packages = {
      url = "github:AyaseFile/nur-packages/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    let
      system = "x86_64-linux";
      unfree = false;
      cli = true;
      fonts = false;
      utils = false;
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = unfree;
        };
      };
      evalModule =
        module:
        let
          fakeLib = nixpkgs.lib // {
            mkOption = _: true;
            mkIf = cond: val: if cond then val else { };
          };
          result = module {
            inherit pkgs;
            lib = fakeLib;
            nur-overlays = inputs.nur-packages.overlays;
            config.modules.pkgs = {
              cli.enable = cli;
              fonts.enable = fonts;
              utils.enable = utils;
            };
          };
          config = result.config or { };
        in
        config.environment.systemPackages or config.fonts.packages or [ ];
      cli-pkgs = evalModule (import "${inputs.nix-config}/modules/pkgs/cli.nix");
      fonts-pkgs = evalModule (import "${inputs.nix-config}/modules/pkgs/fonts.nix");
      utils-pkgs = evalModule (import "${inputs.nix-config}/modules/pkgs/utils.nix");
    in
    {
      packages.${system} = with pkgs; {
        default = symlinkJoin {
          name = "default";
          paths = [
            cli-pkgs
            fonts-pkgs
            utils-pkgs
            man
            fish
          ];
        };
      };
    };
}
