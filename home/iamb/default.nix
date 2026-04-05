{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.homeModules.iamb = {
    enable = lib.mkEnableOption "iamb";
    profiles = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      example = {
        Zerda = "@zerda:simplybush.pl";
      };
      description = "Map of profile names to matrix user ids";
    };
    defaultProfile = lib.mkOption {
      type = lib.types.str;
      description = "The default profile specified in profiles to be used";
    };
  };

  config = lib.mkIf config.homeModules.iamb.enable {
    programs.iamb = {
      enable = true;
      # TEMP fix for https://github.com/NixOS/nixpkgs/issues/501937
      package = pkgs.iamb.overrideAttrs (oldAttrs: {
        patches = (oldAttrs.patches or [ ]) ++ [
          ./recursion-fix.patch
        ];
      });
      settings = {
        default_profile = config.homeModules.iamb.defaultProfile;
        profiles = lib.mapAttrs' (name: value: {
          name = name;
          value = {
            user_id = value;
          };
        }) config.homeModules.iamb.profiles;
        settings = {
          notifications.enabled = true;
          image_preview.protocol = {
            type = "sixel";
            size = {
              height = 10;
              width = 66;
            };
          };
        };
      };
    };
  };
}
