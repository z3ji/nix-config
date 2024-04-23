# This Nix expression configures auto-upgrade for NixOS systems.
{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  inherit (config.networking) hostName; # Extract hostname from networking configuration
  isClean = inputs.self ? rev; # Determine if the current config came from a clean tree
in {
  # Configure auto-upgrade settings
  system.autoUpgrade = {
    enable = isClean; # Only enable auto upgrade if the current config came from a clean tree
    dates = "weekly"; # Set auto-upgrade schedule to weekly
    flags = ["--refresh"]; # Specify additional flags for auto-upgrade
    #flake = "url"  # Optionally specify flake URL for auto-upgrade
  };

  # Configure NixOS upgrade service
  systemd.services.nixos-upgrade = lib.mkIf config.system.autoUpgrade.enable {
    serviceConfig.ExecCondition = lib.getExe (
      # Define script to check if the current config is older than the new one
      pkgs.writeShellScriptBin "check-date" ''
        lastModified() {
          nix flake metadata "$1" --refresh --json | ${lib.getExe pkgs.jq} '.lastModified'
        }
        test "$(lastModified "${config.system.autoUpgrade.flake}")"  -gt "$(lastModified "self")"
      ''
    );
  };
}
