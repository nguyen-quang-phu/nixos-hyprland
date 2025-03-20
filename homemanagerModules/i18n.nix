{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: {
  options = {
    homeManagerModules = {
      i18n = {
        enable = lib.mkEnableOption "Enable i18n (config)";
      };
    };
  };

  config = lib.mkIf config.homeManagerModules.i18n.enable {
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-gtk # alternatively, kdePackages.fcitx5-qt
        fcitx5-configtool
        fcitx5-nord # a color theme
        fcitx5-bamboo
      ];
    };
  };
}
