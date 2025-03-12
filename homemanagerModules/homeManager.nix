{
  config,
  lib,
  ...
}: {
  options = {
    homeManagerModules.homeManager.enable = lib.mkEnableOption "Enable homemanager";
  };

  config = lib.mkIf config.homeManagerModules.homeManager.enable {
    home = {
      username = "keynold";
      homeDirectory = "/home/keynold";
      stateVersion = "24.05";
    };
    nixpkgs = {
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
    programs.home-manager.enable = true;
  };
}
