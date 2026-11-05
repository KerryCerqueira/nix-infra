{lib, ...}: {
  flake = let
    targets = [
      "kerry-sebastiao"
      "kerry-claudius"
    ];
  in {
    nixosModules = lib.genAttrs targets (_: {config, ...}: {
      sops.secrets.opencode-imhr = {
        sopsFile = ./secrets/imhr;
        format = "binary";
        owner = "kerry";
        mode = "0400";
      };
    });
    homeModules = lib.genAttrs targets (_: {osConfig, ...}: let
      rule = action: resource: effect: {inherit action resource effect;};
    in {
      wrappers.opencode.settings = {
        model = "imhr/qwen3.8-flash-next";
        providers.imhr = {
          models = {
            "qwen3.8-flash-next" = {};
            "qwen3.8-27b" = {};
          };
          name = "IMHR self-hosted models";
          package = "@opencode/ai/providers/openai-compatible";
          settings = {
            baseURL = "https://simulator.bic.theroyal.ca/api";
            apiKey = "{file:${osConfig.sops.secrets.opencode-imhr.path}}";
            policies = [(rule "provider.use" "imhr" "allow")];
          };
        };
      };
    });
  };
}
