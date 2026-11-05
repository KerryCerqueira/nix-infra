{self, ...}: {
  flake.wrappers.opencode = {
    config,
    wlib,
    lib,
    pkgs,
    ...
  }: let
    rule = action: resource: effect: {inherit action resource effect;};
  in {
    imports = [wlib.wrapperModules.opencode];
    settings = {
      "$schema" = "https://opencode.ai/config.json";
      permissions = [
        (rule "*" "*" "ask")
        (rule "glob" "*" "allow")
        (rule "grep" "*" "allow")
        (rule "read" "*.env" "ask")
        (rule "read" "*.env.*" "ask")
        (rule "read" "*.env.example" "allow")
        (rule "question" "*" "allow")
        (rule "todowrite" "*" "allow")
        (rule "skill" "*" "allow")
        (rule "subagent" "*" "allow")
        (rule "webfetch" "*" "deny")
        (rule "websearch" "*" "deny")
      ];
      policies = [
        (rule "provider.use" "*" "deny")
        (rule "provider.use" "imhr" "allow")
        (rule "plugin.use" "*" "deny")
      ];
      share = "disabled";
      update = "disable";
      websearch = false;
      warming = false;
    };
    # nixpkgs #582673 and #583530.
    package = pkgs.opencode.overrideAttrs (old: {
      node_modules = old.node_modules.overrideAttrs {
        outputHash = "sha256-prx9dX7kUvs/E3zopkaPk5LXh3xJAy5sZeum/W8L7cA=";
      };
    });
    env = {
      OPENCODE_DISABLE_MODELS_FETCH = "1";
    };
    buildCommand.validateConfig = {
      after = ["constructFiles"];
      data =
        lib.throwIfNot (lib.versionAtLeast config.package.version "2")
        "wrappers.opencode targets the OpenCode 2 config schema; the package is ${config.package.version}."
        ''
          ${lib.getExe pkgs.buildPackages.check-jsonschema} \
            --force-filetype=json \
            --schemafile=${lib.escapeShellArg config.package.passthru.jsonschema.config} \
            ${lib.escapeShellArg config.constructFiles.opencodeConfig.path}
        '';
    };
  };
  flake.homeModules.opencode = {
    config,
    lib,
    ...
  }: {
    imports = [self.wrappers.opencode.install];
    home.packages = [config.wrappers.opencode.wrapper];
    wrappers.opencode.settings.mcp.servers =
      lib.mapAttrs (
        _: server:
          (
            if server.url != null
            then
              {
                type = "remote";
                inherit (server) url;
              }
              // lib.optionalAttrs (server.headers != {}) {inherit (server) headers;}
            else
              {
                type = "local";
                command = [server.command] ++ server.args;
              }
              // lib.optionalAttrs (server.env != {}) {
                environment = lib.hm.mcp.renderEnv (path: "{file:${path}}") server.env;
              }
          )
          // lib.optionalAttrs (server.enabled != null) {disabled = !server.enabled;}
      )
      config.programs.mcp.servers;
  };
  deployments.homeModules.opencode = [
    "kerry-claudius"
    "kerry-sebastiao"
  ];
}
