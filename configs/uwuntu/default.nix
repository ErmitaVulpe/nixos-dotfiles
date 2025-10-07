{ pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./nixos-hardware.nix
    ../../modules/defaults
    ../../modules/dm/ly
    ../../modules/wm/dwm
    ../../users/winter
    inputs.home-manager.nixosModules.default
  ];

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  users.users.root.initialHashedPassword = "$6$aS.0EG/z$7cgSogPyLF2IXtZmH7gn5CZaAWTDS3y71j1gnVh2m4MOgU9.AWtLmAjZIpn2TWcYuuM9HtJta/V3hg4xkPyT01";
  users.users.winter = {
    homeImports = [
      ../../home/bullshit
      ../../home/firefox
      ../../home/hyfetch
      ../../home/neovim
      ../../home/shell/fish
      ../../home/tmux
      ../../home/wallpapers/xenia
      ../../home/wezterm
    ];
    packages = with pkgs; [
      nixd
    ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "uwuntu"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.wireless.userControlled.enable = true;
  # networking.wireless.interfaces = [ "wlp0s20f3" ];
  # environment.etc."wpa_supplicant.conf".text = ''
  #   ctrl_interface=/run/wpa_supplicant
  #   ctrl_interface_group=wheel
  #   update_config=1
  # '';
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    touchpad = {
      accelProfile = "adaptive";
      accelSpeed = "-0.5";
      accelStepScroll = 0.1;
      accelPointsMotion = [6.0 7.0 14.0 30.0 70.0];
      accelStepMotion = 3;
      clickMethod = "clickfinger";
      naturalScrolling = true;
      tapping = false;
      additionalOptions = ''
        Option "ScrollPixelDistance" "30"
      '';
    };
  };

  # services.tlp.settings = {
  #     TLP_DEFAULT_MODE="balanced";
  #     TLP_PERSISTENT_DEFAULT=0;
  #     TLP_PS_IGNORE_SUBMODE_ON_AC=0;
  #     TLP_PS_IGNORE_SUBMODE_ON_BAT=0;
  #
  #     # --------- CPU Settings ---------
  #     CPU_SCALING_GOVERNOR_ON_AC="performance";
  #     CPU_SCALING_GOVERNOR_ON_BAT="powersave";
  #     CPU_ENERGY_PERF_POLICY_ON_AC="performance";
  #     CPU_ENERGY_PERF_POLICY_ON_BAT="power";
  #
  #     # Intel P-state (for newer Intel CPUs)
  #     CPU_HWP_ON_AC="balance_performance";
  #     CPU_HWP_ON_BAT="balance_power";
  #
  #     # --------- PCI Express Active State Power Management ---------
  #     PCIE_ASPM_ON_AC="performance";
  #     PCIE_ASPM_ON_BAT="power_supersave";
  #
  #     # --------- Runtime Power Management for PCI Devices ---------
  #     RUNTIME_PM_ON_AC="on";
  #     RUNTIME_PM_ON_BAT="auto";
  #
  #     # --------- USB Autosuspend ---------
  #     USB_AUTOSUSPEND=1;
  #     USB_BLACKLIST_BTUSB=0;
  #     USB_BLACKLIST_PHONE=1;
  #     USB_BLACKLIST_PRINTER=1;
  #
  #     # --------- WiFi Power Saving ---------
  #     WIFI_PWR_ON_AC="on";
  #     WIFI_PWR_ON_BAT="on";
  #
  #     # --------- Audio Power Saving ---------
  #     SOUND_POWER_SAVE_ON_AC=0;
  #     SOUND_POWER_SAVE_ON_BAT=10;
  #
  #     # --------- Graphics (Intel/NVIDIA/AMD Hybrid Support) ---------
  #     NVIDIA_PWRM="auto";
  #     NVIDIA_HYBRID_AUTO_DISABLE_GPU=1;
  #
  #     # --------- Platform Profile (if supported, e.g., modern ThinkPads, Dells) ---------
  #     PLATFORM_PROFILE_ON_AC="performance";
  #     PLATFORM_PROFILE_ON_BAT="balanced";
  # };

  # Swap and hibernation
  swapDevices = [{
    device = "/.swapfile";
    size = 32 * 1024; # 32GiB
  }];
  # These two need to be changed on a new system to work properly
  # https://nixos.wiki/wiki/Hibernation
  boot = {
    kernelParams = ["resume_offset=4161536"];
    resumeDevice = "/dev/disk/by-uuid/9177a52e-b785-48e3-9532-6d5d2ec31a90";
  };
  services = {
    logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchDocked = "ignore";
    };
    upower.enable = true;
  };
  systemd.sleep.extraConfig = "HibernateDelaySec=30min";

  users.mutableUsers = false;
  security.sudo.wheelNeedsPassword = false;

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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
