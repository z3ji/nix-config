# This Nix expression configures an ephemeral Btrfs root configuration.
# It sets up the Btrfs file systems and systemd service for root rollback.
{
  lib,
  config,
  ...
}: let
  # Extract hostname from networking configuration
  hostname = config.networking.hostName;
  # Script to wipe and restore root subvolume
  wipeScript = ''
    mkdir /tmp -p
    MNTPOINT=$(mktemp -d)
    (
      mount -t btrfs -o subvol=/ /dev/disk/by-label/${hostname} "$MNTPOINT"
      trap 'umount "$MNTPOINT"' EXIT

      echo "Creating needed directories"
      mkdir -p "$MNTPOINT"/persist/var/{log,lib/{nixos,systemd}}

      echo "Cleaning root subvolume"
      btrfs subvolume list -o "$MNTPOINT/root" | cut -f9 -d ' ' |
      while read -r subvolume; do
        btrfs subvolume delete "$MNTPOINT/$subvolume"
      done && btrfs subvolume delete "$MNTPOINT/root"

      echo "Restoring blank subvolume"
      btrfs subvolume snapshot "$MNTPOINT/root-blank" "$MNTPOINT/root"
    )
  '';
  # Check if systemd is enabled in the initrd
  phase1Systemd = config.boot.initrd.systemd.enable;
in {
  boot.initrd = {
    # Specify supported file systems for the initrd
    supportedFilesystems = ["btrfs"];
    # Run the wipeScript before mounting root if systemd is not enabled in the initrd
    postDeviceCommands = lib.mkIf (!phase1Systemd) (lib.mkBefore wipeScript);
    # Configure systemd service to restore root subvolume
    systemd.services.restore-root = lib.mkIf phase1Systemd {
      description = "Rollback btrfs rootfs";
      wantedBy = ["initrd.target"];
      requires = [
        "dev-disk-by\\x2dlabel-${hostname}.device"
      ];
      after = [
        "dev-disk-by\\x2dlabel-${hostname}.device"
      ];
      before = ["sysroot.mount"];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = wipeScript;
    };
  };

  # Configure Btrfs file systems
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = ["subvol=root" "compress=zstd"];
    };

    "/nix" = {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = ["subvol=nix" "noatime" "compress=zstd"];
    };

    "/persist" = {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = ["subvol=persist" "compress=zstd"];
      neededForBoot = true;
    };

    "/swap" = {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = ["subvol=swap" "noatime"];
    };
  };
}
