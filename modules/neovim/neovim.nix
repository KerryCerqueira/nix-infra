{
  self,
  inputs,
  ...
}: {
  flake = {
    nixosModules.neovim = {
      pkgs,
      lib,
      ...
    }: {
      environment.systemPackages = let
        system = pkgs.stdenv.hostPlatform.system;
      in [self.packages.${system}.neovim];
      environment.variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };
    homeModules.neovim = {
      pkgs,
      lib,
      ...
    }: {
      home.packages = let
        system = pkgs.stdenv.hostPlatform.system;
      in [self.packages.${system}.neovim];
      home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };
    wrappers.neovim = {...}: {
      imports = [self.lib.wrapperModules.lazy-neovim];
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
    packages.neovim = self.wrappers.neovim.wrap {
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
      "potato"
    ];
    homeModules.neovim = [
      "jovianUser"
      "kerry"
    ];
  };
}
