{config, ...}: {
  imports = [
    ../common/optional/ephemeral-btrfs.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
      kernelModules = ["kvm-intel" "wl"];
    };
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
    extraModulePackages = [config.boot.kernelPackages.broadcom_sta];
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/ESP";
      fsType = "vfat";
    };
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 8196;
    }
  ];

  #fileSystems."/" = {
  #  device = "/dev/disk/by-uuid/be1b8adc-4e64-4b6a-a213-1f9f2f4b0044";
  #  fsType = "ext4";
  #};

  nixpkgs.hostPlatform.system = "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = true;
}
