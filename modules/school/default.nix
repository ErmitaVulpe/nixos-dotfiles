{ pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      anki
      logisim-evolution
    ];
  };
}
