{ config, ... }:
{
  imports = [
    ./ly
  ];

  assertions = [
    {
      assertion =
        let
          dms = [
            config.nixosModules.dm.ly.enable
          ];
        in
        builtins.length (builtins.filter (x: x) dms) <= 1;

      message = "Only one display manager can be enabled at a time.";
    }
  ];
}
