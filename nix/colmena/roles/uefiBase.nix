{ config, pkgs, ... }:
{
  imports = [ ./base.nix ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}