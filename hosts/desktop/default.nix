{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/username # TODO: Change username
  ];

  networking = {
    hostName = "desktop";
    useDHCP = true;
  };

  system.stateVersion = "23.11";
}
