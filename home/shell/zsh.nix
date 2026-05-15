{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.homeModules.shell.zsh = {
    enable = lib.mkEnableOption "zsh shell";
    default = lib.mkEnableOption "set zsh as the default shell" // {
      default = true;
    };
  };

  config = lib.mkIf config.homeModules.shell.zsh.enable {
    programs.zsh = {
      enable = true;
      # enableCompletion = true;
      # autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.zsh-autosuggestions;
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.zsh-syntax-highlighting;
        }
        {
          name = "zsh-completions";
          src = pkgs.zsh-completions;
        }
        {
          name = "zsh-history-substring-search";
          src = pkgs.zsh-history-substring-search;
        }
      ];

      shellAliases = {
        ll = "ls -lah --group-directories-first";
      };

      initContent = ''
        bindkey '^F' autosuggest-accept
      '';
    };
  };
}
