{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { ... }:
    {
      templates = {
        nixos = {
          luks-btrfs-swap.path = ./nixos/luks-btrfs-swap;
          btrfs-swap.path = ./nixos/btrfs-swap;
          xfs-swap.path = ./nixos/xfs-swap;
        };
        lxc.path = ./lxc;
        darwin.path = ./darwin;
        linux.path = ./linux;
      };
    };
}
