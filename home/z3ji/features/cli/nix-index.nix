# This Nix expression configures the nix-index tool to index Nix packages and sets up a systemd user service and timer to automatically sync the nix-index database.
{
  pkgs,
  lib,
  ...
}: {
  # Enable the nix-index program
  programs.nix-index.enable = true;

  # Configure systemd user service to fetch the nix-index database
  systemd.user.services.nix-index-database-sync = {
    Unit.Description = "Fetch Mic92/nix-index-database";
    Service = {
      Type = "oneshot";
      # Define the command to fetch the nix-index database using wget
      ExecStart = lib.getExe (pkgs.writeShellApplication {
        name = "fetch-nix-index-database";
        runtimeInputs = with pkgs; [wget coreutils];
        text = ''
          mkdir -p ~/.cache/nix-index
          cd ~/.cache/nix-index
          name="index-${pkgs.stdenv.system}"
          # Download the latest nix-index database release from Mic92's GitHub repository
          wget -N "https://github.com/Mic92/nix-index-database/releases/latest/download/$name"
          ln -sf "$name" "files"
        '';
      });
      # Restart the service on failure with a 5-minute delay
      Restart = "on-failure";
      RestartSec = "5m";
    };
  };

  # Configure systemd user timer to periodically sync the nix-index database
  systemd.user.timers.nix-index-database-sync = {
    Unit.Description = "Automatic GitHub: Mic92/nix-index-database fetching";
    Timer = {
      # Start the timer 10 minutes after boot and then every 24 hours
      OnBootSec = "10m";
      OnUnitActiveSec = "24h";
    };
    # Install the timer to be wanted by the timers.target
    Install.WantedBy = ["timers.target"];
  };
}
