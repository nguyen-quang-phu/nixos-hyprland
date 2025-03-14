{pkgs, ...}: let
  colors = import ../../colors.nix;
  hex = colors.hex;
in {
  imports = [../../homemanagerModules/default.nix];
  homeManagerModules = {
    git.enable = true;
    ssh.enable = true;
    editor.enable = true;
    homeManager.enable = true;
    music.enable = true;
    cli.enable = true;

    gtk.enable = true;
    tmux.enable = true;
    hyprpaper = {
      enable = true;
      path = ../../assets/wallpaper/ryo-vending.png;
    };
    hyprlock = {
      enable = true;
      background = ../../assets/lockscreen.png;
    };
    hyprland.enable = true;
    hypridle.enable = true;
    moxide = import ./moxide.nix;
    rofi.enable = true;
    zsh.enable = true;
    starship.enable = true;
    terminals.enable = true;
    zathura.enable = true;

    river.enable = false;
    waybar.enable = false;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  services.mpris-proxy.enable = true;

  gtk.gtk3.bookmarks = [
    "file:///home/dlurak/SoftwareDevelopment/"
    "file:///home/dlurak/Dotfiles"
    "file:///home/dlurak/Pictures/"
    "file:///home/dlurak/Downloads"
    "file:///home/dlurak/Schule/"
    "file:///home/dlurak/Schule/E-1/Notizen/"
  ];

  home.file.".peaclock/config".text = ''
    set seconds on
    style active-bg ${hex.pink}
    style date ${hex.pink}
  '';

  xdg.desktopEntries = {
    peaclock = {
      name = "Peaclock";
      genericName = "Clock";
      exec = "${pkgs.ghostty}/bin/ghostty --command=\"${pkgs.peaclock}/bin/peaclock\"";
      terminal = false;
      categories = ["Applications"];
    };
  };
}
