{
  config,
  lib,
  ...
}:
{
  options.nixosModules.ssh = {
    enable = lib.mkEnableOption "Enables the ssh daemon";
    onDemand = lib.mkEnableOption "Weather ssh daemon should require manual start";
    ports = lib.mkOption {
      type = lib.types.listOf lib.types.port;
      default = [ 22 ];
      description = ''
        Specifies on which ports the SSH daemon listens.
      '';
    };
  };

  config = lib.mkIf config.nixosModules.ssh.enable {
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        UseDns = true;
        PasswordAuthentication = true;
      };
    };
    systemd.services.sshd.wantedBy = lib.mkIf config.nixosModules.ssh.onDemand (lib.mkForce [ ]);
  };
}
