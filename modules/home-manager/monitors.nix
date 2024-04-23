# This Nix expression defines options and configurations for monitors.
{
  # Import commonly used components from the input
  lib,
  config,
  ...
}: let
  # Inherit commonly used functions from lib
  inherit (lib) mkOption types;
  # Access the monitors configuration from the input
  cfg = config.monitors;
in {
  # Define options for monitors
  options.monitors = mkOption {
    type = types.listOf (types.submodule {
      options = {
        # Option for monitor name
        name = mkOption {
          type = types.str;
          example = "HDMI";
        };
        # Option for setting monitor as primary
        primary = mkOption {
          type = types.bool;
          default = false;
        };
        # Option for monitor width
        width = mkOption {
          type = types.int;
          example = 1920;
        };
        # Option for monitor height
        height = mkOption {
          type = types.int;
          example = 1080;
        };
        # Option for monitor refresh rate
        refreshRate = mkOption {
          type = types.int;
          default = 60;
        };
        # Option for monitor x-coordinate
        x = mkOption {
          type = types.int;
          default = 0;
        };
        # Option for monitor y-coordinate
        y = mkOption {
          type = types.int;
          default = 0;
        };
        # Option for enabling/disabling the monitor
        enabled = mkOption {
          type = types.bool;
          default = true;
        };
        # Option for assigning workspace to the monitor
        workspace = mkOption {
          type = types.nullOr types.str;
          default = null;
        };
      };
    });
    default = [];
  };
  # Define assertions for monitor configurations
  config = {
    assertions = [
      {
        assertion =
          ((lib.length config.monitors) != 0)
          -> ((lib.length (lib.filter (m: m.primary) config.monitors)) == 1);
        message = "Exactly one monitor must be set to primary.";
      }
    ];
  };
}
