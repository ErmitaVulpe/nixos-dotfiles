{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homeModules.launcher.otter-launcher;
  toml = pkgs.formats.toml { };
in
{
  options.homeModules.launcher.otter-launcher = {
    enable = lib.mkEnableOption "otter-launcher";

    terminalCmd = lib.mkOption {
      description = "Command to use to start a new terminal window";
      type = lib.types.str;
      default = "foot";
      example = "alacritty -e";
    };

    size = {
      width = lib.mkOption {
        description = "Width of the terminal window";
        type = lib.types.int;
        default = 58;
        readOnly = true;
      };
      height = lib.mkOption {
        description = "Height of the terminal window";
        type = lib.types.int;
        default = 9;
        readOnly = true;
      };
    };
  };

  imports = [
    inputs.otter-launcher.homeModules.default
  ];

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      fsel
    ];

    programs.otter-launcher = {
      enable = true;
    };

    xdg.configFile."fsel/config.toml".source = toml.generate "config.toml" {
      terminal_launcher = cfg.terminalCmd;
    };
  };
}
