{
  config,
  lib,
  ...
}: {
  options = {
    homeManagerModules.terminals.enable = lib.mkEnableOption "Enable the terminal module";
  };

  config = lib.mkIf config.homeManagerModules.terminals.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "JetBrains Mono";
        size = 13;
      };
      settings = {
        enable_audio_bell = false;
        confirm_os_window_close = 0;
      };
      themeFile = "tokyo_night_night";
    };

    programs.ghostty = {
      enable = true;
      enableBashIntegration = true;
      # clearDefaultKeybinds = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      installBatSyntax = true;
      installVimSyntax = true;
      settings = {
        theme = "catppuccin-mocha";
        macos-titlebar-proxy-icon = "hidden";
        title = "";
        clipboard-trim-trailing-spaces = true;
        copy-on-select = true;
        window-decoration = false;
        fullscreen = true;
        clipboard-read = "allow";
        clipboard-write = "allow";
        shell-integration = "zsh";
        keybind = "ctrl+v=paste_from_clipboard";
      };
    };
  };
}
