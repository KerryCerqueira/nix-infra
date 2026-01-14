{pkgs, ...}: let
  videre-nvim = let
    commitDate = "2025-09-21T15:24:55-04:00";
    version = "unstable-" + commitDate;
    rev = "224bfb4909d833f6b2282a14ca65464279d34b33";
    hash = "sha256-REv8rD9s6g1VbUsfR2xrHZNXePETXPrw83cIHAk1HoQ=";
  in
    pkgs.vimUtils.buildVimPlugin {
      pname = "videre.nvim";
      inherit version;
      src = pkgs.fetchFromGitHub {
        owner = "Owen-Dechow";
        repo = "videre.nvim";
        inherit rev hash;
      };
    };
  graph-view-yaml-parser = let
    commitDate = "2025-08-04T17:50:03-04:00";
    version = "unstable-" + commitDate;
    rev = "ecc5ba0a0b8c3a6eb3e7fa5a2caeeee2263729c3";
    hash = "sha256-nZyAHAoulTLwq4IVLlWd0kZ9je+9Upe7jY3apAt3anw=";
  in
    pkgs.vimUtils.buildVimPlugin {
      pname = "graph-view-yaml-parser";
      inherit version;
      src = pkgs.fetchFromGitHub {
        owner = "Owen-Dechow";
        repo = "graph_view_yaml_parser";
        inherit rev hash;
      };
    };
  graph-view-toml-parser = let
    commitDate = "2025-08-04T18:20:16-04:00";
    version = "unstable-" + commitDate;
    rev = "e52ddcbae563c924a19faf998f862ae61d13a777";
    hash = "sha256-g8ZVxr471bPfzSu/TZf+kWl9I1vDcVPAEsvNroiGkbg=";
  in
    pkgs.vimUtils.buildVimPlugin {
      pname = "graph-view-toml-parser";
      inherit version;
      src = pkgs.fetchFromGitHub {
        owner = "Owen-Dechow";
        repo = "graph_view_toml_parser";
        inherit rev hash;
      };
    };
  xml2lua-nvim = let
    commitDate = "2025-07-21T10:12:14+02:00";
    version = "unstable-" + commitDate;
    rev = "c5fa33ad038958e9592df06e8ca6a88f4e7543aa";
    hash = "sha256-39efA9KLsCndTsZeV08MYl88xXco/xsk5jQ7Jvm1f4Y=";
  in
    pkgs.vimUtils.buildVimPlugin {
      pname = "xml2lua.nvim";
      inherit version;
      src = pkgs.fetchFromGitHub {
        owner = "a-usr";
        repo = "xml2lua.nvim";
        inherit rev hash;
      };
    };
in {
  programs.neovim.plugins = [
    videre-nvim
    graph-view-toml-parser
    graph-view-yaml-parser
    xml2lua-nvim
  ];
  xdg.configFile = {
    "nvim/lua/plugins/ui/videre-nvim.lua".source =
      ../../src/lua/plugins/ui/videre-nvim.lua;
  };
}
