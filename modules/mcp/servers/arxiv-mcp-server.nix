{self, inputs, ...}: {
  flake.mcp.pythonOverrides = [
    (final: prev: {
      sgmllib3k = prev.sgmllib3k.overrideAttrs (old: {
        nativeBuildInputs =
          (old.nativeBuildInputs or [])
          ++ [
            final.setuptools
          ];
      });
    })
  ];
  perSystem = {
    pkgs,
    config,
    ...
  }: let
    mkPythonMcp = self.lib.mkPythonMcp {
      inherit pkgs;
      inherit (inputs) uv2nix pyproject-build-systems;
    };
  in {
    packages.arxiv-mcp-server = mkPythonMcp {
      pname = "arxiv-mcp-server";
      entrypoint = "arxiv-mcp-server";
      src = pkgs.fetchFromGitHub {
        owner = "blazickjp";
        repo = "arxiv-mcp-server";
        rev = "0065f5abb48f3eb4e011a130dd63fc52b381a1d2";
        hash = "sha256-WuPsE5YFDArtnbTL4wISfacp0IXVNi89JMRmXuX9v1s=";
      };
    };
  };
}
