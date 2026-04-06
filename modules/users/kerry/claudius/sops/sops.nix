{
  flake.homeModules."kerry@claudius" = {config, ...}: {
    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/kerry_claudius.age";
      secrets = {
        "apiKeys/tavily" = {};
        "apiKeys/huggingface" = {};
        "apiKeys/openai" = {};
      };
    };
  };
}
