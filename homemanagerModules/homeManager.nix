{
  config,
  lib,
  ...
}: {
  options = {
    homeManagerModules.homeManager.enable = lib.mkEnableOption "Enable homemanager";
  };

  config = lib.mkIf config.homeManagerModules.homeManager.enable {
    home.username = "keynold";
    home.homeDirectory = "/home/keynold";

    home.stateVersion = "24.05"; # Dont'change

    programs.home-manager.enable = true;
  };
}
