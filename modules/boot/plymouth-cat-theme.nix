{
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.plymouth-theme-cat = pkgs.stdenvNoCC.mkDerivation {
      pname = "plymouth-theme-cat";
      version = "0-unstable-2025-01-09";
      src = pkgs.fetchFromGitHub {
        owner = "krishnan793";
        repo = "PlymouthTheme-Cat";
        rev = "9f9bbc0e6cb8677684d198eb1139d90aceff82e0";
        hash = "sha256-yNryZkjSDFYGTExCz6Dkoust749QK65JYoCIO2oN+Y4=";
      };
      dontConfigure = true;
      dontBuild = true;
      installPhase = ''
        runHook preInstall

        mkdir -p $out/share/plymouth/themes/PlymouthTheme-Cat
        cp -r ./* $out/share/plymouth/themes/PlymouthTheme-Cat/

        find $out/share/plymouth/themes/ -name '*.plymouth' \
          -exec sed -i "s@/usr/@$out/@" {} \;

        runHook postInstall
      '';
      meta = {
        description = "Cat animation Plymouth boot splash theme";
        homepage = "https://github.com/krishnan793/PlymouthTheme-Cat";
        license = lib.licenses.gpl3Only;
        platforms = lib.platforms.linux;
      };
    };
  };
}
