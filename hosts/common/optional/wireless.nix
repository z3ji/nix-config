# This Nix expression configures wireless networking and ensures the existence of a network group.
{
  # Import commonly used components from the input
  config,
  lib,
  pkgs,
  ...
}: {
  # Configure network manager
  networking.networkmanager = {
    enable = true;
  };

  # Ensure the existence of a networkmanager group
  users.groups.networkmanager = {};
}
