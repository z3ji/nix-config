# This Nix expression imports configurations for Lutris and Steam and specifies additional packages for the home environment.
{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./lutris.nix
    ./steam.nix
  ];

  # Specify packages for the home environment
  home = {
    packages = with pkgs; [gamescope]; # Include gamescope package
    #persistence = {
    # Configure persistence settings for user's home directory
    #  "/persist/home/${config.home.username}" = {
    #    allowOther = true;
    #    directories = [
    #      {
    # Use symlink for games directory to avoid IO-heavy operations
    #        directory = "Games";
    #        method = "symlink";
    #      }
    #    ];
    #  };
    #};
  };
}
