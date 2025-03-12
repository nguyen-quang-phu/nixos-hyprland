{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: {
  options = {
    homeManagerModules = {
      editor = {
        enable = lib.mkEnableOption "Enable editor (config)";
      };
    };
  };

  config = lib.mkIf config.homeManagerModules.editor.enable {
    programs = {
      neovim = {
        enable = true;
        withNodeJs = true;
        withRuby = true;
        withPython3 = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        defaultEditor = true;
      };

      vscode = {
        enable = true;
        mutableExtensionsDir = false;
        package = pkgs.vscodium;
        profiles = {
          default = {
            enableExtensionUpdateCheck = false;
            enableUpdateCheck = false;
            extensions = with pkgs.vscode-extensions; [
              eamodio.gitlens
              catppuccin.catppuccin-vsc-icons
              catppuccin.catppuccin-vsc
            ];
            userSettings = {
              "files.autoSave" = "onFocusChange";
              "merge-conflict.autoNavigateNextConflict.enabled" = true;
              "git.mergeEditor" = true;
            };
          };
        };
      };

      yazi = {
        enable = true;
        enableZshIntegration = true;
        enableNushellIntegration = true;
      };

      zellij = {
        enable = true;
        enableZshIntegration = false;
      };
    };
    home.sessionVariables = {
      EDITOR = "nvim";
    };

    home.packages = with pkgs; [
      # node
      nodejs
      # c/c++
      gcc
      pandoc
      # nix
      deadnix
      nil
      nixd
      alejandra
      statix
      # typo
      typos-lsp
      # lua
      luajitPackages.luacheck
      lua-language-server
      codeium
      # json
      nodePackages.vscode-json-languageserver
      # yaml
      yaml-language-server
      # latex
      texliveFull
      texlab
      # all
      ctags-lsp
      # go
      golangci-lint-langserver
      delve
      marksman
      markdownlint-cli2
      markdown-oxide
      # proto
      protobuf
      buf
      protols
      clang-tools
      # js/ts
      angular-language-server
      vue-language-server
      svelte-language-server
      #docker
      docker-compose-language-service
      docker-ls
      dockerfile-language-server-nodejs
      hadolint
      #graphql
      # nodePackages.graphql-language-service-cli
      #sql
      sqlfluff
      #tools
      fd
    ];
  };
}
