{...}: {
  flake.homeModules.lazyNixCompat = {
    config,
    lib,
    ...
  }: let
    nvimCfg = config.programs.neovim.lazyNixCompat;
    pNameOf = drv: drv.pname or (lib.getName drv);
    lazyIdFromGithubUrl = url:
      url
      |> toString
      |> lib.strings.match ".*/github\\.com/([^/]+)/([^/#?\\.]+).*"
      |> (
        ms:
          if ms == null
          then null
          else "${builtins.elemAt ms 0}/${builtins.elemAt ms 1}"
      );
    guessLazyIdFor = drv:
      if (drv ? src && drv.src ? owner && drv.src ? repo)
      then "${drv.src.owner}/${drv.src.repo}"
      else if (drv ? src && drv.src ? url)
      then lazyIdFromGithubUrl drv.src.url
      else if (drv ? meta && drv.meta ? homepage)
      then lazyIdFromGithubUrl drv.meta.homepage
      else if (drv ? meta && drv.meta ? repositories && drv.meta.repositories ? github)
      then lazyIdFromGithubUrl drv.meta.repositories.github
      else null;
    lazyIdFor = drv: let
      pname = pNameOf drv;
      overrides = config.programs.neovim.lazyNixCompat.idOverrides;
    in
      if (lib.hasAttr "${pname}" overrides)
      then overrides."${pname}"
      else (guessLazyIdFor drv);
    compatSpecFrom = plugin:
    # lua
    ''
       {
      	"${lazyIdFor plugin}",
      	dir = "${plugin}",
      	optional = true,
      },
    '';
    compatSpecModuleFrom = plugins:
    # lua
    ''
      return {
      	${builtins.concatStringsSep "\n\t" (map compatSpecFrom plugins)}
      }
    '';
    plugins = config.programs.neovim.plugins or [];
    unresolvedPlugins = lib.filter (p: lazyIdFor p == null) plugins;
  in {
    options.programs.neovim.lazyNixCompat = {
      enable = lib.mkEnableOption ''
        Generate lazy.nvim specs to point installed plugins to nix store
      '';
      idOverrides = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = {};
        description = ''
          A map of plugin pname's to lazy merge
        '';
      };
      lazyNixCompatPath = lib.mkOption {
        type = lib.types.str;
        default = "nvim/lua/plugins/nixcompat/storepaths.lua";
        description = ''
          Path to compatibility modules relative to XDG_CONFIG_HOME.
        '';
      };
    };
    config = lib.mkIf nvimCfg.enable {
      assertions = [
        {
          assertion = unresolvedPlugins == [];
          message = let
            pluginList = lib.concatMapStrings (p: " - ${pNameOf p}\n") unresolvedPlugins;
            example = pNameOf (lib.head unresolvedPlugins);
          in ''
            Unable to resolve owner/repo for
            	${pluginList}
            Add an identifier override, e.g.:
            programs.neovim.lazyNixCompat.idOverrides."${example}" = "owner/repo"
          '';
        }
      ];
      xdg.configFile."${nvimCfg.lazyNixCompatPath}".text = compatSpecModuleFrom plugins;
    };
  };
}
