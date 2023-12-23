{ config, lib, pkgs, modulesPath, ... }:
{
  boot.initrd.availableKernelModules = [ "ehci_pci" "uhci_hcd" "hpsa" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/sda1";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/sda2"; }
    ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.enableRedistributableFirmware = lib.mkDefault true;

  system.stateVersion = "23.05"; # Did you read the comment?
}
