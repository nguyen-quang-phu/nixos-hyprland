{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: {
  options = {
    homeManagerModules = {
      cli = {
        enable = lib.mkEnableOption "Enable cli (config)";
      };
    };
  };

  config = lib.mkIf config.homeManagerModules.cli.enable {
    programs = {
      atuin = {
        enable = true;

        enableBashIntegration = true;
        enableFishIntegration = true;
        enableNushellIntegration = true;
        enableZshIntegration = true;

        flags = [];
        settings = {};
      };

      bat = {
        enable = true;
        config = {
          pager = "less -FR";
          theme = "Catppuccin Mocha";
        };
        themes = {
          "Catppuccin Mocha" = {
            src = pkgs.fetchFromGitHub {
              owner = "catppuccin";
              repo = "bat";
              rev = "d714cc1d358ea51bfc02550dabab693f70cccea0";
              sha256 = "1zlryg39y4dbrycjlp009vd7hx2yvn5zfb03a2vq426z78s7i423";
            };
            file = "themes/Catppuccin Mocha.tmTheme";
          };
        };
      };

      eza = {
        enable = true;
        enableZshIntegration = true;
        enableNushellIntegration = true;
        git = true;
        icons = "auto";
        extraOptions = [
          "--group-directories-first"
          "--header"
        ];
      };

      fd = {
        enable = true;
        ignores = [
          "*.bak"
          ".git/"
          "node_modules/"
          "vendor/"
        ];
      };

      jq = {
        enable = true;
      };

      mise = {
        enable = true;

        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };

      ripgrep = {
        enable = true;
        arguments = [
          "--no-require-git"
        ];
      };
    };
  };
}
