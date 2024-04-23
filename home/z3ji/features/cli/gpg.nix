# This Nix expression configures the GPG agent service, enables SSH support, and sets up GPG-related services and programs.
{
  pkgs,
  config,
  lib,
  ...
}: {
  # Configure the GPG agent service
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    #sshKeys = ["key"]; # TODO: Add SSH Key
    enableExtraSocket = true;

    # Choose the appropriate pinentry package based on the GTK configuration
    pinentryPackage =
      if config.gtk.enable
      then pkgs.pinentry-gnome3
      else pkgs.pinentry-curses;
  };

  # Install gcr package if GTK is enabled
  home.packages = lib.optional config.gtk.enable pkgs.gcr;

  programs = let
    # Define a function to fix GPG configuration
    fixGpg = ''
      gpgconf --launch gpg-agent
    '';
  in {
    # Add the GPG agent fix to bash and zsh profiles to ensure it starts when needed
    bash.profileExtra = fixGpg;
    zsh.loginExtra = fixGpg;

    # Configure GPG settings
    gpg = {
      enable = true;
      settings = {
        trust-model = "tofu+pgp";
      };
      # Configure public keys
      publicKeys = [
        {
          source = ../../pgp.asc; # Path to the PGP public key file
          trust = 5; # Trust level for the key
        }
      ];
    };
  };

  # Configure systemd user services to link gnupg sockets
  systemd.user.services = {
    link-gnupg-sockets = {
      Unit = {
        Description = "Link gnupg sockets from /run to /home";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.coreutils}/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets";
        ExecStop = "${pkgs.coreutils}/bin/rm $HOME/.gnupg-sockets";
        RemainAfterExit = true;
      };
      Install.WantedBy = ["default.target"];
    };
  };
}
