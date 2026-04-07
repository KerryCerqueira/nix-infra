# Neovim module

## Overview

This subtree produces a wrapped neovim derivation using
[nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules) with
[lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin/configuration
manager. The integration is designed so that nix handles plugin fetching and
store-path resolution while lazy.nvim handles the runtime plugin lifecycle
(loading, opts merging, dependency ordering).

## How the nix-lazy bridge works

`neovim.nix` defines a reusable wrapper module
(`flake.lib.wrapperModules.lazy-neovim`) that extends the base
nix-wrapper-modules neovim wrapper with lazy.nvim-specific options. The key
mechanism:

1. Plugins declared via `lazy.plugins.<name>` are placed on the packpath by
   nix-wrapper-modules and their store paths are injected as `lazySpecs` into
   lazy.nvim's startup via the wrapper's `info` system.
2. Lua spec files declared via `lazy.specs` are similarly injected. These are
   paths to lua files (or inline lua strings) that return lazy.nvim spec tables.
3. At runtime, `configInit` collects all injected specs and calls
   `require("lazy").setup(specs, ...)`.

This means lazy.nvim's `opts` merging and dependency injection work as normal --
multiple aspects can contribute `opts` to the same plugin via lazy's `optional`
pattern, and plugin configuration stays in lua.

## File layout

```
modules/neovim/
  neovim.nix            -- Flake-level entry: defines flake.wrappers.neovim,
                           flake.nixosModules.neovim, flake.homeModules.neovim,
                           lazy-neovim wrapper module (options + bridge logic)
  aspects/              -- Nix-side aspect modules (each a flake-parts module
                           setting flake.wrappers.neovim)
    appearance.nix
    completion.nix
    editing.nix
    ...
    lang/               -- Language-specific aspects
      nix.nix
      python.nix
      ...
  src/                  -- Lua-side configuration (nix-agnostic)
    lua/
      options.lua       -- vim.opt, vim.g, LSP enable, diagnostics, filetypes
      keymaps.lua       -- Global keybindings
      autocommands.lua  -- Global autocommands
      lazy-setup.lua    -- Standalone lazy bootstrap (non-nix fallback)
      lazyspecs/        -- Lazy spec files, mirroring aspects/
        editing.lua
        completion.lua
        ...
        lang/
          nix.lua
          python.lua
          ...
      snippets/         -- LuaSnip snippet definitions
    lsp/                -- vim.lsp.config files (one per server)
    ftplugin/           -- Filetype-specific settings
    queries/            -- Custom treesitter queries
```

## Aspect co-location pattern

Each neovim concern has a **nix aspect** and a corresponding **lua spec file**.
The nix aspect handles:

- Declaring plugin packages (`lazy.plugins.<name>`)
- Supplying runtime dependencies (`extraPackages`)
- Registering treesitter grammars (`treesitter.grammars`)
- Pointing to its lua spec file (`lazy.specs`)

The lua spec file handles all runtime configuration:

- Lazy.nvim spec fields (`opts`, `keys`, `event`, `dependencies`, etc.)
- Plugin setup logic

Example -- the `editing` aspect:

```nix
# aspects/editing.nix
{...}: {
  flake.wrappers.neovim = { pkgs, config, ... }: {
    lazy = {
      plugins.mini-surround = {
        name = "mini.surround";
        pkg = pkgs.vimPlugins.mini-surround;
      };
      # ... more plugins
      specs = [
        (config.lazy.configSrc + "/lua/lazyspecs/editing.lua")
      ];
    };
  };
}
```

```lua
-- src/lua/lazyspecs/editing.lua
---@type LazySpec
return {
  {
    "echasnovski/mini.surround",
    event = "BufEnter",
    opts = { ... },
  },
  -- ...
}
```

The nix side declares the `pkg` (store path); the lua side specifies the same
plugin by its canonical name and provides all runtime configuration. Lazy merges
them by name.

## Runtime dependencies

Nix-side aspects provision three kinds of runtime dependencies for neovim:

- **Path dependencies** (`extraPackages`): Executables placed on neovim's
  `PATH` at runtime -- LSP servers, formatters, linters, CLI tools. These are
  ordinary nix packages.

  ```nix
  extraPackages = with pkgs; [ alejandra nil ];
  ```

- **Wrapped Python dependencies** (`hosts.python3.withPackages`): Python
  packages bundled into the wrapped python3 host used by python-based neovim
  plugins (e.g. molten-nvim). The python3 host itself is enabled in
  `neovim.nix` via `hosts.python3.nvim-host.enable = true`; individual
  aspects extend it by appending to `withPackages`.

  ```nix
  hosts.python3.withPackages = pyPkgs: with pyPkgs; [
    jupyter-client
    nbformat
    pillow
  ];
  ```

- **Treesitter grammars** (`treesitter.grammars`): Parser grammars appended to
  a custom list option defined in `neovim.nix`. Grammars are sourced from
  `pkgs.vimPlugins.nvim-treesitter.builtGrammars` and bundled with
  nvim-treesitter at build time.
  ```nix
  treesitter = {
    enable = true;
    grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      python
      nix
    ];
  };
  ```

All three are list-like and merge across aspects -- multiple aspects can
independently contribute packages, python deps, and grammars without conflict.

## Language aspects

Language aspects (`aspects/lang/*.nix`) follow a focused pattern:

- `extraPackages` for LSP servers, formatters, linters
- `treesitter.grammars` for parser grammars
- `lazy.specs` pointing to a lua spec file (if the language needs plugin config
  beyond LSP/treesitter)

LSP server configurations live in `src/lsp/<server>.lua` as
`vim.lsp.Config` tables. They are enabled globally in `src/lua/options.lua`
via `vim.lsp.enable(...)`.

Formatter-to-filetype mappings are contributed via lazy's `optional` pattern on
`conform.nvim` from each language's lua spec.

## Adding a new plugin

1. Identify the appropriate aspect (or create a new `.nix` file under
   `aspects/` if it represents a new concern).
2. In the nix aspect, add the plugin to `lazy.plugins` with its `pkg` and
   `name`, and add or update the `lazy.specs` entry pointing to the
   corresponding lua file.
3. In the corresponding lua file under `src/lua/lazyspecs/`, add the lazy spec
   with runtime config (`opts`, `keys`, `event`, etc.).
4. If the plugin needs runtime binaries, add them to `extraPackages`.

## Adding language support

1. Create `aspects/lang/<language>.nix`.
2. Add `extraPackages` for the LSP server and any formatters/linters.
3. Add treesitter grammars to `treesitter.grammars`.
4. Create `src/lsp/<server>.lua` with a `vim.lsp.Config` return table.
5. Add the server name to `vim.lsp.enable(...)` in `src/lua/options.lua`.
6. If formatters are needed, create `src/lua/lazyspecs/lang/<language>.lua`
   contributing to `conform.nvim` via the optional pattern.
7. Optionally add `src/ftplugin/<filetype>.lua` for filetype-specific settings.

## Standalone lua config

The `src/` directory is intended to work as a standalone neovim config (with
`lazy-setup.lua` bootstrapping lazy.nvim from git instead of nix). When editing
lua files, keep them nix-agnostic -- no references to store paths or nix
builtins. All nix-specific wiring happens in the `.nix` files.

## Code style

- Nix files: format with `alejandra`.
- Lua files: indent with tabs; annotate spec return types with `---@type LazySpec`.
- LSP config files: annotate with `---@type vim.lsp.Config`.
