{...}: {
  flake.wrappers.neovim = {lib, ...}: {
    options.aspects.lang = {
      nix.enable =
        lib.mkEnableOption
        "nix code editing features";
      python.enable =
        lib.mkEnableOption
        "python code editing features";
      rust.enable =
        lib.mkEnableOption
        "rust code editing features";
      sh.enable =
        lib.mkEnableOption
        "shell script editing features";
      tex.enable =
        lib.mkEnableOption
        "TeX code editing features";
      mdlangs.enable =
        lib.mkEnableOption
        "Data languages editing features";
      markdown.enable =
        lib.mkEnableOption
        "markdown editing features";
      ipynb.enable =
        lib.mkEnableOption
        "iPython notebook features";
    };
  };
}
