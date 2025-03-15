{
  pkgs,
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
      shellAliases = {
        "..." = "cd ../..";
        ":q" = "exit";
        code = "codium";
        hy = "Hyprland";
        pbcopy = "xclip -selection clipboard";
        pbpaste = "xclip -selection clipboard -o";
        ze = "zellij";
        cd = "z";
        cx = "chmod +x";
        grep = "grep --color=auto";
        ls = "${pkgs.coreutils}/bin/ls --color=auto";
        window-class = "${pkgs.hyprland}/bin/hyprctl clients -j | jq \".[].class\" -r";
      };
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
