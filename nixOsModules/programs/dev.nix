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
      vscode
      alejandra
      gh
      silicon
      inputs.zen-browser.packages."x86_64-linux".default
    ];
  };
}
