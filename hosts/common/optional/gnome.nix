# This Nix expression configures various services, overlays, and environment packages for a GNOME desktop environment.
{
  services = {
    # Configure Xserver services
    xserver = {
      # Configure GNOME desktop manager
      desktopManager.gnome = {
        enable = true;
      };
      # Configure GDM display manager
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };
    };
    # Enable GNOME Games
    gnome.games.enable = true;
    # Disable Avahi service
    avahi.enable = false;
  };

  # Define overlays for GNOME packages
  nixpkgs.overlays = [
    (final: prev: {
      gnome = prev.gnome.overrideScope' (gnomeFinal: gnomePrev: {
        mutter = gnomePrev.mutter.overrideAttrs (old: {
          src = pkgs.fetchgit {
            url = "https://gitlab.gnome.org/vanvugt/mutter.git";
            rev = "0b896518b2028d9c4d6ea44806d093fd33793689";
            sha256 = "sha256-mzNy5GPlB2qkI2KEAErJQzO//uo8yO0kPQUwvGDwR4w=";
          };
        });
      });
    })
  ];

  # Define system packages for the environment
  environment.systemPackages =
    (with pkgs; [
      adw-gtk3
      gnome.gnome-tweaks
      gnome-extension-manager
    ])
    ++ (with pkgs.gnomeExtensions; [
      appindicator
      blur-my-shell
      just-perfection
      legacy-gtk3-theme-scheme-auto-switcher
      night-theme-switcher
      noannoyance-fork
      rounded-corners
      #rounded-window-corners
    ]);

  # Exclude packages from GNOME environment
  environment.gnome.excludePackages =
    (with pkgs; [
      #gnome-tour
    ])
    ++ (with pkgs.gnome; [
      #atomix
      #cheese
      #epiphany
      #hitori
      #iagno
      #tali
    ]);
}
