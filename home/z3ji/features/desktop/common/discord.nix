# This Nix expression configures vesktop, a better performing Discord for linux.
{
  config,
  pkgs,
  ...
}: {
  # Configure packages to be installed in the user's home environment
  home.packages = with pkgs; [vesktop];

  # Configure persistence settings for the user's home directory
  #home.persistence = {
  #  # Define a persistent directory for '.config/vesktop' within the user's home directory
  #  "/persist/home/${config.home.username}".directories = [".config/vesktop"];
  #};
}
