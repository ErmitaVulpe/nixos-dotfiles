{
  inputs,
  modulesPath,
  ...
}:
let
  sshKey = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDPoQGTiDw1qAfDNMqcUeASutUIM0sRQolUpR/fjBKwcfjTF7C+SKfNi5xYaVXWdCWuPtASc9ZylcI/vyAc/luikCKiE1RsvyUcRjNkQE6WffV3Id65xqTNxmESWBJV+blvdShoH/rvw4djGJZWIHCPn9LR03MCnod7c2uxXMvhzbwptNaxUwb8W9nXUJwOnUJCF8NWL8Ek+HS9e0LPLL0eRX4yIfSCt74A2obejmOKm8l1cPEkKAYN7+nYPFTC/4rQNwkqULjfjA33ZEF1EPb+WPsDp71yXcL7sVLD+WgVAxSp58QKPts3RfGIYDBHvWmw6mNLTI41kxreyZ/ayDF7B3e40KvEr0HhlT7Jl8T+PH67r6cU3eqeGm5v5YfdZN8BO2AvAsKw154x4/T+VyrrSc1T672PbZtpB4h/MhkL2Z0ZjA52ZcaALtV72HS7zpsTK1swqr/iqklfG9dbn1Z5qgu+z6Qs1MjaZ6dVDrO5c90jN8s4u/Oso664mBQobGE= winter@DESKTOP-83KNC3S"
  ];
in
{
  imports = [
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.default
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
    ../../modules
    ../../users/winter
  ];

  nixosModules = {
    nixowos.enable = true;
    ssh.enable = true;
    xmrig = {
      enable = true;
      background = true;
      onDemand = true;
    };
  };

  users.users.root.initialHashedPassword = "$6$aS.0EG/z$7cgSogPyLF2IXtZmH7gn5CZaAWTDS3y71j1gnVh2m4MOgU9.AWtLmAjZIpn2TWcYuuM9HtJta/V3hg4xkPyT01";
  users.users.root.openssh.authorizedKeys.keys = sshKey;
  users.users.winter = {
    config = {
      bullshit.enable = true;
      hyfetch.enable = true;
      nixowos.enable = true;
    };
    openssh.authorizedKeys.keys = sshKey;
  };

  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  networking.hostName = "vhost1";

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
  system.stateVersion = "24.11"; # Did you read the comment?
}
