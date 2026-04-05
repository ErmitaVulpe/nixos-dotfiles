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
      grub.enable = true;
      grub.theme = "bsol";
      multiBoot = true;
    };
    defaults.desktop.enable = true;
    dm.ly.enable = true;
    dnscryptProxy.enable = true;
    firmware.enable = true;
    gaming.enable = true;
    kernel = "cachyos_zen4";
    school.enable = true;
    spotify.enable = true;
    ssh = {
      enable = true;
      onDemand = true;
    };
    swapFile = {
      enable = true;
      size = 16;
      resumeOffset = 243924992;
      resumeDeviceId = "2f0c63e6-3510-460f-ae4b-ce4827ac685e";
    };
    tlp.enable = true;
    wm.dwm.enable = true;
    wm.niri.enable = true;
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
    niri.enable = true;
    terminal.wezterm.enable = true;
    vesktop.enable = true;
    wallpaper = "xenia";
  };

  networking.hostName = "sylveon"; # Define your hostname.
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
    ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
  };

  # Custom settings for X11
  services.xserver = {
    videoDrivers = [
      # "modesetting"
      "nvidia"
    ];
  };

  services = {
    logind.settings.Login = {
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
  system.stateVersion = "25.11"; # Did you read the comment?
}
