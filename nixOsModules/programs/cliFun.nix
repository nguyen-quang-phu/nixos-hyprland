{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    program.funCli.enable = lib.mkEnableOption "Enable useless but fun cli programs";
  };

  config = lib.mkIf config.program.funCli.enable {
    environment.systemPackages = with pkgs; [
      asciiquarium
      cbonsai
      clolcat
      lolcat
      cmatrix
      cowsay
      fastfetch
      inputs.retch.defaultPackage.${pkgs.system}
      figlet
      neofetch
      nitch
      stow
      pipes-rs
      sl
      toilet
      (fortune.override {withOffensive = true;})
      peaclock
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
    ];
  };
}
