{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.nixosModules.certbot = {
    enable = lib.mkEnableOption "automatic letsencrypt cert renewal";
  };

  config = lib.mkIf config.nixosModules.certbot.enable {
    systemd.services.certbot-renew = {
      description = "Certbot renewal";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.certbot}/bin/certbot renew -q";
      };
    };

    systemd.timers.certbot-renew = {
      description = "Weekly certbot renewal with jitter";
      wantedBy = [ "timers.target" ];

      timerConfig = {
        OnCalendar = "weekly";
        RandomizedDelaySec = "2h";
        Persistent = true;
        Unit = "certbot-renew.service";
      };
    };
  };
}
