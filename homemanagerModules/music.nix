{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: {
  options = {
    homeManagerModules = {
      music = {
        enable = lib.mkEnableOption "Enable music (config)";
      };
    };
  };

  config = lib.mkIf config.homeManagerModules.music.enable {
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-gtk # alternatively, kdePackages.fcitx5-qt
        fcitx5-configtool
        fcitx5-nord # a color theme
        fcitx5-unikey
        fcitx5-bamboo
      ];
    };

    home.file."home/keynold/.config/spotify-player/theme.toml".text = builtins.readFile (fetchGit {
        url = "https://github.com/catppuccin/spotify-player.git";
      }
      + "/theme.toml");
    programs = {
      spotify-player = {
        enable = true;
        settings = {
          theme = "Catppuccin-mocha";
        };
      };
      # https://raw.githubusercontent.com/mpv-player/mpv/master/DOCS/man/input.rst
      mpv = {
        enable = true;
        config = {
          volume = 30;
        };
        # https://raw.githubusercontent.com/mpv-player/mpv/master/etc/input.conf
        bindings = {
          "UP" = "add volume +2";
          "DOWN" = "add volume -2";
        };
      };
    };
  };
}
