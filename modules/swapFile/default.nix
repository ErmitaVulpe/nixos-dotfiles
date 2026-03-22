{
  config,
  lib,
  ...
}:
{
  options.nixosModules.swapFile = {
    enable = lib.mkEnableOption "Enables a swap file";
    path = lib.mkOption {
      type = lib.types.nonEmptyStr;
      default = "/.swapfile";
      description = "Path tpo the swap file";
    };
    size = lib.mkOption {
      type = lib.types.int;
      example = 16;
      description = "Size of the swap file in GiB";
    };
    resumeOffset = lib.mkOption {
      type = lib.types.int;
      example = 243924992;
      description = "Value for the `resume_offset` kernel param as defied in https://nixos.wiki/wiki/Hibernation";
    };
    resumeDeviceId = lib.mkOption {
      type = lib.types.nonEmptyStr;
      example = "2f0c63e6-3510-460f-ae4b-ce4827ac685e";
      description = "The device id as defied in https://nixos.wiki/wiki/Hibernation";
    };
  };

  config = lib.mkIf config.nixosModules.swapFile.enable {
    swapDevices = [
      {
        device = config.nixosModules.swapFile.path;
        size = config.nixosModules.swapFile.size * 1024;
      }
    ];
    boot = {
      kernelParams = [ "resume_offset=${lib.toString config.nixosModules.swapFile.resumeOffset}" ];
      resumeDevice = "/dev/disk/by-uuid/${config.nixosModules.swapFile.resumeDeviceId}";
    };
  };
}
