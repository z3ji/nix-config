{
  imports = [
    ../common/optional/ephemeral-btrfs.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "sd_mod"];
      kernelModules = ["kvm-amd"];
    };
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
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
  #  device = "/dev/disk/by-uuid/3dca0182-38bb-4787-b567-6b8989c3e6c3";
  #  fsType = "ext4";
  #};

  nixpkgs.hostPlatform.system = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;
}
