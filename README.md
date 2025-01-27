# nix-neovim-config
neovim config powered by (nixCats-nvim)[https://github.com/BirdeeHub/nixCats-nvim]

## usage
```
# flake.nix
inputs = {
  ...
  neovim.url = "github:cpark97/nix-neovim-config";
};

outputs = { nixpkgs, neovim, ... }:
{
  nixosConfigurations.nixos = nixpkgs.nixosSystem {
    ...
    modules = [
      ({ pkgs, ... }: {
        environment.systemPackages = [
          neovim.packages.${pkgs.system}.default
        ];
      })
    ];
  };
};
```
or use via nixpkgs overlays
```
# flake.nix
inputs = {
  ...
  neovim.url = "github:cpark97/nix-neovim-config";
};

outputs = { nixpkgs, neovim, ... }:
{
  nixosConfigurations.nixos = nixpkgs.nixosSystem {
    ...
    modules = [
      ({ pkgs, ... }: {
        nixpkgs.overlays = [
          (final: prev: { neovim = neovim.packages.${prev.system}.default; })
        ];

        environment.systemPackages = [
          neovim
        ];
      })
    ];
  };
};
```

