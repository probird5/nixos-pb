{ config, pkgs, lib, ... }:

{
  programs.opencode = {
    enable = true;

    settings = {
      "$schema" = "https://opencode.ai/config.json";

      # --- Tools: enable only stable core tools ---
      tools = {
        # core file / repo tools
        read  = true;
        glob  = true;
        grep  = true;
        edit  = true;
        write = true;
        bash  = true;

        # disable unstable / unused tools
        skill     = false;
        todowrite = false;
        todoread  = false;
      };

      # --- Agent behavior ---
      agent = {
        # Planning phase: allow inspection, no mutation
        plan = {
          tools = {
            read  = true;
            glob  = true;
            grep  = true;
            bash  = true;

            edit  = false;
            write = false;

            skill     = false;
            todowrite = false;
            todoread  = false;
          };
        };

        # Build phase: allow execution
        build = {
          permission = {
            bash = {
              "*" = "allow";
            };
          };
        };
      };

      # --- Permissions ---
      permission = {
        webfetch = "allow";
        edit = "allow";
      };

      # --- Provider / models ---
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

            "deepseek-coder:33b" = {
              name = "DeepSeek Coder 33B";
            };

            "qwen3-coder:30b" = {
              name = "Qwen3 Coder 30B";
            };

            "gpt-oss:120b" = {
              name = "GPT-OSS 120B";
            };
          };
        };
      };

      # --- Default model ---
      model = "ollama/deepseek-r1:32b";
      # For heavy repo edits, you may prefer:
      # model = "ollama/deepseek-coder:33b";
      # model = "ollama/qwen3-coder:30b";
    };
  };
}

