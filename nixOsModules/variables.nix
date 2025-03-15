{
  pkgs,
  config,
  ...
}: let
  getSecretValuetValue = key: ''$(${pkgs.coreutils}/bin/cat "${config.age.secrets.${key}.path}")'';
in {
  environment.variables = {
    EDITOR = "nvim";
    FLAKE = "/home/keynold/.config/nixos";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    CODESTRAL_API_KEY = getSecretValuetValue "CODESTRAL_API_KEY";
    OPENAI_API_KEY = getSecretValuetValue "OPENAI_API_KEY";
    GEMINI_API_KEY = getSecretValuetValue "GEMINI_API_KEY";
  };
}
