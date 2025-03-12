{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  username = config.homeManagerModules.git.userName;
  useremail = config.homeManagerModules.git.email;
in {
  options = {
    homeManagerModules = {
      ssh = {
        enable = lib.mkEnableOption "Enable ssh (config)";
      };
    };
  };

  config = lib.mkIf config.homeManagerModules.ssh.enable {
    programs = {
      ssh = {
        enable = true;
        addKeysToAgent = "yes";
        matchBlocks = {
          env = {
            host = "*";
            setEnv = {
              TERM = "xterm-256color";
            };
          };
          github-nqp = {
            host = "github.com-nqp";
            hostname = "github.com";
            identitiesOnly = true;
            identityFile = osConfig.age.secrets.github-nqp.path;
          };
          # gitlab-nqp = {
          #   host = "gitlab.com-nqp";
          #   hostname = "gitlab.com";
          #   identitiesOnly = true;
          #   identityFile = config.age.secrets.gitlab-nqp.path;
          # };
        };
      };
    };
  };
}
