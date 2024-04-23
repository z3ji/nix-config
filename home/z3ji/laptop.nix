# This Nix expression configures system features and monitors.
{
  inputs,
  lib,
  pkgs,
  ...
}: {
  # Specify imports for global configurations and desktop features
  imports = [
    ./global
    ./features/desktop/gnome
    ./features/desktop/wireless
    #./features/productivity
    ./features/music
  ];

  # Configure monitors
  monitors = [
    {
      name = "Retina"; # Specify monitor name
      width = 2156; # Specify monitor width
      height = 1600; # Specify monitor height
      workspace = "1"; # Specify workspace for the monitor
      primary = true; # Specify if the monitor is primary
    }
  ];
}
