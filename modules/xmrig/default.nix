{ config, lib, ... }:
{
  services.xmrig = {
    enable = true;
    settings = {
      api = {
        id = null;
        worker-id = null;
      };
      http = {
        enabled = false;
        host = "127.0.0.1";
        port = 0;
        access-token = null;
        restricted = true;
      };
      autosave = true;
      version = 1;
      background = false;
      colors = false;
      randomx = {
        init = -1;
        numa = true;
      };
      cpu = {
        enabled = true;
        huge-pages = true;
        memory-pool = true;
        max-threads-hint = 100;
        asm = true;

        intensity = 2;
        threads = 16;
        affinity = -1;
      };
      donate-level = 1;
      donate-over-proxy = 1;
      log-file = null;
      pools = [
        {
          algo = null;
          coin = null;
          url = "pool.hashvault.pro:443";
          user = "45uuAdfoUhSEKLJCNH5Xd9Z7tpKoRhaTodviBPowpSm6Pb9S7vhsP6c37CiDKNHYv4B4k3K5JuZ9VL59AeCmwifN34zotiz";
          pass = config.networking.hostName;
          rig-id = null;
          nicehash = false;
          keepalive = false;
          enabled = true;
          tls = true;
          tls-fingerprint = "420c7850e09b7c0bdcf748a7da9eb3647daf8515718f36d9ccfdd6b9ff834b14";
          daemon = false;
          self-select = null;
        }
      ];
      print-time = 60;
      health-print-time = 60;
      retries = 5;
      retry-pause = 5;
      syslog = false;
      user-agent = null;
      watch = true;
    };
  };
  systemd.services.xmrig.wantedBy = lib.mkForce [ ];
}
