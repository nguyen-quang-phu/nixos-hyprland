{
  pkgs,
  config,
  ...
}: {
  environment.variables = {
    EDITOR = "nvim";
    FLAKE = "/home/dlurak/Dotfiles/flake";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    CODESTRAL_API_KEY = ''$(${pkgs.coreutils}/bin/cat ${config.age.secrets."CODESTRAL_API_KEY".path}')'';
    OPENAI_API_KEY = ''$(${pkgs.coreutils}/bin/cat ${config.age.secrets."OPENAI_API_KEY".path}')'';
    GEMINI_API_KEY = ''$(${pkgs.coreutils}/bin/cat ${config.age.secrets."GEMINI_API_KEY".path}')'';
  };
}
