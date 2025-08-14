{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    inputs@{ nix-darwin, ... }:
    let
      host = "<host>";
      system = "aarch64-darwin";
      nix-mods = inputs.nix-config.modules;
      nur-mods = inputs.nur-packages.modules;
      nur-pkgs = inputs.nur-packages.packages.${system};
    in
    {
      darwinConfigurations.${host} = nix-darwin.lib.darwinSystem {
        system = system;
        specialArgs = inputs // {
          inherit
            host
            system
            nix-mods
            nur-mods
            nur-pkgs
            ;
        };
        modules = [
          ./config.nix
        ];
      };
    };
}
