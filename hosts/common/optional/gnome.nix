{
  services = {
    xserver = {
      desktopManager.gnome = {
        enable = true;
      };
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };
    };
    gnome.games.enable = true;
  };

  services.avahi.enable = false;
  networking.networkmanager.enable = true;
}
