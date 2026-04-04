{...}: {
  flake.wrappers.neovim = {
    pkgs,
    lib,
    config,
    ...
  }: let
    beacon-nvim = let
      tag = "v2.0.0";
      version = lib.removePrefix "v" tag;
      hash = "sha256-w5uhTVYRgkVCbJ5wrNTKs8bwSpH+4REAr9gaZrbknH8=";
    in
      pkgs.vimUtils.buildVimPlugin {
        pname = "beacon.nvim";
        inherit version;
        src = pkgs.fetchFromGitHub {
          owner = "DanilaMihailov";
          repo = "beacon.nvim";
          rev = tag;
          inherit hash;
        };
      };
    colorful-winsep-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "colorful-winsep.nvim";
      version = "unstable-2026-02-19T12:22:25Z";
      src = pkgs.fetchFromGitHub {
        owner = "nvim-zh";
        repo = "colorful-winsep.nvim";
        rev = "84432d9966fafaa08dd9040c98b0011045d8e964";
        hash = "sha256-xZKDP/9iG2+tt8nqNpirvCe5olNj/jLYrVV9D6o+UXk=";
      };
    };
    neominimap-nvim = let
      tag = "v3.15.2";
      version = lib.removePrefix "v" tag;
      hash = "sha256-HiP0xH4NyrX4lvmTDFbwYv0Hfl176Au9Q/ellJSPCuw=";
    in
      pkgs.vimUtils.buildVimPlugin {
        pname = "neominimap.nvim";
        inherit version;
        src = pkgs.fetchFromGitHub {
          owner = "Isrothy";
          repo = "neominimap.nvim";
          rev = tag;
          inherit hash;
        };
      };
    tiny-glimmer-nvim = let
      commitDate = "2025-11-22T23:49:03+01:00";
      version = "unstable-" + commitDate;
      rev = "e83bab26665c2dd4153b8a24e172e674e7c6dee7";
      hash = "sha256-4dSD4mosR87cA3Z+hm44y/krRtIDarWSTwPAKC9pqAo=";
    in
      pkgs.vimUtils.buildVimPlugin {
        pname = "tiny-glimmer.nvim";
        inherit version;
        src = pkgs.fetchFromGitHub {
          owner = "rachartier";
          repo = "tiny-glimmer.nvim";
          inherit rev hash;
        };
        nvimSkipModules = ["test"];
      };
    visual-whitespace-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "visual-whitespace.nvim";
      version = "unstable-2026-02-21T16:05:55-07:00";
      src = pkgs.fetchFromGitHub {
        owner = "mcauley-penney";
        repo = "visual-whitespace.nvim";
        rev = "49ff2b1c572ed7033a584381fa23aad2bf3bb258";
        hash = "sha256-svKfA9p6WC6k3kbxG4TJxe2r0xpRPdbNTVk2PZcPAiY=";
      };
    };
  in {
    lazy = {
      specs = [
        (config.lazy.configSrc + "/lua/lazyspecs/appearance.lua")
      ];
      plugins = {
        beacon-nvim = {
          name = "beacon.nvim";
          pkg = beacon-nvim;
        };
        catppuccin-nvim = {
          name = "catppuccin";
          pkg = pkgs.vimPlugins.catppuccin-nvim;
        };
        colorful-winsep-nvim = {
          name = "colorful-winsep.nvim";
          pkg = colorful-winsep-nvim;
        };
        edgy-nvim = {
          name = "edgy.nvim";
          pkg = pkgs.vimPlugins.edgy-nvim;
        };
        mini-icons = {
          name = "mini.icons";
          pkg = pkgs.vimPlugins.mini-icons;
        };
        neominimap-nvim = {
          name = "neominimap.nvim";
          pkg = neominimap-nvim;
        };
        tiny-glimmer-nvim = {
          name = "tiny-glimmer.nvim";
          pkg = tiny-glimmer-nvim;
        };
        visual-whitespace-nvim = {
          name = "visual-whitespace.nvim";
          pkg = visual-whitespace-nvim;
        };
      };
    };
  };
}
