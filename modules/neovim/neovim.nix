top @ {
  inputs,
  moduleWithSystem,
  ...
}: {
  flake = {
    nixosModules.neovim = moduleWithSystem (
      perSystem @ {config}: {...}: {
        environment.systemPackages = [
          perSystem.config.packages.neovim
        ];
        environment.variables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };
      }
    );
    homeModules.neovim = moduleWithSystem (
      perSystem @ {config}: {...}: {
        home.packages = [perSystem.config.packages.neovim];
        home.sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };
      }
    );
    wrappers.neovim = {...}: {
      imports = [top.config.flake.lib.wrapperModules.lazy-neovim];
      lazy.configSrc = ./src;
      lazy.configInitExtra = ''
        require("options").setup()
        require("keymaps").setup()
        require("autocommands").setup()
      '';
      aspects = {
        appearance.enable = true;
        completion.enable = true;
        editing.enable = true;
        filetree.enable = true;
        formatting.enable = true;
        git.enable = true;
        picker.enable = true;
        treesitter.enable = true;
        ui.enable = true;
        lang = {
          sh.enable = true;
          mdlangs.enable = true;
          markdown.enable = true;
        };
      };
    };
  };
  perSystem = {system, ...}: {
    wrappers.packages.neovim = true;
    packages.neovim = top.config.flake.wrappers.neovim.wrap {
      pkgs = import inputs.nixpkgs-neovim {
        inherit system;
        config.allowUnfree = true;
      };
    };
  };
  deployments = {
    nixosModules.neovim = [
      "claudius"
      "napoleon"
      "mushu"
      "panza"
    ];
    homeModules.neovim = [
      "jovianUser"
      "kerry"
    ];
  };
}
