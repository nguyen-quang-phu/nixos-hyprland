{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    program.cliMinimal.enable = lib.mkEnableOption "Enable minimal cli programs";
  };

  config = lib.mkIf config.program.cliMinimal.enable {
    environment.systemPackages = with pkgs; [
      # git
      # vim
      nh
      # neovim
      # ripgrep
      # tmux
      (import ../derivations/moxide.nix {inherit pkgs;})
      (import ../derivations/mox.nix {inherit pkgs;})
      # jq
    ];
    programs.nano.enable = false;
  };
}
