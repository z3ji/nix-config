# This Nix expression configures a NixOS system for a desktop.
{
  # Import commonly used components from the input
  pkgs,
  inputs,
  lib,
  ...
}: {
  # Define imports for various hardware and configuration modules
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/z3ji # FIXME: change file structure
    ../common/optional/gamemode.nix
    ../common/optional/pipewire.nix
    ../common/optional/steam-hardware.nix
  ];

  # Configure networking settings
  networking = {
    hostName = "desktop";
    useDHCP = lib.mkForce true;
  };

  # Configure boot settings
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Configure OpenGL settings for hardware acceleration
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Set system state version
  system.stateVersion = "23.11";
}
