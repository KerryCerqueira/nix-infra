# AGENTS.md

## Project overview

Nix infrastructure monorepo. A single nix flake using
[flake-parts](https://flake.parts/) for module composition,
[import-tree](https://github.com/vic/import-tree) for automatic module
discovery, and the
[dendritic pattern](https://github.com/mightyiam/dendritic) for overall
organization. Outputs include nixOS system configurations, home-manager
profiles, a wrapped neovim derivation, and reusable nixOS/home-manager/wrapper
modules.

## Architecture

### Flake structure

`flake.nix` calls `import-tree ./modules`, which recursively imports every
`.nix` file under `modules/` as a flake-parts module. Directories prefixed with
`_` (e.g. `_hardware/`, `_home/`) are excluded from import-tree's auto-import
and are instead imported explicitly by their parent via `import ./_hardware` or
similar. Non-nix files (`.yaml`, `.lua`, etc.) are also ignored by import-tree.

Every `.nix` file under `modules/` is therefore a **flake-parts module** -- a
function that receives flake-parts module arguments (`self`, `inputs`,
`config`, `lib`, ...) and sets flake-parts options. There is no separate
`default.nix` entry-point convention; import-tree handles discovery.

### Module conventions

Modules set **flake-level options** rather than working at a single nix
abstraction layer. A single file may define any combination of:

- `flake.nixosModules.<name>` -- a nixOS module
- `flake.homeModules.<name>` -- a home-manager module
- `flake.nixosConfigurations.<name>` -- a full system configuration
- `flake.lib.<name>` -- shared library functions
- `flake.wrappers.<name>` -- nix-wrapper-modules wrapper definitions
- `flake.lib.wrapperModules.<name>` -- reusable wrapper modules
- `perSystem` -- per-system outputs (packages, devShells, apps)

Module functions use destructured arguments with `...`:
```nix
{ self, inputs, ... }: {
  flake.nixosModules.example = { pkgs, ... }: { ... };
}
```

Modules reference each other via `self.nixosModules.<name>`,
`self.homeModules.<name>`, etc. -- never by relative path (except for `_`
prefixed directories which are explicitly imported by their parent).

### Aspect-oriented organization

The `modules/` tree is organized by **aspect** (concern), not by nix
abstraction layer:

| Directory | Aspect |
|-----------|--------|
| `modules/hosts/<name>/` | Machine-specific config: hardware, filesystem, networking, secrets, user bindings |
| `modules/users/` | User profile definitions and home-manager configurations |
| `modules/terminal/` | Shell environment: zsh, fish, terminal emulators, CLI tools |
| `modules/programs/` | Individual application modules (gnome, steam, ssh, etc.) |
| `modules/packages/` | Package outputs, helper derivations, MCP server packages |
| `modules/neovim/` | Neovim wrapper modules and lua source -- see `modules/neovim/AGENTS.md` |
| `modules/devenvs/` | Development shell and app definitions |


At the flake output level, hosts are associated to their nixOS module output, e.g.
`claudius` to `outputs.nixosModules.claudius`. Any flake-parts module can
contribute configuration to that concern by multiply defining that output.
Similarly, user concerns export `homeModules.<user>` and
`homeModules.<user>@<host>`.

### Host configuration pattern

Each host directory (e.g. `modules/hosts/claudius/`) contains:

- `core.nix` -- Defines `flake.nixosModules.<host>` (imports other aspect
  modules) and `flake.nixosConfigurations.<host>`
- `hardware.nix`, `filesystem.nix`, `networking.nix` -- hardware-specific
  nixOS module config
- `sops.nix` + `secrets.yaml` -- system-level secrets via sops-nix
- `users/<user>/` -- per-user host-specific config (home-manager imports, user
  secrets)

Some hosts (e.g. `potato`) use the `_` prefix convention instead as the refactor
to dendritic code proceeds.

### Secrets management

Secrets are managed with [sops-nix](https://github.com/Mic92/sops-nix) using
age encryption. The `.sops.yaml` at the repo root defines creation rules
mapping secret file paths to age keys. Secret files are `secrets.yaml` files
co-located with the modules that consume them.

**Do not create, edit, or commit `secrets.yaml` files.** They contain encrypted
data that requires specific age keys. Do not log, display, or include secret
values in outputs.

## Key inputs

- `nixpkgs` -- nixos-unstable channel
- `home-manager` -- follows nixpkgs
- `flake-parts` -- flake module composition
- `import-tree` -- automatic module discovery
- `nix-wrapper-modules` -- wrapper framework
- `sops-nix` -- secrets management
- `uv2nix` / `pyproject-nix` / `pyproject-build-systems` -- Python packaging

## Code style

- Format nix with `alejandra` (no config file; default settings).
- Pipe operators (`|>`) are enabled and used where they improve readability.

## Building and testing

```sh
# Check the flake evaluates
nix flake check

# Build a nixOS system configuration
nix build .#nixosConfigurations.<host>.config.system.build.toplevel

# Build the neovim wrapper
nix build .#neovim

# Run neovim directly
nix run .#neovim

# Enter a dev shell
nix develop .#data-munge

# Deploy to the current machine (requires matching hostname)
sudo nixos-rebuild switch --flake .#<host>
```

## Guidelines for changes

- Every new `.nix` file under `modules/` becomes a flake-parts module
  automatically (unless under a `_` directory). Be intentional about file
  placement.
- When adding a new program or tool, create a module in the appropriate aspect
  directory (e.g. `modules/programs/` for GUI apps, `modules/terminal/` for
  CLI tools).
- Host-specific configuration goes under `modules/hosts/<hostname>/`. Shared
  configuration goes in aspect modules that hosts import.
- Compose modules via `imports` using `self.nixosModules.*` or
  `self.homeModules.*` -- not relative paths (except for `_` prefixed
  subdirectories).
- Run `alejandra` on any nix files you create or modify.
