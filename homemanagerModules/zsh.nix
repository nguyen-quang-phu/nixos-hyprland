{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    homeManagerModules.zsh.enable = lib.mkEnableOption "Enable zsh config";
  };
  config = lib.mkIf config.homeManagerModules.zsh.enable {
    programs.zsh = {
      enable = true;
      completionInit = "compinit && autoload -Uz compinit";
      initExtra = ''
              ##########
              ## EVAL ##
              ##########
              eval "$(${pkgs.fzf}/bin/fzf --zsh)"

              ##############
              ## SETTINGS ##
              ##############
              bindkey -v
              bindkey -M viins '^n' history-search-forward
              bindkey -M viins '^p' history-search-backward

        bindkey -M viins '^e' edit-command-line
        autoload edit-command-line; zle -N edit-command-line

              HISTSIZE=5000
              HISTFILE=~/.zsh_history
              SAVEHIST=$HISTSIZE
              HISTDUP=erease

              setopt appendhistory
              setopt sharehistory
              setopt hist_ignore_space
              setopt hist_ignore_all_dups
              setopt hist_save_no_dups
              setopt hist_ignore_dups
              setopt hist_find_no_dups

              zstyle ':completion:*' list-colors "$\{s.:. LS_COLORS}"

              nitch
      '';
    };
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.nushell = {
      enable = true;
    };
  };
}
