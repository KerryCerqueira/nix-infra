# KerryCerqueira/nix-infra

My infrastructure monorepo, powered by nix.

## Overview

This repository is a nix flake integrating [flake-parts](https://flake.parts/)
patterns, with modules marshaled by
[import-tree](https://github.com/vic/import-tree), and organized overall
according to the [dendritic pattern](https://github.com/mightyiam/dendritic).
Every nix file in this module is therefore a flake-parts module or contains `/_`
in its path. Each flake-parts module can be identified with a particular *aspect*
of configuration as opposed to a specific level of nix abstraction like a
derivation or nixOS module, and uses dependency injection with module merging to
accomplish this.

The flake outputs of this repo include nixOS configurations for my host,
home-manager profiles deployed therein, a
[wrapped](https://github.com/BirdeeHub/nix-wrapper-modules) neovim derivation
containing my `lazy.nvim`-powered configuration, and numerous nixOS, home-manager,
and wrapper-modules to build all of these with.

## Aspects

- `hosts/`: Machine configuration. Hardware and filesystem declaration. System
level packages and secrets.
- `users/`: User profile configuration. User level secrets and packages.
- `terminal/`: home-manager and nixos Modules configuring zsh, fish, and general
shell utilies.
- `packages/`: package outputs, helper utilies.
- `programs/`: nixOS and HM modules configuring specific pieces of software.
- `neovim/`: nixOS, home-manager, and wrapper modules for deploying a wrapped
neovim derivation using lazy as a plugin configuration manager. See
`neovim/README.md` for additional details.

## Usage

Various nixOS and home-manager modules are exported as flake outputs and can be
re-used in a generic setting, e.g., with `inputs.kc-nix-infra.url =
"github:kerrycerqueira/nix-infra"`:

```{nix}
{inputs, ...}: {
    flake.homeModules.example = {
        imports = [inputs.kc-nix-infra.homeModules.terminal];
    };
};
```

To test drive my neovim configuration, try

```{sh}
nix run github:kerrycerqueira/nix-infra#neovim
```
