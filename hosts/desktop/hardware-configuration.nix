# This Nix expression configures various boot, file system, and hardware settings for a NixOS system.
{
  # Define imports for optional configuration modules
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    #../common/optional/ephemeral-btrfs.nix
  ];

  # Configure boot settings
  boot = {
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "sd_mod"];
      kernelModules = [];
    };
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
    kernelModules = ["kvm-amd"];
  };

  # Configure boot file systems
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };
  };

  # Configure root file system
  fileSystems."/" = {
    device = "/dev/disk/by-label/NixOS";
    fsType = "ext4";
  };

  # Configure swap devices
  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 8196;
    }
  ];

  # Specify host platform system
  nixpkgs.hostPlatform.system = "x86_64-linux";
  # Enable microcode update for AMD CPUs
  hardware.cpu.amd.updateMicrocode = true;
}
