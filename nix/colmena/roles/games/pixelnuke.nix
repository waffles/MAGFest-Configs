{ config, pkgs, ... }:
{  
  imports = [ ./../xfce.nix ];
  users.users.magfest = {
    packages = with pkgs; [
        pixelnuke
    ];
  };
}