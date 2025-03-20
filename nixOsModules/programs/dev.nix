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
      inputs.zen-browser.packages."${system}".default
      inputs.agenix.packages."${system}".default
      inputs.yt-x.packages."${system}".default
    ];
  };
}
# https://github.com/latex-lsp/tree-sitter-latex
