# This Nix expression configures Xserver flags to adjust power management settings.
{
  services.xserver.serverFlagsSection = ''
    Option "StandbyTime" "0"
    Option "SuspendTime" "0"
    Option "OffTime" "0"
  '';
}
