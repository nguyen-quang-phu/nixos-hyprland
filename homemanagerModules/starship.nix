{
  config,
  lib,
  ...
}: {
  options = {
    homeManagerModules.starship.enable = lib.mkEnableOption "Enable starship config";
  };
  config = lib.mkIf config.homeManagerModules.starship.enable {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        format = "$shell$username$hostname$localip$shlvl$singularity$kubernetes$directory$vcsh$fossil_branch$fossil_metrics$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch$pijul_channel$docker_context$package$c$cmake$cobol$daml$dart$deno$dotnet$elixir$elm$erlang$fennel$gleam$golang$guix_shell$haskell$haxe$helm$java$julia$kotlin$gradle$lua$nim$nodejs$ocaml$opa$perl$php$pulumi$purescript$python$quarto$raku$rlang$red$ruby$rust$scala$solidity$swift$terraform$typst$vlang$vagrant$zig$buf$nix_shell$conda$meson$spack$memory_usage$aws$gcloud$openstack$azure$nats$direnv$env_var$crystal$custom$sudo$cmd_duration$line_break$jobs$battery$time$status$os$container$character";
        add_newline = false;
        shell = {
          disabled = false;
          format = "[$indicator]($style): ";
        };
        username = {
          show_always = true;
          format = "💻 [$user]($style)@";
        };
        hostname = {
          disabled = false;
          format = "[$ssh_symbol$hostname]($style) ";
          ssh_only = false;
        };
        directory = {
          format = "📁 [$path]($style)[$read_only]($read_only_style) ";
        };
        git_branch = {
          always_show_remote = true;
          format = "[$symbol$branch(:$remote_branch)]($style)";
        };
        # character = {
        #   success_symbol = "[λ](bold blue)";
        #   error_symbol = "[λ](bold red)";
        #   vimcmd_symbol = "[V](bold yellow)";
        #   format = " [╰─](bold blue)$symbol";
        # };
        # username = {
        #   format = " [╭─$user](bold blue)";
        #   show_always = true;
        # };
        # hostname = {
        #   disabled = false;
        #   format = "[$hostname](bold dimmed blue)";
        #   ssh_only = false;
        # };
        # directory = {
        #   style = "purple";
        #   truncate_to_repo = true;
        #   truncation_length = 0;
        #   truncation_symbol = "…/";
        #   read_only = " ";
        # };
        # git_metrics = {
        #   added_style = "bold blue";
        #   format = "[+$added]($added_style)/[-$deleted]($deleted_style)";
        # };
        # git_branch = {
        #   symbol = "󰘬 ";
        #   # ignore_branches = ["master" "main"];
        #   format = "[$symbol$branch(:$remote_branch)]($style)";
        # };
        # nix_shell = {
        #   symbol = "󱄅 ";
        #   format = "[$symbol](cyan) ";
        # };
        # nodejs.symbol = " ";
        # rust.symbol = " ";
        # python.symbol = " ";
      };
    };
  };
}
