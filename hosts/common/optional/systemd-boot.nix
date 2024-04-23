# This Nix expression configures the systemd-boot loader and enables touching EFI variables.
{
  boot.loader = {
    systemd-boot = {
      enable = true; # Enable systemd-boot loader
      consoleMode = "max"; # Set console mode to "max"
    };
    efi.canTouchEfiVariables = true; # Enable touching EFI variables
  };
}
