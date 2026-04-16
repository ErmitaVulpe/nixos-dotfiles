{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./nixos-hardware.nix
    ../../modules
    ../../users/winter
    inputs.home-manager.nixosModules.default
  ];

  nixosModules = {
    boot = {
      loader.systemd-boot.enable = true;
      plymouth = {
        enable = true;
        theme = "polishcow";
      };
    };
    defaults.desktop.enable = true;
    dm.ly.enable = true;
    dnscryptProxy.enable = true;
    firmware.enable = true;
    gaming.enable = true;
    kernel = "cachyos_dell_prec_5550";
    school.enable = true;
    ssh = {
      enable = true;
      onDemand = true;
    };
    swapFile = {
      enable = true;
      size = 32;
      resumeOffset = 4161536;
      resumeDeviceId = "9177a52e-b785-48e3-9532-6d5d2ec31a90";
    };
    tlp.enable = true;
    wm.dwm.enable = true;
    xmrig.onDemand = true;
  };

  users.users.root.initialHashedPassword = "$6$aS.0EG/z$7cgSogPyLF2IXtZmH7gn5CZaAWTDS3y71j1gnVh2m4MOgU9.AWtLmAjZIpn2TWcYuuM9HtJta/V3hg4xkPyT01";
  users.users.winter.config = {
    browser.zen-browser.enable = true;
    bullshit.enable = true;
    cursor = "phinger";
    element-desktop.enable = true;
    gtkTheme = "carbonfox";
    hyfetch.enable = true;
    iamb.enable = true;
    launcher.otter-launcher.enable = true;
    nixowos.enable = true;
    terminal.wezterm.enable = true;
    vesktop.enable = true;
    wallpaper = "xenia";
  };

  networking.hostName = "flareon"; # Define your hostname.
  networking.wireless.userControlled = true;
  networking.wireless.interfaces = [ "wlp0s20f3" ];
  environment.etc."wpa_supplicant.conf".text = ''
    ctrl_interface=/run/wpa_supplicant
    ctrl_interface_group=wheel
    update_config=1
  '';
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
    ];
  };
  # networking.networkmanager.wifi.powersave = false;
  # boot.extraModprobeConfig = ''
  #   options iwlwifi power_save=0
  #   options iwlwifi uapsd_disable=1
  # '';

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

  services = {
    logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchDocked = "ignore";
      HandlePowerKey = "hibernate";
    };
  };
  systemd.sleep.settings.Sleep = {
    HibernateDelaySec = "30min";
  };

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
