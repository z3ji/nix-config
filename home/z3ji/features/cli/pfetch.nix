# This Nix expression installs the pfetch package and sets session variables for pfetch configuration.
{pkgs, ...}: {
  home = {
    # Install pfetch package
    packages = with pkgs; [pfetch];
    # Set session variables for pfetch configuration
    sessionVariables.PF_INFO = "ascii title os kernel uptime shell term desktop scheme palette";
  };
}
