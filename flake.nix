{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { ... }:
    {
      templates = {
        nixos.path = ./nixos;
        lxc.path = ./lxc;
        darwin.path = ./darwin;
        linux.path = ./linux;
      };
    };
}
