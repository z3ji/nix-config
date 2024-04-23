# This Nix expression configures Steam and associated packages, as well as a custom Steam session for gaming.
{
  pkgs,
  lib,
  config,
  ...
}: let
  # Override Steam package with additional packages required for gaming
  steam-with-pkgs = pkgs.steam.override {
    extraPkgs = pkgs:
      with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
        gamescope
        mangohud
      ];
  };

  # Determine primary monitor
  monitor = lib.head (lib.filter (m: m.primary) config.monitors);

  # Define commands for launching Steam session
  steam-session = let
    gamescope = lib.concatStringsSep " " [
      (lib.getExe pkgs.gamescope)
      "--output-width ${toString monitor.width}"
      "--output-height ${toString monitor.height}"
      "--framerate-limit ${toString monitor.refreshRate}"
      "--expose-wayland"
      "--steam"
    ];
    steam = lib.concatStringsSep " " [
      "steam"
      "steam://open/bigpicture"
    ];
  in
    # Write a .desktop file for the Steam session
    pkgs.writeTextDir "share/wayland-sessions/steam-session.desktop" ''
      [Desktop Entry]
      Name=Steam Session
      Exec=${gamescope} -- ${steam}
      Type=Application
    '';
in {
  # Specify packages for the home environment
  home.packages = with pkgs; [
    steam-with-pkgs
    steam-session
    gamescope
    mangohud
    protontricks
  ];

  # Configure persistence settings for user's home directory
  #home.persistence = {
  #  "/persist/home/${config.home.username}" = {
  #    allowOther = true;
  #    directories = [
  #      ".factorio"
  #      ".config/Hero_Siege"
  #      ".config/unity3d/Berserk Games/Tabletop Simulator"
  #      ".config/unity3d/IronGate/Valheim"
  #      ".local/share/Tabletop Simulator"
  #      ".local/share/Paradox Interactive"
  #      ".paradoxlauncher"
  #      {
  # A couple of games don't play well with bindfs
  #        directory = ".local/share/Steam";
  #        method = "symlink";
  #      }
  #    ];
  #  };
  #};
}
