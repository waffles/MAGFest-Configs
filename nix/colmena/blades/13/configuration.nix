{ config, pkgs, ... }:
{
  imports =
  [
    ../hardware-configuration.nix
    ../g8-network.nix
  ];


  networking.hostName = "maglan-srv-13";
}
