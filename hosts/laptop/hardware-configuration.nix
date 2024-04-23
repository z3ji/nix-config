# This Nix expression configures various boot, file system, and hardware settings.
{config, ...}: {
  # Define imports for optional configuration modules
  imports = [
    #../common/optional/ephemeral-btrfs.nix
  ];

  # Configure boot settings
  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
      kernelModules = [];
    };
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
    kernelModules = ["kvm-intel" "wl"];
    extraModulePackages = [config.boot.kernelPackages.broadcom_sta];
  };

  # Configure boot file system
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
  };

  # Configure root file system
  fileSystems."/" = {
    device = "/dev/disk/by-label/NixOS";
    fsType = "ext4";
  };


  # Configure swap devices
  swapDevices = [
    {
      #device = "/dev/disk/by-label/swap";
      device = "/dev/disk/by-uuid/a2da2c89-5707-41bd-bc94-5f97371b4e68";
    }
  ];

  # Specify host platform system
  nixpkgs.hostPlatform.system = "x86_64-linux";
  # Enable microcode update for Intel CPUs
  hardware.cpu.intel.updateMicrocode = true;
}
