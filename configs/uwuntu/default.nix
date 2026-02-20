{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./nixos-hardware.nix
    ../../modules/audio
    ../../modules/dconf
    ../../modules/defaults
    ../../modules/defaults/desktop
    ../../modules/dm/ly
    ../../modules/firmware
    ../../modules/fwupd
    ../../modules/gaming
    ../../modules/kernel/cachyos_dell_prec_5550
    ../../modules/nixowos
    ../../modules/school
    ../../modules/wm/dwm
    ../../users/winter
    inputs.home-manager.nixosModules.default
  ];

  users.users.root.initialHashedPassword = "$6$aS.0EG/z$7cgSogPyLF2IXtZmH7gn5CZaAWTDS3y71j1gnVh2m4MOgU9.AWtLmAjZIpn2TWcYuuM9HtJta/V3hg4xkPyT01";
  users.users.winter = {
    homeImports = [
      ../../home/bullshit
      ../../home/cursors/phinger
      ../../home/firefox
      ../../home/gtk/carbonfox
      ../../home/hyfetch
      ../../home/neovim
      ../../home/shell/fish
      ../../home/tmux
      ../../home/vesktop
      ../../home/wallpapers/xenia
      ../../home/wezterm
    ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "uwuntu"; # Define your hostname.
  networking.wireless.userControlled = true;
  networking.wireless.interfaces = [ "wlp0s20f3" ];
  environment.etc."wpa_supplicant.conf".text = ''
    ctrl_interface=/run/wpa_supplicant
    ctrl_interface_group=wheel
    update_config=1
  '';
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
  boot.extraModprobeConfig = ''
    options iwlwifi power_save=0
    options iwlwifi uapsd_disable=1
  '';

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    touchpad = {
      accelProfile = "custom";
      accelSpeed = "0";
      accelPointsScroll = [
        0
        0.5
        1.2
        1.25
      ];
      accelStepScroll = 3;
      accelPointsMotion = [
        0
        0.33
        1.5
        2
        3.75
        5.5
      ];
      accelStepMotion = 2.5;
      clickMethod = "clickfinger";
      naturalScrolling = true;
      tapping = false;
      additionalOptions = ''
        Option "ScrollPixelDistance" "10"
      '';
    };
  };

  # Custom settings for X11
  services.xserver = {
    videoDrivers = [
      "modesetting"
      "nvidia"
    ];
  };

  # Swap and hibernation
  swapDevices = [
    {
      device = "/.swapfile";
      size = 32 * 1024; # 32GiB
    }
  ];
  # These two need to be changed on a new system to work properly
  # https://nixos.wiki/wiki/Hibernation
  boot = {
    kernelParams = [ "resume_offset=4161536" ];
    resumeDevice = "/dev/disk/by-uuid/9177a52e-b785-48e3-9532-6d5d2ec31a90";
  };
  services = {
    logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchDocked = "ignore";
      HandlePowerKey = "hibernate";
    };
    upower.enable = true;
  };
  systemd.sleep.extraConfig = "HibernateDelaySec=30min";

  users.mutableUsers = false;
  security.sudo.wheelNeedsPassword = false;

  # System groups
  users.groups = {
    network = { };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.nh = {
    enable = true;
    flake = "/home/winter/nixos-dotfiles";
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
