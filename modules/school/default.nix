{ pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      logisim-evolution
    ];
  };
}
