{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.nixosModules.audio = {
    enable = lib.mkEnableOption "Enables system audio";
  };

  config = lib.mkIf config.nixosModules.audio.enable {
    environment.systemPackages = with pkgs; [
      pamixer
      wiremix
    ];

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # jack.enable = true;
    };
  };
}
