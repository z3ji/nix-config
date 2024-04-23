# This Nix expression configures GameMode to optimize system performance for gaming.
{
  programs.gamemode = {
    enable = true; # Enable GameMode
    settings = {
      general = {
        softrealtime = "on"; # Enable soft realtime mode
        inhibit_screensaver = 1; # Inhibit screensaver
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility"; # Apply GPU optimizations
        gpu_device = 0; # GPU device index
        amd_performance_level = "high"; # Set AMD performance level to high
      };
    };
  };
}
