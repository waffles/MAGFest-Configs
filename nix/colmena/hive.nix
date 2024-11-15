  let 
    blade02 = { config, pkgs, ...}: { imports=[ ./blades/02/configuration.nix ./roles/biosBase.nix ]; deployment.targetHost = "10.13.254.232"; };
    blade03 = { config, pkgs, ...}: { imports=[ ./blades/03/configuration.nix ./roles/biosBase.nix ]; deployment.targetHost = "10.13.254.233"; };
    blade04 = { config, pkgs, ...}: { imports=[ ./blades/04/configuration.nix ./roles/biosBase.nix ]; deployment.targetHost = "10.13.254.234"; };
    blade05 = { config, pkgs, ...}: { imports=[ ./blades/05/configuration.nix ./roles/biosBase.nix ]; deployment.targetHost = "10.13.254.235"; };
    blade06 = { config, pkgs, ...}: { imports=[ ./blades/06/configuration.nix ./roles/biosBase.nix ]; deployment.targetHost = "10.13.254.236"; };
    blade09 = { config, pkgs, ...}: { imports=[ ./blades/09/configuration.nix ./roles/biosBase.nix ]; deployment.targetHost = "10.13.254.239"; };
    blade10 = { config, pkgs, ...}: { imports=[ ./blades/10/configuration.nix ./roles/biosBase.nix ]; deployment.targetHost = "10.13.254.240"; };
    blade11 = { config, pkgs, ...}: { imports=[ ./blades/11/configuration.nix ./roles/biosBase.nix ]; deployment.targetHost = "10.13.254.241"; };
    blade12 = { config, pkgs, ...}: { imports=[ ./blades/12/configuration.nix ./roles/biosBase.nix ]; deployment.targetHost = "10.13.254.242"; };
    blade13 = { config, pkgs, ...}: { imports=[ ./blades/13/configuration.nix ./roles/biosBase.nix ]; deployment.targetHost = "10.13.254.243"; };
    blade14 = { config, pkgs, ...}: { imports=[ ./blades/14/configuration.nix ./roles/biosBase.nix ]; deployment.targetHost = "10.13.254.244"; };
    blade15 = { config, pkgs, ...}: { imports=[ ./blades/15/configuration.nix ./roles/biosBase.nix ]; deployment.targetHost = "10.13.254.245"; };
    blade16 = { config, pkgs, ...}: { imports=[ ./blades/16/configuration.nix ./roles/biosBase.nix ]; deployment.targetHost = "10.13.254.246"; };

    k8sMaster = { config, pkgs, ... }:{imports = [ ./roles/k8s-master.nix ];  };
    k8sNode = { config, pkgs,... }:{ imports = [ ./roles/k8s-node.nix ]; };
    podman = { config, pkgs,... }:{ imports = [ ./roles/podman.nix ]; };  
    lancache = { config, pkgs,... }:{ imports = [ ./roles/lancache.nix ]; };
    qlcp = { config, pkgs,... }:{ imports = [ ./roles/qlcp.nix ]; };

    # games
    pixelnuke = { config, pkgs,... }:{ imports = [ ./roles/games/pixelnuke.nix ]; };
    steamcmd = { config, pkgs,... }:{ imports = [ ./roles/games/steamcmd.nix ]; };
    openttd = { config, pkgs,... }:{ imports = [ ./roles/games/openttd.nix ]; };
  in
  {
    blade02 = { imports = [ blade02 k8sNode ]; }; # hold for lancache
    blade03 = { imports = [ blade03 ]; }; 
    blade04 = { imports = [ blade04 ]; }; 
    blade05 = { imports = [ blade05 k8sNode qlcp ]; }; # lights controller
    blade06 = { imports = [ blade06 podman pixelnuke ]; }; # pixelflut
    blade09 = { imports = [ blade09 steamcmd ]; }; # spare
    blade10 = { imports = [ blade10 steamcmd ]; }; # spare
    # blade11 = { imports = [ blade11 steamcmd ]; }; # windows
    blade12 = { imports = [ blade12 steamcmd ]; };  # project zomboid
    blade13 = { imports = [ blade13 podman steamcmd ]; }; # cs2
    blade14 = { imports = [ blade14 openttd ]; }; # openttd
    blade15 = { imports = [ blade15 steamcmd ]; }; # satisfactory
    blade16 = { imports = [ blade16 k8sMaster ]; }; # hold for k8s master

    meta = {
      name = "magfest lan";
      nixpkgs = import (builtins.fetchGit {
        name = "nixos-23.11-2023-12-18";
        url = "https://github.com/NixOS/nixpkgs";
        ref = "refs/heads/nixos-23.11";
        rev = "c1be43e8e837b8dbee2b3665a007e761680f0c3d";
      }) {};
    };
  }