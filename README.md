# nix-neovim-config
## V1
The previous version with nixCats-nvim is available on the `v1` branch

## Usage
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
## Development

### Tests

#### Checks
- Write checks in the `checks` directory using `make-neovim-check`
- Run checks with `nix flake check`
- All `.nix` files in the `checks` directory are detected automatically

#### Build test
- Run `nix develop` to enter a stdenv-based dev shell for building the default Neovim package

#### Test with existing files
- Run `nix shell` to enter a shell with the default Neovim package installed
- `cd` into another directory and run Neovim with `nvim`
- Run `exit` to leave the shell and return to the project directory

### Config

- Put configuration files in the `config` directory

#### Add plugins
- Add plugins to `startPlugins` or `optionalPlugins` in `default.nix`
- Add runtime dependencies to `runtimeDeps` in `default.nix`
- Add plugin configuration files to the `configs/lua/plugin` directory
  and 'require' them from `configs/lua/plugin/init.lua`
