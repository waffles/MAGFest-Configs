{ config, pkgs, ... }:
let
  kubeMasterHostname = "k8s.mgt.lan.magfest.net";
  kubeMasterAPIServerPort = 6443;
  kubeMasterIP = "10.13.254.246";
in
{
  # networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";
  # packages for administration tasks
  environment.systemPackages = with pkgs; [
    kompose
    kubectl
    kubernetes
  ];

  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = kubeMasterHostname;
    apiserverAddress = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
    easyCerts = true;
    apiserver = {
      securePort = kubeMasterAPIServerPort;
      advertiseAddress = kubeMasterIP;
    };

    path = with pkgs; [
      openiscsi
      e2fsprogs
    ];

    # use coredns
    addons.dns.enable = true;

    # needed if you use swap
    kubelet.extraOpts = "--fail-swap-on=false";
    clusterCidr = "10.12.0.0/16";
    proxy.extraOpts = "--ipvs-strict-arp";
  };
}
