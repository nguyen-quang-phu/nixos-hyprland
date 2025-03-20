{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    locale = {
      enable = lib.mkEnableOption "Enable locales, timezone, keymap";

      timeZone = lib.mkOption {
        type = lib.types.str;
        default = "Asia/Ho_Chi_Minh";
        description = "The time zone to use.";
      };

      defaultLocale = lib.mkOption {
        type = lib.types.str;
        default = "en_US.UTF-8";
        description = "The default locale to use.";
      };

      extraLocale = lib.mkOption {
        type = lib.types.str;
        default = "vi_VN";
        description = "The extra locale to use.";
      };

      keyboard = lib.mkOption {
        type = lib.types.str;
        default = "us";
        description = "The keyboard layout to use.";
      };
    };
  };

  config = lib.mkIf config.locale.enable (let
    inherit (config) locale;
  in {
    time = {inherit (locale) timeZone;};
    i18n = {
      inherit (locale) defaultLocale;

      extraLocaleSettings = {
        LC_ADDRESS = locale.extraLocale;
        LC_IDENTIFICATION = locale.extraLocale;
        LC_MEASUREMENT = locale.extraLocale;
        LC_MONETARY = locale.extraLocale;
        LC_NAME = locale.extraLocale;
        LC_NUMERIC = locale.extraLocale;
        LC_PAPER = locale.extraLocale;
        LC_TELEPHONE = locale.extraLocale;
        LC_TIME = locale.extraLocale;
      };
      inputMethod = {
        # type = "fcitx5";
        enable = false;
        fcitx5 = {
          waylandFrontend = true;
          addons = with pkgs; [
            fcitx5-gtk # alternatively, kdePackages.fcitx5-qt
            fcitx5-configtool
            fcitx5-nord # a color theme
            fcitx5-unikey
            fcitx5-bamboo
          ];
          # settings.inputMethod = {};
        };
      };
    };
    services = {
      xserver = {
        # Configure keymap in X11
        xkb = {
          layout = locale.keyboard;
          variant = "";
        };
        desktopManager.runXdgAutostartIfNone = true;
      };
    };

    # Configure console keymap
    console.keyMap = locale.keyboard;
  });
}
