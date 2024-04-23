# This Nix expression configures the GitHub CLI (gh) and sets up persistence for its configuration.
{pkgs, ...}: {
  programs.gh = {
    enable = true;
    extensions = with pkgs; [gh-markdown-preview];
    settings = {
      version = "1";
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };

  # Configure persistence settings for the user's home directory
  #home.persistence = {
  #  "/persist/home/${config.home.username}".directories = [
  #    ".config/gh" # Define a persistent directory for '.config/gh'
  #  ];
  #};
}
