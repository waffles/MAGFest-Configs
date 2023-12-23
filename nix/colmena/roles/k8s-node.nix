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

  services.kubernetes = let
    api = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
  in
  {
    roles = ["node"];
    masterAddress = kubeMasterHostname;
    easyCerts = true;

    path = with pkgs; [
      openiscsi
      e2fsprogs
    ];

    # point kubelet and other services to kube-apiserver
    kubelet.kubeconfig.server = api;
    apiserverAddress = api;

    # use coredns
    addons.dns.enable = true;

    # needed if you use swap
    kubelet.extraOpts = "--fail-swap-on=false";
    clusterCidr = "10.12.0.0/16";
    proxy.extraOpts = "--ipvs-strict-arp";
    };
}