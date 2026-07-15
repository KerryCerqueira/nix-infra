{
  self,
  lib,
  ...
}: {
  flake = {
    nixosModules =
      lib.genAttrs [
        "claudius"
        "sebastiao"
      ] (host: {config, ...}: {
        sops.secrets."mcp/browser-control" = {
          sopsFile = ./secrets + "${host}/browser-control.key";
          format = "binary";
          owner = "kerry";
          mode = "0400";
        };
      });
    homeModules.mcp = {
      osConfig,
      pkgs,
      lib,
      ...
    }: {
      programs.mcp.servers.browser-control = {
        args = [];
        command = let
          secretPath = osConfig.sops.secrets."mcp/browser-control".path;
        in
          lib.getExe
          (
            pkgs.writeShellScriptBin
            "browser-control-mcp-wrapped"
            ''
              export EXTENSION_SECRET="$(cat ${secretPath})"
              export EXTENSION_PORT="8089"
              exec ${lib.getExe self.packages.${pkgs.system}.browser-control-mcp} "$@"
            ''
          );
      };
    };
  };
  perSystem = {pkgs, ...}: {
    packages.browser-control-mcp = pkgs.buildNpmPackage (finalAttrs: {
      pname = "browser-control-mcp";
      version = "1.5.1";
      src = pkgs.fetchFromGitHub {
        owner = "eyalzh";
        repo = "browser-control-mcp";
        rev = "ae0d0d380a30f36ba9e80f6ce69cf4c5e9cf473c";
        hash = "sha256-kq29H/E+L/jsT7VNBnlcX6QKGjUbpDSDBQEbpZx1WV8=";
      };
      sourceRoot = "${finalAttrs.src.name}/mcp-server";
      npmDepsHash = "sha256-C2XXxn1P3COFXdBnNzYGzQwx3GRHv3nfFUvRV8v/MI8=";
      nativeBuildInputs = [pkgs.makeWrapper];
      installPhase = ''
        runHook preInstall
        npm prune --omit=dev
        rm -rf node_modules/@browser-control-mcp
        mkdir -p $out/lib $out/bin
        cp -r dist node_modules package.json $out/lib/
        makeWrapper ${pkgs.lib.getExe pkgs.nodejs} $out/bin/browser-control-mcp \
          --add-flags "$out/lib/dist/server.js"
        runHook postInstall
      '';
      meta.mainProgram = "browser-control-mcp";
    });
  };
}
