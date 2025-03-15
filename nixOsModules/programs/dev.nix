{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
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
      inputs.zen-browser.packages."x86_64-linux".default
      inputs.agenix.packages."x86_64-linux".default
    ];
  };
}
