{ config, pkgs, lib, ... }:

{
  programs.opencode = {
    enable = true;

    settings = {
      "$schema" = "https://opencode.ai/config.json";

      provider = {
        ollama = {
          npm = "@ai-sdk/openai-compatible";
          name = "Ollama (192.168.8.25)";

          options = {
            baseURL = "http://192.168.8.25:11434/v1";
          };

          models = {
            "deepseek-r1:32b" = {
              name = "DeepSeek R1 32B";
            };

            "gpt-oss:120b" = {
              name = "GPT-OSS 120B";
            };
          };
        };
      };

      # default model OpenCode will start with
      model = "ollama/deepseek-r1:32b";
    };
  };
}

