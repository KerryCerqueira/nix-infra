{
  flake.nixosModules.nix-ld = {pkgs, ...}: {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib
        zlib
        glib
        glibc
        openssl
        libxml2
        libz
        libGL
        libxkbcommon
        fontconfig
        freetype
        xorg.libX11
        xorg.libXext
        xorg.libXrender
        xorg.libICE
        xorg.libSM
        gfortran.cc.lib
        curl
      ];
    };
  };
}
