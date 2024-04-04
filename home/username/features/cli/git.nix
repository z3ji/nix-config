{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "01-username-goes-here-01"; # TODO: Add username
    userEmail = "email@address.com"; # TODO: Add email
    extraConfig = {
      init.defaultBranch = "main";
      user.signing.key = "key"; # TODO: Add Key
      commit.gpgSign = true;
      gpg.program = "${config.programs.gpg.package}/bin/gpg2";
    };
  };
}
