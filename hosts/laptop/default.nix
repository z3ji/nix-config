{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/username # TODO: Change username
  ];

  networking = {
    hostName = "laptop";
    useDHCP = true;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_6_6;
  };

  system.stateVersion = "23.11";
}
