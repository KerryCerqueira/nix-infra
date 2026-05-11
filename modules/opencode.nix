{self, ...}: {
  flake.homeModules = {
    opencode = {...}: {
      programs.opencode = {
        enable = true;
        settings.provider.ollama = {
          npm = "@ai-sdk/openai-compatible";
          name = "Ollama";
          options = {
            baseURL = "http://localhost:11434/v1";
            apiKey = "ollama";
          };
          models."qwen3-coder-next:q4_K_M" = {
            name = "Qwen3 Coder Next";
            tools = true;
          };
        };
      };
    };
    "kerry@claudius" = {imports = [self.homeModules.opencode];};
  };
}
