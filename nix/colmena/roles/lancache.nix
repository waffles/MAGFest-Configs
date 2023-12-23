{ config, pkgs, lib,  ... }:
{
 
  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
    #   defaultNetwork.settings.dns_enabled = true;
      defaultNetwork.settings = {
            dns_enabled = true;
            driver = "bridge";
            id = "0000000000000000000000000000000000000000000000000000000000000000";
            internal = false;
            ipam_options = { driver = "host-local"; };
            ipv6_enabled = false;
            name = "podman";
            network_interface = "podman0";
            subnets = [{ gateway = "10.87.0.1"; subnet = "10.87.0.0/16"; }];
            } ;
    };
    
    oci-containers.containers = {
      lancachenet-monolithic = {
      image = "lancachenet/monolithic:latest";
      ports = [ "80:80" "443:443" ];
      volumes = [
          "/cache/data:/data/cache"
          "/cache/logs:/data/logs"
        ];
      };
    };
  };
}