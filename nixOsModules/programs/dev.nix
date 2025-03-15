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
      just
      python3
      stow
      alejandra
      gh
      vim
      silicon
      harper
      xclip
      inputs.zen-browser.packages."${system}".default
      inputs.agenix.packages."${system}".default
      inputs.yt-x.packages."${system}".default
    ];
  };
}
