# This Nix expression configures system features and monitors.
{
  inputs,
  lib,
  pkgs,
  ...
}: {
  # Specify imports for global configurations, desktop features, and games
  imports = [
    ./global
    ./features/desktop/gnome
    ./features/desktop/wireless
    #./features/productivity
    ./features/games
    ./features/music
  ];

  # Configure monitors
  monitors = [
    {
      name = "HDMI-1"; # Specify monitor name
      width = 1920; # Specify monitor width
      height = 1080; # Specify monitor height
      workspace = "1"; # Specify workspace for the monitor
      primary = true; # Specify if the monitor is primary
    }
  ];
}
