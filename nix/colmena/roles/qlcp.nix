{ config, pkgs, ... }:
{  
  imports = [ ./xfce.nix ];
  users.users.magfest = {
    packages = with pkgs; [
        qlcplus
    ];
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    cifs-utils
    libusb
  ];
}