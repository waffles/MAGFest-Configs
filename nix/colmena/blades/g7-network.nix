{ config, pkgs, ... }:
{
  systemd.network.links."10-mgt" = {
    matchConfig.Property = "ID_PATH=pci-0000:02:00.0";
    linkConfig.Name = "mgt0";
  };

  systemd.network.links."10-lan" = {
    matchConfig.Property = "ID_PATH=pci-0000:02:00.1";
    linkConfig.Name = "lan0";
  };   
}
