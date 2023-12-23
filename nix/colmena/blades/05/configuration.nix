{ config, pkgs, ... }:
{
  imports =
  [
    ../hardware-configuration.nix
    ../g7-network.nix
  ];

  networking.hostName = "maglan-srv-05";
}
