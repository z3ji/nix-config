# This Nix expression configures Git and sets up additional configurations including default branch, GPG signing, and GPG program.
{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.git = {
    enable = true; # Enable Git

    # Set up additional Git configurations
    extraConfig = {
      init.defaultBranch = "main";
      commit.gpgSign = true;
      gpg.program = "${config.programs.gpg.package}/bin/gpg2";
    };
  };
}
