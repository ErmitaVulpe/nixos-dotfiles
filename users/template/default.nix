{ config, pkgs, lib, inputs, ... }:
let
  username = "template";
in
{
  options = {
    users.users = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options.homeImports = lib.mkOption {
          type = lib.types.listOf lib.types.path;
          default = [];
          description = "list of additional home modules for this user";
        };
      });
    };
  };

  config = {
    users.users."${username}" = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialHashedPassword = "";
    };
    home-manager = {
      users."${username}" = import ./home.nix { inherit config pkgs lib inputs username; };
    };
  };
}
