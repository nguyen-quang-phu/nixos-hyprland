{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  system = "x86_64-linux";
in {
  options = {
    program.dev.enable = lib.mkEnableOption "Enable minimal cli programs";
  };

  config = lib.mkIf config.program.dev.enable {
    programs.hyprland.enable = true;
    environment.systemPackages = with pkgs; [
      python311Packages.pylatexenc
      just
      python3
      stow
      alejandra
      gh
      vim
      silicon
      harper
      xclip
      obsidian
      ghostscript
      nix-prefetch-scripts
      nix-prefetch-github
      devenv
      tor-browser
      bluetui
      television
      poetry
      google-chrome
      conda
      pulsemixer
      # clipboard-jh
      tuir
      # cloudflared
      inputs.zen-browser.packages."${system}".default
      inputs.agenix.packages."${system}".default
      inputs.yt-x.packages."${system}".default
    ];
  };
}
# https://github.com/latex-lsp/tree-sitter-latex
