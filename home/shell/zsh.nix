{
  config,
  lib,
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
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -lah --group-directories-first";
      };
    };
  };
}
