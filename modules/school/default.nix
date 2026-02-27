{ pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      anki-bin
      logisim-evolution
    ];
  };
}
