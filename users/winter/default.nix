{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  username = "winter";
  finalHomeModules = config.home-manager.users.${username}.homeModules;
  customLoginShell =
    if (finalHomeModules.shell.zsh.default && finalHomeModules.shell.zsh.enable) then "zsh" else null;
in
{
  options = with lib.types; {
    users.users = lib.mkOption {
      type = attrsOf (submodule {
        options.config = lib.mkOption {
          type = lib.types.attrs;
          default = { };
          example = {
            bullshit.enable = true;
            gtkTheme = "carbonfox";
          };
          description = "Config for home modules";
        };
      });
    };
  };

  config = {
    programs = lib.mkMerge [
      (lib.mkIf (customLoginShell == "zsh") {
        zsh.enable = true;
      })
    ];

    users.users."${username}" = {
      isNormalUser = true;
      group = "${username}";
      extraGroups = [
        "network"
        "wheel"
        "wireshark"
      ];
      shell = lib.mkIf (customLoginShell != null) pkgs."${customLoginShell}";
      initialHashedPassword = "$y$j9T$CJyHPv2s.on.ZRekXaXL50$h6cGCKZU2nKZ/zarN1hWLM8oU99rvBGBs9DG2qtl3yB";
    };
    users.groups."${username}" = { };
    home-manager = {
      extraSpecialArgs = {
        inherit inputs;
      };
      users."${username}" = import ./home.nix {
        inherit
          config
          inputs
          lib
          pkgs
          username
          ;
      };
    };
  };
}
