# This Nix expression configures packages for the home environment and enables fluidsynth service.
{pkgs, ...}: {
  # Specify packages for the home environment
  home.packages = with pkgs; [alsa-utils];

  # Configure fluidsynth service
  services.fluidsynth = {
    enable = true;
    soundService = "pipewire-pulse";
    extraOptions = ["-g 2"];
  };
}
