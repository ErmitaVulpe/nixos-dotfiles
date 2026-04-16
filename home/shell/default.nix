{ config, ... }:
{
  imports = [
    ./fish.nix
    ./zsh.nix
  ];

  assertions = [
    {
      assertion =
        let
          fishIsDefault = config.homeModules.shell.fish.enable && config.homeModules.shell.fish.default;
          zshIsDefault = config.homeModules.shell.zsh.enable && config.homeModules.shell.zsh.default;
        in
        !(fishIsDefault && zshIsDefault);

      message = "Only one shell can be both enabled and set as default.";
    }
  ];
}
