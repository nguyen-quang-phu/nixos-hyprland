{pkgs, ...}: 
  pkgs.writeShellScriptBin "random-wall" ''
    wallpapers=(
      "${../../assets/wallpaper/ryo-vending.png}"
    )

    WALLPAPER="''${wallpapers[RANDOM % ''${#wallpapers[@]}]}"

    echo hyprpaper preload "''${WALLPAPER}"
    hyprctl hyprpaper preload "''${WALLPAPER}"
    hyprctl hyprpaper wallpaper ",''${WALLPAPER}"
  ''
