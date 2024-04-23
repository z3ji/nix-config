# This Nix expression configures a NixOS system for a laptop.
{
  # Import commonly used components from the input
  pkgs,
  inputs,
  lib,
  ...
}: {
  # Define imports for various hardware and configuration modules
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/z3ji # FIXME: change file structure
    ../common/optional/pipewire.nix
  ];

  # Configure networking settings
  networking = {
    hostName = "laptop";
    useDHCP = lib.mkForce true;
  };

  # Configure boot settings
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_6;

  # Enable webcam
  hardware.facetimehd.enable = true;

  # Set system state version
  system.stateVersion = "23.11";
}
