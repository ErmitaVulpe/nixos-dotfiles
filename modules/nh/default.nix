{
  config,
  lib,
  ...
}:
let
  cfg = config.nixosModules.nh;
in
{
  options.nixosModules.nh = {
    enable = lib.mkEnableOption "nix helper (nh)" // {
      default = true;
    };
    flake = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "/home/winter/nixos-dotfiles";
      description = "Path to the flake to rebuild with";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      flake = lib.mkIf (!isNull cfg.flake) cfg.flake;
    };
  };
}
