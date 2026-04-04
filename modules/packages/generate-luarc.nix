{...}: {
  perSystem = {
    self',
    pkgs,
    ...
  }: {
    packages.generate-luarc = let
      luarcJson =
        self'.packages.neovim.passthru.configuration.lazy.luarcJson;
    in
      pkgs.writeShellScriptBin "generate-luarc" ''
        cat <<'EOF' | ${pkgs.jq}/bin/jq .
        ${luarcJson}
        EOF
      '';
  };
}
