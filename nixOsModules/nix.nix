{
  lib,
  config,
  ...
}: {
  options = {
    nixModule.enable = lib.mkEnableOption "Enable nix settings";
    nixModule.stateVersion = lib.mkOption {
      type = lib.types.str;
      default = "24.05";
      description = "The state version to use";
    };
  };

  config = lib.mkIf config.nixModule.enable {
    nixpkgs = {
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
        permittedInsecurePackages = [
          "electron-32.3.3"
        ];
      };
    };
    nix.settings.experimental-features = ["nix-command" "flakes"];
    system.stateVersion = config.nixModule.stateVersion;
  };
}
