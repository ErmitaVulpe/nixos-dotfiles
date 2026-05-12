{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.homeModules.terminal.foot = {
    enable = lib.mkEnableOption "foot";
  };

  config = lib.mkIf config.homeModules.terminal.foot.enable {
    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "JetBrainsMono Nerd Font:size=11:style=Regular";
          dpi-aware = "yes";
          pad = "3x3 center";
          resize-by-cells = "no";
        };

        scrollback = {
          lines = 0;
        };

        mouse = {
          hide-when-typing = "yes";
        };

        csd = {
          size = 0; # Disables titlebar
        };

        colors-dark = {
          cursor = "0C0C0C B6B8BB";

          foreground = "FFFFFF";
          background = "000000";

          regular0 = "000000";
          regular1 = "CC5555";
          regular2 = "55CC55";
          regular3 = "CDCD55";
          regular4 = "5455CB";
          regular5 = "CC55CC";
          regular6 = "7ACACA";
          regular7 = "CCCCCC";

          bright0 = "555555";
          bright1 = "FF5555";
          bright2 = "55FF55";
          bright3 = "FFFF55";
          bright4 = "5555FF";
          bright5 = "FF55FF";
          bright6 = "55FFFF";
          bright7 = "FFFFFF";
        };
      };
    };
  };
}
