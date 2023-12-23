
{ config, pkgs, lib, ... }:
{
  users.users.magfest = {
    packages = with pkgs; [
        steamcmd
    ];
  };
}